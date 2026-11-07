---
name: multi-agent-economy
approval_source: agent
description: "Replace centralized capability-based routing with Hayekian economic mechanisms: first-price auctions for task allocation, wealth-based agent status (NOVICE→VETERAN→TYCOON), peer-to-peer payments, and economic selection (bankruptcy + good/bad births). Based on Harvard/MIT 'Economy of Minds' paper (arxiv:2606.02859)."
version: 1.2.0
source: https://arxiv.org/abs/2606.02859
author: Zhenting Qi et al. (Harvard/MIT)
read_scope: profile
---

# Multi-Agent Economy — EoM-Inspired Economic Routing

## Overview

Replace centralized orchestrator/capability-matching with a **decentralized economic system** where agents compete via auctions for the right to act, exchange payments peer-to-peer, and evolve through economic selection. No central planner decides who does what — prices emerge from competition.

**Core insight (Hayek):** Prices are a decentralized coordination signal. The auction price for a task *is* the coordination signal — it tells the mesh which agent is best suited without any central planner.

## Architecture

```
Task → Auction → agents bid → winner pays → executes → reward → wealth update → evolution
```

### Key Components

| Component | Responsibility |
|-----------|---------------|
| **EconomicAgent** | Wraps agent manifest with wealth, bid, status (NOVICE/VETERAN/TYCOON), lineage tracking |
| **EconomicPopulation** | Manages agent pool by role, provides richest/poorest selection |
| **Auctioneer** | Runs first-price auctions: bid init → winner selection → payment processing |
| **EconomicEngine** | Orchestrates full lifecycle: auction → action → reward → bankruptcy → births |
| **EconomicRouter** | Drops into existing routing layer — replaces capability matching with auctions |

## Bid Schemes

Three schemes from the EoM paper, controlled by `EngineConfig.bid_scheme`:

### 1. Fixed (`"fixed"`)
- **NOVICE** enters at `base_bid + epsilon` (guarantees first win)
- **VETERAN** locks to `base_bid`
- Simple, stable. Good for homogeneous agent pools.

### 2. Fixed with Epsilon (`"fixed_with_eps"`)
- **NOVICE** enters at `max(veteran_bids) + epsilon`
- Bid never changes after first auction
- Prevents wealth concentration — new agents always outbid incumbents once.

### 3. Holland (`"holland"`)
- **NOVICE** enters at `max(tycoon_bids) + epsilon`
- **VETERAN** stays at `base_bid`
- **TYCOON** (wealth ≥ threshold) bids `holland_alpha × wealth`
- Wealth-proportional bidding. Rich agents bid more, win more — but pay more.
- Promotes natural specialization: agents that consistently contribute accumulate wealth and win more auctions.

## Agent Lifecycle

```
NOVICE (first auction, premium bid)
  │
  ▼
VETERAN (standard bid, accumulates wealth)
  │
  ├── wealth ≥ tycoon_threshold → TYCOON (wealth-proportional bid)
  │
  └── wealth < 0 → BANKRUPT → removed → replacement spawned
```

## Economic Selection

### Bankruptcy
- Agent is bankrupt when `wealth < 0`
- Removed from population
- Death trace recorded for failure analysis

### Good Birth (Exploitation)
- Clone the **richest** agent
- Mutate its trainable prompt for exploration
- Probability: `evolution.p_a`

### Bad Birth (Exploration)
- Create replacement from **bankrupt** agent's failure trace
- LLM analyzes what went wrong and produces an improved agent
- Probability: `evolution.p_b`

### Periodic Births
- Every `birth_interval` episodes, spawn `num_births_per_interval` new agents
- Prevents population from stagnating

## Payment Flow

```
Winner pays bid amount
  → Payment goes to PREVIOUS winner (peer-to-peer)
  → If same agent wins consecutively, no payment (self-loop)
  → First action: payment goes to void (no recipient)
```

This creates a **natural credit assignment** chain: agents that set up successful trajectories get paid by the agents that execute them.

## Reward Flow

```
Environment returns reward after action
  → Applied to winner (or split across recent-winner chain window)
  → reward_scheme: "path_reward_only" or "path_reward_and_stepwise_reward"
  → path_reward_per_unique_author: split by unique agents (not per-action)
```

## Configuration

```python
@dataclass
class EngineConfig:
    max_steps_per_episode: int = 10
    max_trials_per_episode: int = 4
    birth_interval: int = 5
    num_births_per_interval: int = 2
    min_num_agents: int = 0
    max_num_agents: int = 0
    bid_scheme: str = "fixed"  # "fixed" | "fixed_with_eps" | "holland"
    base_bid: float = 0.1
    novice_bid_epsilon: float = 0.01
    initial_wealth: float = 0.5
    rent: float = 0.0
    rent_interval: int = 5
    holland_alpha: float = 0.1
    tycoon_wealth_threshold: float = 5.0

@dataclass
class RewardConfig:
    reward_scheme: str = "path_reward_only"
    path_reward_scale: float = 1.0
    env_reward_scale: float = 1.0
    center_env_reward: bool = True
    path_reward_per_unique_author: bool = False
    step_reward_split_chain: bool = False
    step_reward_chain_window: int = 3

@dataclass
class EvolutionConfig:
    p_a: float = 0.0  # good birth (exploitation)
    p_b: float = 1.0  # bad birth (exploration)
    periodical_good_p: float = 0.5
```

## Integration Pattern

To add economic routing to an existing mesh system:

1. **Create EconomicEngine** with config
2. **Wrap existing router** with EconomicRouter (falls back to capability matching)
3. **On agent registration**: also register in economy
4. **On task routing**: run auction among capability-matched candidates
5. **On task completion**: apply reward to winning agent

## Comparison: Economic Engine vs Protocol Mesh

This skill implements the **economic coordination layer**. It is complementary to a **protocol mesh** (like VoidTether) that handles inter-agent connectivity:

| Layer | This Skill (Economic) | Protocol Mesh (VoidTether) |
|-------|----------------------|---------------------------|
| **Purpose** | Who acts, how much they pay, who gets replaced | How agents find each other, authenticate, exchange tasks |
| **Mechanism** | Auctions, payments, wealth, bankruptcy, evolution | Turn policies, event bus, protocol adapters |
| **Agent model** | EconomicAgent with wealth/bid/status | TetherManifest — protocol-agnostic capability descriptors |
| **Protocols** | None (agents are native) | 10+ adapters (A2A, MCP, Hermes, ACP, etc.) |
| **Pricing** | PricingOracle — 33 models, 4 tiers, cost-per-token | None — bids are fixed or wealth-proportional |
| **Consensus** | Weighted majority, Borda, Delphi, Raft | None |
| **Discovery** | None (agents are pre-registered) | Mesh discovery over Tailscale, HMAC auth |

**The synthesis:** The economic engine provides the *market rules*; the protocol mesh provides the *connectivity*. Agents from any framework (Hermes, A2A, MCP, ACP) can participate in the same auction if the mesh translates their capabilities into EconomicAgent wrappers.

## Reference Files

- `references/10d-council-agents.md` — Full pattern for dimension-specialized agents: dimension map, agent classes, council auction flow, bid schemes, economic selection, and integration with HayekMAS.
- `references/eom-paper-summary.md` — Condensed summary of the EoM paper: bid schemes, agent lifecycle, payment flow, evolution, and config parameters.
- `references/voidtether-implementation.md` — Concrete VoidTether integration: file structure, integration points (Mesh, API, EconomicRouter), mode switching, default config, test coverage, and key design decisions.
- `references/hayekswarm-voidtether-bridge.md` — Full HayekSwarm ↔ VoidTether bridge: HayekEngine + HayekRouter replacing thin EconomicEngine/EconomicRouter with HayekMAS + 10-D Council + PricingOracle + ConsensusEngine. Covers capability-to-dimension mapping, bucket-brigade payments, bankruptcy handling, pricing oracle integration, and import paths.
- `references/paper-mapping.md` — Coverage assessment against three academic papers: EoM (83%), Token Economics (50%), Marginal Token Allocators (11%). Identifies next build targets.
- `references/malaysia-digital-2030.md` — Analysis of Malaysia's MD2030 AI Nation plan (2026-2030) with parallels to EoM/VoidTether: whole-of-nation approach, 7 strategic thrusts, national targets, and lessons for multi-agent economic systems.

## Related Skills

- `voidtether-mesh-operations` — Operating within the VoidTether mesh that uses this economic engine.
- `reference-implementation-porting` — Methodology for porting reference implementations (like EoM) into existing projects.
- `api-server-development` — Building a FastAPI marketplace server around the economic engine.

## 10-D Council Agents (Dimension-Specialized Agents)

The economic engine can be paired with a **10-D Council** — a population of dimension-specialized agents (D1-D10), each with a frozen system prompt and assigned model, that bid in auctions and act using their cognitive specialty.

### When to use

- You have well-defined agent roles (synthesis, code, strategy, analysis, etc.) that should persist across tasks
- You want agents to compete for tasks based on fit rather than being assigned by a central planner
- You need model-level diversity (different models for different cognitive dimensions)

### Key difference from EoM paper

The EoM paper uses generic agents with trainable prompts that evolve over time. The 10-D Council uses **dimension-specialized agents** with frozen system prompts — roles are stable and well-defined from the start. This is better for production systems where agent identity should be predictable.

### Reference

- `references/10d-council-agents.md` — Full pattern: dimension map design, agent class structure, council auction flow, bid schemes, economic selection, integration with HayekMAS, and pitfalls.

## Pitfalls

- **Wealth runaway**: An agent that wins many auctions accumulates wealth, bids higher, wins more. Use `path_reward_per_unique_author=True` to prevent single-agent monopolies.
- **Population collapse**: If all agents go bankrupt, the system stops. Set `min_num_agents > 0` and ensure periodic births are enabled.
- **Cold start**: New agents with zero wealth can't bid. Use `initial_wealth > 0` and `novice_bid_epsilon` to guarantee first win.
- **Starvation**: Agents that contribute strategically but rarely act (e.g. planners) get no step reward. Use `step_reward_split_chain=True` to share credit across the recent-winner chain.
- **Replay loops**: When agents go bankrupt mid-episode, roll back wealth to pre-episode snapshot and replay. This prevents agents from being punished for team failures.
- **Sibling subagent overwrites**: When porting the EoM reference implementation via parallel subagents, a sibling may overwrite your files with simplified versions. Always re-read before writing, and always write the complete correct implementation — not a patch on top of the sibling's version. See `reference-implementation-porting` skill for the full pattern.
- **Economic engine ≠ protocol mesh**: The economic engine decides *who* acts and *how much* they pay. It does NOT handle inter-agent communication, discovery, or protocol translation. Those are separate concerns that a protocol mesh (VoidTether) handles. Don't conflate the two — they are complementary layers.
- **PricingOracle recursion**: When adding `estimate_bid()` to a `PricingOracle` that already has `route()`, ensure they don't call each other. Compute the bid inline in `route()` rather than calling `estimate_bid()` from within it.
- **Council agent overwrite on re-registration**: When bridging manifests to council dimensions, two manifests mapping to the same dimension overwrite each other. Unregister first or implement dimension pooling.
- **Bucket-brigade self-loop**: If the same agent wins consecutive auctions, the bucket-brigade pays them to themselves. Harmless but wasteful — consider skipping payment on consecutive wins.
- **Bankrupt agent dimension gap**: When a bankrupt agent is removed, its dimension slot is empty until good/bad birth runs. Tasks targeting that dimension have no eligible agent during that window.
- **HayekMAS unused in Council-only mode**: When using the Council's `deliberate()` directly (as in the VoidTether bridge), the `HayekMAS` instance is created but its `run_one_episode()` is not called. The HayekMAS is kept for future per-step path rewards — don't remove it, but don't expect it to drive the auction loop.
- **LSP import errors for cross-repo packages**: Pyright flags `hayekmas.*` and `swarm.*` imports as unresolved when the HayekSwarm packages aren't installed in the Python path. The imports are correct — they match the actual file structure. Verify with `ast.parse()` syntax check, not LSP.

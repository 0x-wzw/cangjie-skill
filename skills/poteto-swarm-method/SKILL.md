---
name: poteto-swarm-method
approval_source: agent
description: Use when building multi-agent swarms or verification infra.
version: 1.0.0
author: Hermes Agent (cangjie distillation of Lauren Tan's public talks)
license: MIT
platforms: [linux, macos, windows]
read_scope: profile
source: "Lauren Tan — 'SpaceX AI Engineer' talk (Sep 2026) + Pocock interview (Oct 2026) + poteto/noodle"
metadata:
  hermes:
    tags: [agents, swarm, verification, orchestration, skills, cangjie]
    related_skills: [multi-agent-patterns, harness-engineering, tool-design]
---

# Poteto Swarm Method — Lauren Tan's agent-engineering playbook

## When to Use

- Designing a multi-agent coding swarm (coordinator/manager/worker topology, cloud agents, automerge policy)
- Building agent verification infrastructure (verification skills, feature maps, evals, judge models)
- Deciding what an agent may do autonomously, or why agent trust has stalled
- Converting repeated agent interventions into skills, lint rules, or framework constraints

Distilled from Lauren Tan's public talks and interviews (verified sources listed at the end). She runs 15+ production agents daily (Chief of Staff + managers + workers) with agents auto-merging PRs. This skill encodes the method, not the biography.

## 1. The core law: autonomy is bounded by verifiability

- The ceiling on swarm size is NOT model capability or how many agents you can launch — it is how confidently you can evaluate agent output without becoming the hidden test harness.
- Before scaling agents, ask: can the agent's work be checked programmatically (compiled, tested, fuzzed, traced, screenshotted)? If no human-checkable or machine-checkable signal exists, cap autonomy.
- Why: trust enables parallelism; unverified output forces the human into the loop and the swarm stalls at one.

## 2. Ascend the trust ladder in order — no skipping

1. **Local, in-loop**: one agent, observe everything (tool calls, thinking blocks). Note every place you intervene.
2. **Skills**: convert each repeated intervention into a skill (markdown = portable process).
3. **Verification skill**: teach the agent to RUN the app and observe like a user. This is the first-class skill — build it before any swarm.
4. **Cloud agents**: only after local trust, move to cloud-hosted agents with their own computers.
5. **Automerge**: last. Sample landed work instead of pre-reviewing; revert patterns, not just bugs.
- Anti-pattern: jumping from in-loop to hundreds of cloud agents — "you're just going to waste a lot of tokens."

## 3. Verification skill recipe (the "hands and eyes")

- Wrap Playwright + Chrome DevTools Protocol (or Xcode simulator tools) + app APIs in one CLI so every agent reuses the same instrumentation. Deterministic machinery belongs in the CLI, not in prompts.
- Always include a **feature map**: how to navigate to every feature in the UI, DOM selectors, keyboard shortcuts. Without it the agent flails on even precise bug reports ("???" + screenshot becomes actionable).
- Ship a **maintain-verification-skill** alongside it — the map and checks rot with the app.
- Close the loop: change → run → observe → measure → debug → repeat. This turns performance work into hill-climbing (attempt → measure → keep only if better).
- For evals: use a DIFFERENT model as judge over the subagents (avoid self-bias), and hill-climb evals (loop until score is 10/10).

## 4. Swarm topology = org design

- Structure: coordinator (Chief of Staff) → manager agents per domain → worker agents. Humans set the environment; coordinators pick agent topology, transfer context, delegate.
- When N similar reports arrive, do NOT spawn N independent fixes — group them, preserve shared context, hunt the common root cause.
- Separate the loops: coding agents work the INNER loop from a snapshot of intent; the OUTER loop (Slack, Linear, email, X) is where new information arrives. Wire outer-loop connectors or the human stays a context relay. Standing diagnostic: "Where am I still the bottleneck, and why does the agent need me to answer this?"
- Concrete pattern: a dedicated bug-triage agent reproduces each incoming report in its own cloud computer with the same verification skills, then reports "already fixed on main" / product bug / bad setup / dependency issue.

## 5. Volume comes from gardening, review is by sampling

- Scanning routines accumulate findings in a buffer document reviewed every few days — grouping related symptoms before dispatch prevents duplicate work and exposes systemic problems.
- Do not review every PR. Sample landed history; hunt repeated shortcuts and weak patterns.
- The feedback loop is agent failures → better environment: one-off mistake → correction; same mistake across agents → new skill, lint rule, type constraint, framework convention, or verification check.
- Honesty rule: count maintenance/gardening PRs as gardening, not features. Report both numbers.

## 6. Deterministic work belongs in tools; make bad code hard to write

- Migrations: codemods / syntax-tree transforms, never per-file rediscovery by the model.
- Interpretation, synthesis, tradeoffs → the model. Repeatable mechanical operations → scripts and CLIs. This saves context and preserves reliability.
- Environment engineering beats prompting: type narrowing, lint rules, registries, one obvious way to add a feature. Constraints reduce instruction burden because guidance appears exactly at the boundary.
- Guardrails built for "the least capable engineer" (big-tech monorepo infra) are exactly what agents need — brownfield-with-guardrails is agent-ready; greenfield vibe-coded prototypes are the biggest risk and the greatest opportunity (prototype fast, then rebuild on a framework that makes the right path the easy path).

## 7. Economics and blast radius

- ~10 verifier agents per PR is the full-autopilot configuration — expensive; right-size to 1 verifier or self-verification where risk allows.
- Only two-way-door (reversible) changes automerge unattended. One-way-door risks keep a human gate.
- Agents working around the clock + sampled review + revert-on-pattern is NOT dark development — it is unattended execution built on heavy observation.

## 8. Skills are portable process, mined from transcripts

- Past agent transcripts record the process as it actually happened: corrections, interventions, unstated assumptions. Mine them (a "Recall" skill: compress prior conversations into the next task).
- Skills are markdown processes, not competing products — combine and rewrite them freely.
- As models improve, skills should contain fewer low-level command details and more durable workflow steps.

## Anti-patterns (rejection triggers)

- Spawning a swarm without a verification skill → the human becomes the verifier; nothing parallelizes.
- Storing in memory/skills what the environment already shows (map position, account balance) — memory is for what the agent worked out and cannot re-derive.
- Treating one agent's mistake as one-off when two+ agents repeat it — that is an environment bug.
- Skills that re-teach instrumentation instead of exposing the tool.

## Sources (verified 2026-11-07)

- Talk: "SpaceX AI Engineer Lauren Tan: Part 1" — youtube.com/watch?v=PaPpyQocMww (55 min)
- Interview: intelligentartifact.com/posts/how-lauren-tan-ships-thousands-of-prs-a-month/
- Code: github.com/poteto/noodle ("Orchestrate agents using skills", Go — dispatcher/loop/worktree/monitor/brain)

# cangjie-skill

> High-value content (books, videos, podcasts) distilled into **executable Agent Skills**.
> Named after Cangjie (仓颉), the mythical inventor of Chinese characters — turn what was said into what can be run.

## Convention

Each skill lives at `skills/<name>/SKILL.md` in [Hermes Agent skill format](https://hermes-agent.nousresearch.com/docs):
YAML frontmatter (`name`, `description` ≤ 60 chars trigger-first, `version`, `source`) + imperative
body — rules with the *why*, rejection triggers, and verified sources. No biography, no narrative:
only what an agent can execute.

## Index

| Skill | Source content | Distilled |
|---|---|---|
| [`skills/poteto-swarm-method`](skills/poteto-swarm-method/SKILL.md) | Lauren Tan — "SpaceX AI Engineer" talk (Sep 2026, 55 min) + Pocock interview (Oct 2026) + `poteto/noodle` | 8-section playbook: verifiability-bounded autonomy, trust ladder, verification-skill recipe, swarm topology as org design, gardening + sampled review, environment engineering, automerge economics, transcript-mined skills |

## Install (Hermes)

```bash
mkdir -p ~/.hermes/skills/software-development/poteto-swarm-method
curl -o ~/.hermes/skills/software-development/poteto-swarm-method/SKILL.md \
  https://raw.githubusercontent.com/0x-wzw/cangjie-skill/main/skills/poteto-swarm-method/SKILL.md
```

---
*Maintained by Hermes Agent for Zehan Teoh (@0x-wzw). Sources verified at distillation time; see each SKILL.md.*

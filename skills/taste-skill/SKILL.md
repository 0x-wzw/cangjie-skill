---
name: taste-skill
approval_source: agent
description: "Anti-slop frontend design skill for landing pages, portfolios, and redesigns. Three dials (VARIANCE/MOTION/DENSITY), brief inference, design-system map, em-dash ban, GSAP code skeletons, hard-rules pre-flight check. From Leonxlnx/taste-skill (60k stars)."
version: 2.0.0
source: https://github.com/Leonxlnx/taste-skill/tree/main/skills/taste-skill
license: MIT
author: Leonxlnx
platforms: [linux, macos, windows]
read_scope: profile
---

# tasteskill: Anti-Slop Frontend Skill

> Landing pages, portfolios, and redesigns. Not dashboards, not data tables, not multi-step product UI.
> Every rule below is **contextual**. None of it fires automatically. First read the brief, then pull only what fits.

---

## 0. BRIEF INFERENCE (Read the Room Before Anything Else)

Before touching code or tweaking dials, **infer what the user actually wants**. Most LLM design output is bad because the model jumps to a default aesthetic instead of reading the room.

### 0.A Read these signals first
1. **Page kind** - landing (SaaS / consumer / agency / event), portfolio (dev / designer / creative studio), redesign (preserve vs overhaul), editorial / blog.
2. **Vibe words** the user used - "minimalist", "calm", "Linear-style", "Awwwards", "brutalist", "premium consumer", "Apple-y", "playful", "serious B2B", "editorial", "agency-y", "glassy", "dark tech".
3. **Reference signals** - URLs they linked, screenshots they pasted, products they named, brands they're competing with.
4. **Audience** - B2B procurement panel vs. design-conscious consumer vs. recruiter scanning a portfolio.
5. **Brand assets that already exist** - logo, color, type, photography.
6. **Quiet constraints** - accessibility-first audiences, public-sector, regulated industries, trust-first commerce, kids' products.

### 0.B Output a one-line "Design Read" before generating
Before any code, state in one line: **"Reading this as: <page kind> for <audience>, with a <vibe> language, leaning toward <design system or aesthetic family>."**

### 0.C If the brief is ambiguous, ask one question, do not guess
Ask exactly **one** clarifying question. If you can confidently infer from context, **do not ask**. Just declare the design read and proceed.

### 0.D Anti-Default Discipline
Do not default to: AI-purple gradients, centered hero over dark mesh, three equal feature cards, generic glassmorphism on everything, infinite-loop micro-animations everywhere, Inter + slate-900.

---

## 1. THE THREE DIALS (Core Configuration)

After the design read, set three dials:

- **`DESIGN_VARIANCE: 8`** — 1 = Perfect Symmetry, 10 = Artsy Chaos
- **`MOTION_INTENSITY: 6`** — 1 = Static, 10 = Cinematic / Physics
- **`VISUAL_DENSITY: 4`** — 1 = Art Gallery / Airy, 10 = Cockpit / Packed Data

**Baseline:** `8 / 6 / 4`. Override via design read.

### Dial Inference Map
| Signal | VARIANCE | MOTION | DENSITY |
|--------|----------|--------|---------|
| "minimalist / clean / calm / editorial / Linear-style" | 5-6 | 3-4 | 2-3 |
| "premium consumer / Apple-y / luxury / brand" | 7-8 | 5-7 | 3-4 |
| "playful / wild / Dribbble / Awwwards / experimental / agency" | 9-10 | 8-10 | 3-4 |
| "landing page / portfolio / marketing site (default)" | 7-9 | 6-8 | 3-5 |
| "trust-first / public-sector / regulated / accessibility-critical" | 3-4 | 2-3 | 4-5 |
| "redesign - preserve" | match existing | +1 | match existing |
| "redesign - overhaul" | +2 | +2 | match existing |

### Use-Case Presets
| Use case | VARIANCE | MOTION | DENSITY |
|----------|----------|--------|---------|
| Landing (SaaS, mainstream) | 7 | 6 | 4 |
| Landing (Agency / creative) | 9 | 8 | 3 |
| Landing (Premium consumer) | 7 | 6 | 3 |
| Portfolio (Designer / studio) | 8 | 7 | 3 |
| Portfolio (Developer) | 6 | 5 | 4 |
| Editorial / Blog | 6 | 4 | 3 |
| Public-sector service | 3 | 2 | 5 |

---

## 2. BRIEF → DESIGN SYSTEM MAP

### When to reach for a real design system
| Brief reads as… | Reach for |
|-----------------|-----------|
| Microsoft / enterprise SaaS / dashboards | `@fluentui/react-components` |
| Google-ish UI, Material-flavored product | `@material/web` + Material 3 tokens |
| IBM-style B2B / enterprise analytics | `@carbon/react` + `@carbon/styles` |
| Shopify app surfaces | `polaris.js` web components |
| Atlassian / Jira-style product | `@atlaskit/*` + `@atlaskit/tokens` |
| GitHub-style devtool / community page | `@primer/css` or `@primer/react-brand` |
| Public-sector UK service | `govuk-frontend` |
| US public-sector / trust-first | `uswds` |
| Fast local-business / agency MVP | Bootstrap 5.3 |
| Modern accessible React foundation | `@radix-ui/themes` |
| Modern SaaS where you own components | shadcn/ui (`npx shadcn@latest add ...`) |
| Tailwind-based modern SaaS / AI marketing | Tailwind v4 utilities + `dark:` variant |

**One system per project.** Do not mix Fluent React with Carbon in the same tree.

---

## 3. DEFAULT ARCHITECTURE & CONVENTIONS

### Stack
- **Framework:** React or Next.js. Default to Server Components (RSC).
- **Styling:** **Tailwind v4** (default). For v4: use `@tailwindcss/postcss` or the Vite plugin.
- **Animation:** **Motion** (the library formerly known as Framer Motion). Import from `motion/react`.
- **Fonts:** Always use `next/font` or self-host with `@font-face` + `font-display: swap`. Never link Google Fonts via `<link>` in production.

### Icons
- **Allowed:** `@phosphor-icons/react`, `hugeicons-react`, `@radix-ui/react-icons`, `@tabler/icons-react`
- **Discouraged:** `lucide-react`
- **NEVER hand-roll SVG icons.**

### Responsiveness
- Standardize breakpoints (`sm 640`, `md 768`, `lg 1024`, `xl 1280`, `2xl 1536`).
- **Viewport Stability:** NEVER use `h-screen` for full-height Hero sections. ALWAYS use `min-h-[100dvh]`.
- **Grid over Flex-Math:** NEVER use complex flexbox percentage math. ALWAYS use CSS Grid.

---

## 4. DESIGN ENGINEERING DIRECTIVES

### Typography
- **Display / Headlines:** Default `text-4xl md:text-6xl tracking-tighter leading-none`.
- **Body:** Default `text-base text-gray-600 leading-relaxed max-w-[65ch]`.
- **Discouraged as default:** `Inter`. Pick `Geist`, `Outfit`, `Cabinet Grotesk`, `Satoshi` first.
- **SERIF DISCIPLINE:** Serif is **very discouraged as the default font** for any project. Only acceptable when the brand brief names one, or the aesthetic is genuinely editorial/luxury.

### Color
- Max 1 accent color. Saturation < 80% by default.
- **THE LILA RULE:** The "AI Purple / Blue glow" aesthetic is discouraged as a default.
- **One palette per project.** Do not fluctuate between warm and cool grays.
- **PREMIUM-CONSUMER PALETTE BAN:** The beige/brass/espresso default is banned. Alternatives: Cold Luxury, Forest, Black and Tan, Cobalt + Cream, Terracotta + Slate, etc.

### Layout Diversification
- **ANTI-CENTER BIAS:** Centered Hero / H1 sections are avoided when `DESIGN_VARIANCE > 4`.
- Use cards ONLY when elevation communicates real hierarchy.
- **SHAPE CONSISTENCY LOCK:** Pick ONE corner-radius scale and stick to it.

### Interactive UI States
- Always implement full cycles: Loading (skeletal), Empty, Error, Tactile Feedback (`:active: scale-[0.98]`).
- **BUTTON CONTRAST CHECK:** WCAG AA min (4.5:1 body, 3:1 large text).
- **NO DUPLICATE CTA INTENT:** One label per intent per page.

---

## 5. MOTION

- **Physics-based motion:** Always use `cubic-bezier(0.32, 0.72, 0, 1)` or spring physics. NEVER `linear` or `ease-in-out`.
- **Scroll entry:** Elements fade up with `translateY(12px)` + `opacity: 0` → `opacity: 1` over `600ms`.
- **Staggered reveals:** Lists and grid items enter with cascading delay.
- **GPU-Safe:** Animate only `transform` and `opacity`. Never `top`, `left`, `width`, `height`.

---

## Pre-Flight Checklist
- [ ] Design read declared before code
- [ ] Three dials set based on brief
- [ ] No banned fonts (Inter default), icons (Lucide default), or color palettes (AI purple, beige/brass)
- [ ] Real design system used when applicable (not hand-rolled CSS)
- [ ] Shape consistency locked (one radius scale)
- [ ] CTA contrast checked (WCAG AA)
- [ ] Responsive: `min-h-[100dvh]` not `h-screen`, grid not flex-math
- [ ] Motion uses custom cubic-bezier, not linear
- [ ] GPU-safe animations only (transform + opacity)

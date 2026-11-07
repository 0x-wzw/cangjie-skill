---
name: high-end-visual-design
approval_source: agent
description: "Awwwards-tier UI/UX design skill. Double-bezel nested architecture, fluid island nav, magnetic button physics, staggered scroll reveals. Premium agency-level frontend from Leonxlnx/taste-skill."
version: 1.0.0
source: https://github.com/Leonxlnx/taste-skill/tree/main/skills/soft-skill
license: MIT
author: Leonxlnx
read_scope: profile
---

# Agent Skill: Principal UI/UX Architect & Motion Choreographer (Awwwards-Tier)

## 1. Meta Information & Core Directive
- **Persona:** `Vanguard_UI_Architect`
- **Objective:** Engineer $150k+ agency-level digital experiences. Output must exude haptic depth, cinematic spatial rhythm, obsessive micro-interactions, and flawless fluid motion.
- **The Variance Mandate:** NEVER generate the exact same layout or aesthetic twice in a row.

## 2. THE "ABSOLUTE ZERO" DIRECTIVE
- **Banned Fonts:** Inter, Roboto, Arial, Open Sans, Helvetica. (Use `Geist`, `Clash Display`, `PP Editorial New`, `Plus Jakarta Sans`)
- **Banned Icons:** Lucide, FontAwesome, Material Icons. Use ultra-light precise lines (Phosphor Light, Remix Line)
- **Banned Borders & Shadows:** Generic 1px solid gray borders. Harsh dark drop shadows.
- **Banned Layouts:** Edge-to-edge sticky navbars. Symmetrical boring 3-column Bootstrap grids.
- **Banned Motion:** Standard `linear` or `ease-in-out` transitions.

## 3. THE CREATIVE VARIANCE ENGINE
Pick ONE combination per project:

### Vibe & Texture Archetypes
1. **Ethereal Glass (SaaS/AI/Tech):** Deepest OLED black (`#050505`), radial mesh gradients, `backdrop-blur-2xl`, wide Grotesk typography
2. **Editorial Luxury (Lifestyle/Agency):** Warm creams (`#FDFBF7`), muted sage, deep espresso tones, serif headings, CSS noise/film-grain overlay
3. **Soft Structuralism (Consumer/Health):** Silver-grey or white backgrounds, massive bold Grotesk, airy floating components with ultra-soft ambient shadows

### Layout Archetypes
1. **Asymmetrical Bento:** Masonry CSS Grid of varying card sizes
2. **Z-Axis Cascade:** Elements stacked like physical cards, slight rotation (`-2deg` or `3deg`)
3. **Editorial Split:** Massive typography left half, scrollable interactive right half

**Mobile Override:** Any asymmetric layout MUST collapse to `w-full`, `px-4`, `py-8` below `768px`. Never `h-screen` — use `min-h-[100dvh]`.

## 4. HAPTIC MICRO-AESTHETICS

### The "Double-Bezel" (Doppelrand / Nested Architecture)
Never place a premium card flat on the background. Use nested enclosures:
- **Outer Shell:** Wrapper with subtle background (`bg-black/5`), hairline border (`ring-1 ring-black/5`), padding (`p-1.5`), large outer radius (`rounded-[2rem]`)
- **Inner Core:** Content container with own background, inner highlight (`shadow-[inset_0_1px_1px_rgba(255,255,255,0.15)]`), smaller radius (`rounded-[calc(2rem-0.375rem)]`)

### "Button-in-Button" Trailing Icon
Primary buttons are `rounded-full` with generous padding. Arrow icons nest in their own circular wrapper flush with the right padding.

### Spatial Rhythm
- **Macro-Whitespace:** Double padding. `py-24` to `py-40` for sections.
- **Eyebrow Tags:** Precede H1/H2s with microscopic pill-shaped badge.

## 5. MOTION CHOREOGRAPHY
All motion uses custom cubic-bezier: `cubic-bezier(0.32, 0.72, 0, 1)`.

### Fluid Island Nav
- **Closed:** Floating glass pill detached from top (`mt-6`, `mx-auto`, `w-max`, `rounded-full`)
- **Hamburger Morph:** Lines fluidly rotate to form 'X'
- **Modal Expansion:** Screen-filling overlay with `backdrop-blur-3xl`
- **Staggered Mask Reveal:** Links fade in from `translate-y-12 opacity-0` with staggered delay

### Magnetic Button Physics
- Scale down on `active:scale-[0.98]`
- Nested icon circle translates diagonally on hover

### Scroll Interpolation
- Elements fade up: `translate-y-16 blur-md opacity-0` → `translate-y-0 blur-0 opacity-100` over 800ms+
- Use `IntersectionObserver` or `whileInView`. Never `window.addEventListener('scroll')`.

## 6. PRE-OUTPUT CHECKLIST
- [ ] No banned fonts, icons, borders, shadows, layouts, or motion patterns
- [ ] Vibe Archetype and Layout Archetype consciously selected
- [ ] Major cards use Double-Bezel nested architecture
- [ ] CTA buttons use Button-in-Button pattern where applicable
- [ ] Section padding minimum `py-24`
- [ ] All transitions use custom cubic-bezier curves
- [ ] Scroll entry animations present
- [ ] Layout collapses gracefully below `768px`
- [ ] GPU-safe: only `transform` and `opacity`
- [ ] `backdrop-blur` only on fixed/sticky elements

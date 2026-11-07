---
name: minimalist-ui-skill
approval_source: agent
description: "Clean editorial-style interfaces with warm monochrome palette, typographic contrast, flat bento grids, muted pastels. No gradients, no heavy shadows. From Leonxlnx/taste-skill."
version: 1.0.0
source: https://github.com/Leonxlnx/taste-skill/tree/main/skills/minimalist-skill
license: MIT
author: Leonxlnx
read_scope: profile
---

# Protocol: Premium Utilitarian Minimalism UI Architect

## 1. Protocol Overview
An advanced frontend engineering directive for generating highly refined, ultra-minimalist, "document-style" web interfaces. Enforces high-contrast warm monochrome palette, bespoke typographic hierarchies, meticulous structural macro-whitespace, bento-grid layouts, ultra-flat component architecture with deliberate muted pastel accents. Actively rejects standard generic SaaS design trends.

## 2. Absolute Negative Constraints (Banned Elements)
- DO NOT use "Inter", "Roboto", or "Open Sans"
- DO NOT use generic thin-line icon libraries ("Lucide", "Feather", standard "Heroicons")
- DO NOT use Tailwind's default heavy drop shadows (`shadow-md`, `shadow-lg`, `shadow-xl`)
- DO NOT use primary colored backgrounds for large elements or sections
- DO NOT use gradients, neon colors, or 3D glassmorphism
- DO NOT use `rounded-full` for large containers, cards, or primary buttons
- DO NOT use emojis anywhere in code, markup, text content, headings, or alt text
- DO NOT use generic placeholder names like "John Doe", "Acme Corp", or "Lorem Ipsum"
- DO NOT use AI copywriting clichés: "Elevate", "Seamless", "Unleash", "Next-Gen", "Game-changer", "Delve"

## 3. Typographic Architecture
- **Primary Sans-Serif (Body, UI):** `'SF Pro Display', 'Geist Sans', 'Helvetica Neue', 'Switzer', sans-serif`
- **Editorial Serif (Hero Headings):** `'Lyon Text', 'Newsreader', 'Playfair Display', 'Instrument Serif', serif`. Tight tracking `letter-spacing: -0.02em` to `-0.04em`, tight line-height `1.1`.
- **Monospace:** `'Geist Mono', 'SF Mono', 'JetBrains Mono', monospace`
- Body text never absolute black (`#000000`). Use off-black (`#111111` or `#2F3437`).

## 4. Color Palette (Warm Monochrome + Spot Pastels)
- **Canvas / Background:** Pure White `#FFFFFF` or Warm Bone `#F7F6F3` / `#FBFBFA`
- **Primary Surface (Cards):** `#FFFFFF` or `#F9F9F8`
- **Structural Borders:** Ultra-light gray `#EAEAEA` or `rgba(0,0,0,0.06)`
- **Accent Colors (desaturated pastels only):**
  - Pale Red: `#FDEBEC` (Text: `#9F2F2D`)
  - Pale Blue: `#E1F3FE` (Text: `#1F6C9F`)
  - Pale Green: `#EDF3EC` (Text: `#346538`)
  - Pale Yellow: `#FBF3DB` (Text: `#956400`)

## 5. Component Specifications
- **Bento Box Grids:** Asymmetrical CSS Grid, `border: 1px solid #EAEAEA`, `border-radius: 8px` or `12px` max, generous padding (`24px` to `40px`)
- **Primary CTA Buttons:** Solid `#111111` background, `#FFFFFF` text, `border-radius: 4-6px`, no box-shadow. Hover: `#333333` or micro-scale `transform: scale(0.98)`
- **Tags & Badges:** Pill-shaped (`border-radius: 9999px`), `text-xs`, uppercase, wide tracking, muted pastel backgrounds
- **Accordions (FAQ):** No container boxes. `border-bottom: 1px solid #EAEAEA` only. Clean `+` / `-` toggles

## 6. Motion & Micro-Animations
- **Scroll Entry:** `translateY(12px)` + `opacity: 0` → `opacity: 1` over `600ms` with `cubic-bezier(0.16, 1, 0.3, 1)`. Use `IntersectionObserver`, never `window.addEventListener('scroll')`.
- **Hover States:** Cards lift with shadow shift (`0 0 0` → `0 2px 8px rgba(0,0,0,0.04)` over `200ms`). Buttons `scale(0.98)` on `:active`.
- **Staggered Reveals:** Lists and grid items enter with cascade delay (`animation-delay: calc(var(--index) * 80ms)`).
- **GPU-Safe:** Animate only `transform` and `opacity`. No layout-triggering properties.

## 7. Execution Protocol
1. Establish macro-whitespace first. Massive vertical padding between sections (`py-24` or `py-32`).
2. Constrain typography content width to `max-w-4xl` or `max-w-5xl`.
3. Apply custom typographic hierarchy and monochromatic color variables immediately.
4. Every card, divider, and border adheres to `1px solid #EAEAEA`.
5. Add scroll-entry animations to all major content blocks.
6. Sections have visual depth through imagery, ambient gradients, or subtle textures.

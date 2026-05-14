---
name: The Design System
colors:
  surface: '#fbf9fa'
  surface-dim: '#dbd9db'
  surface-bright: '#fbf9fa'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f5f3f4'
  surface-container: '#efedef'
  surface-container-high: '#e9e7e9'
  surface-container-highest: '#e4e2e3'
  on-surface: '#1b1c1d'
  on-surface-variant: '#44474c'
  inverse-surface: '#303032'
  inverse-on-surface: '#f2f0f2'
  outline: '#74777d'
  outline-variant: '#c4c6cd'
  surface-tint: '#4f6073'
  primary: '#041627'
  on-primary: '#ffffff'
  primary-container: '#1a2b3c'
  on-primary-container: '#8192a7'
  inverse-primary: '#b7c8de'
  secondary: '#3b6934'
  on-secondary: '#ffffff'
  secondary-container: '#b9eeab'
  on-secondary-container: '#3f6d38'
  tertiary: '#211200'
  on-tertiary: '#ffffff'
  tertiary-container: '#38260b'
  on-tertiary-container: '#a88c69'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d2e4fb'
  primary-fixed-dim: '#b7c8de'
  on-primary-fixed: '#0b1d2d'
  on-primary-fixed-variant: '#38485a'
  secondary-fixed: '#bcf0ae'
  secondary-fixed-dim: '#a1d494'
  on-secondary-fixed: '#002201'
  on-secondary-fixed-variant: '#23501e'
  tertiary-fixed: '#feddb5'
  tertiary-fixed-dim: '#e1c29b'
  on-tertiary-fixed: '#281802'
  on-tertiary-fixed-variant: '#584326'
  background: '#fbf9fa'
  on-background: '#1b1c1d'
  surface-variant: '#e4e2e3'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  button:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '500'
    lineHeight: 20px
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  2xl: 48px
  gutter: 20px
  margin-mobile: 16px
  margin-desktop: 32px
---

## Brand & Style

This design system is engineered for high-utility environments, specifically tailored for sales and customer support workflows where information density and clarity are paramount. The brand personality is authoritative yet supportive, characterized by a **Corporate / Modern** aesthetic that prioritizes functional efficiency over decorative flair.

The visual language utilizes a "utility-first" philosophy. It balances the seriousness of enterprise software with the approachability of a modern SaaS tool. By utilizing crisp geometry and a structured information hierarchy, the system reduces cognitive load for users who spend several hours a day within the interface. The emotional goal is to instill a sense of reliability, speed, and organized precision.

## Colors

The color palette is anchored by a sophisticated deep navy blue, which serves as the primary driver for brand identity, primary actions, and navigational elements. This provides a high-contrast, professional foundation. 

The emerald green is reserved strictly for success states, "copy" confirmations, and positive growth indicators, ensuring these functional cues are immediately recognizable. Surfaces are divided between a light gray background for the application canvas and pure white for content containers (cards), creating a clear visual distinction between the workspace and the content itself. 

Neutral tones are pulled from a cool-gray spectrum to maintain harmony with the navy primary color, avoiding the "muddy" look of warm grays in a professional context.

## Typography

This design system utilizes **Inter** for its exceptional readability in data-heavy interfaces and its comprehensive character set. The typographic scale is optimized for legibility at small sizes, which is common in CRM and support dashboards.

- **Weight Usage:** Use SemiBold (600) for section headers and Bold (700) sparingly for primary page titles. Medium (500) is preferred for interactive elements like buttons and tabs to provide enough "ink" for clarity without appearing heavy.
- **Vertical Rhythm:** Line heights are set generously (1.5x for body text) to prevent eye fatigue during long reading sessions.
- **Data Display:** For tabular data, utilize the tabular numbers feature of Inter to ensure column alignment in sales reports and pricing tables.

## Layout & Spacing

The system employs a **12-column fixed-fluid hybrid grid**. On desktop, content is contained within a maximum width of 1440px, while on smaller screens, it fluidly adapts with a minimum margin of 16px.

A strict 4px baseline grid ensures consistent vertical rhythm. Standardized padding for cards and sections should follow the `lg` (24px) or `xl` (32px) tokens to maintain a sense of openness even when displaying complex data.

- **Desktop:** 12 columns, 20px gutters, 32px margins.
- **Tablet:** 8 columns, 16px gutters, 24px margins.
- **Mobile:** 4 columns, 12px gutters, 16px margins.

## Elevation & Depth

Visual hierarchy is established through a combination of **Tonal Layers** and **Ambient Shadows**. This design system avoids heavy gradients, relying instead on the contrast between the background (#F5F7FA) and raised surfaces (#FFFFFF).

- **Level 0 (Base):** The main background. Flat.
- **Level 1 (Cards/Sections):** White background with a subtle, highly diffused shadow (e.g., `0px 1px 3px rgba(26, 43, 60, 0.05), 0px 4px 6px rgba(26, 43, 60, 0.03)`).
- **Level 2 (Dropdowns/Modals):** Increased shadow spread and slightly higher opacity to indicate interactivity and focus.
- **Level 3 (Toasts/Global Alerts):** Reserved for temporary system messages, using the primary navy color or emerald green for success, with a distinct lift from the UI.

## Shapes

The shape language is professional and structured. A **Soft** roundedness level (0.25rem / 4px) is applied to most UI components including buttons, input fields, and small cards. This slight rounding takes the "edge" off the interface without making it feel overly casual or "bubbly."

- **Standard Elements:** 4px radius (Buttons, Inputs, Checkboxes).
- **Large Containers:** 8px radius (Main content cards, Modals).
- **Utility Elements:** 2px or 0px radius may be used for dense data grids or nested list items where precision is key.

## Components

- **Buttons:** Primary buttons use the deep navy background with white text. Success actions (like "Copy Link" or "Finalize Deal") transition to emerald green.
- **Input Fields:** Use a 1px border (#E2E8F0) with a 4px corner radius. Focus states should use a 2px navy blue ring with a 2px offset.
- **Cards:** White surfaces with a 1px border (#E2E8F0) and the Level 1 subtle shadow. Headers within cards should have a light gray bottom border to separate metadata from body content.
- **Chips/Badges:** Used for status (e.g., "In Progress", "Qualified"). Use low-saturation background tints of the status color with high-saturation text to ensure legibility without distracting from the main content.
- **Data Tables:** High-density layout with 12px vertical cell padding. Header rows should be slightly darker (#F1F3F5) with uppercase labels for clear distinction.
- **Success Toasts:** When a "copy" or "save" action is performed, a small toast appears at the bottom-center using an emerald green icon and navy text to signal completion.
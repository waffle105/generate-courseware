---
description: Create visual, low-text, image-based Chinese teaching
  courseware from a topic, syllabus, teaching outline, lesson plan,
  training goal, or adult-learning workshop request. Use when Codex
  needs to plan slide-by-slide instructional content, generate two style
  directions for user selection, generate each full-slide 1920x1080 page
  image with gpt-image-2, assemble a picture-only PowerPoint deck, and
  add speaker notes for instructor delivery.
name: generate-courseware
---

# Generate Courseware

## Core Rule

Create image-based teaching courseware that makes abstract concepts,
complex logic, and hidden structures visible. Do not create PPTs with
large amounts of text boxes. Do not use Python, python-pptx, or any
Python PPT tools to create or assemble the final deck.

Never show page numbers on audience-facing slide images or in the final
PowerPoint. Slide numbers may be used only as internal production
metadata in plans, manifests, filenames, prompts, and speaker notes.
Do not render them as numerals, labels, footer markers, progress
indicators, or decorative numbering on any cover, contents, transition,
content, practice, summary, or closing page.

Do not edit this skill file unless the user explicitly asks to modify,
update, or fix the skill. One-time preferences for a specific deck
should only apply to that task and should not be written into
`SKILL.md`.

## Default Workflow

1.  Analyze the course topic or outline and select suitable visual logic
    structures from `references/visual-logic-library.md`.
2.  Create a slide-by-slide course plan and wait for user confirmation
    before generating final images.
3.  Create two visual style directions for user selection. Each
    direction must include a cover page, table-of-contents page, and
    representative content page based on the actual course content
    whenever possible.
4.  After the user selects a style, lock the style guide and keep all
    subsequent pages consistent, especially title, body text, emphasis
    text, typography, sizes, and visual effects.
5.  Generate each slide independently as a 1920x1080 full-page image
    with `gpt-image-2`, ensuring accurate audience-facing Chinese text.
6.  Review readability, visual logic, text density, style consistency,
    title accuracy, and teaching value. Remove unnecessary or unsuitable
    text and regenerate weak pages.
7.  Perform title fidelity checks. Titles must be accurate and
    consistent without damaging illustrations. Course title and
    instructor name should only appear on the cover, not repeated on
    internal pages.
8.  Use PowerPoint automation to insert images full-bleed and add
    speaker notes.

## Course Planning

Before generating final pages, create:

`courseware-output/<course-title>/course-plan.md`

Each slide row must include: - Slide number - Slide role - Slide title -
One core teaching point - Visual metaphor, diagram type, or logic
structure - Text limit - Draft speaker notes

Use 18-24 slides for a normal formal course unless otherwise specified.
For short lessons use fewer slides. If the outline requires more slides,
create them in batches and merge later. Wait for confirmation unless the
user explicitly skips confirmation.

If the original structure lacks transition pages, automatically add
chapter transition pages. Each table-of-contents item should correspond
to a transition page.

Before planning visuals, read `references/visual-logic-library.md` and
match concepts with suitable structures such as SWOT, PEST, strategy
pyramid, growth flywheel, funnel, matrix, journey map, business canvas,
lifecycle, RACI, swimlane, roadmap, KPI tree, or AI transformation
roadmap.

## Style Selection

Create two complete style directions in:

`courseware-output/<course-title>/style-options/`

Each direction includes: - Cover sample - Table-of-contents sample -
Representative content-page sample - Palette, typography, title
placement, content grid, icon style, background motif, card/panel style,
and footer treatment. All samples must omit visible page numbers.

If the user does not specify a style: - Style A: blue technology
business consulting style from
`references/visual-courseware-patterns.md` - Style B: industry- and
content-specific alternative

Do not create the full deck before the user selects a style unless they
explicitly skip style selection.

After selection create:

`courseware-output/<course-title>/style-guide.md`

Lock: - Main palette and accent colors - Title/subtitle hierarchy and
placement - Typography hierarchy by page role - Panel geometry and
margins - Icon and illustration style - Background rules - Footer and
no-visible-page-number rule - Diagram, arrow, card, chart, and
annotation rules

## Visual Design

Each page must teach through visual structure. Prefer process maps,
cycles, funnels, matrices, comparisons, checklists, storyboards,
timelines, decision trees, dashboards, scene diagrams, and annotated
examples.

## Language Tone

Use calm, constructive, participant-respecting language.

-   Explain goals, next actions, or benefits directly.
-   Avoid aggressive slogan patterns or language that dismisses existing
    methods.
-   Describe improvements and applicable conditions instead of saying
    learners are wrong.
-   Keep questions exploratory and practical.

Keep text structured: - One core message per slide. - Short labels
instead of paragraphs. - Large readable titles. - Cover title must be
the largest text. - Content-page titles must remain consistent and not
overpower diagrams. - Avoid tiny UI text, dense bullet lists, and
decorative text blocks. - Use icons, arrows, numbers, panels, and
spatial relationships.

## Image Generation

Generate every slide independently with `gpt-image-2`.

Final delivery: - Complete audience-facing image slide - Accurate
Chinese text included in final PNG

Preferred workflow: - Generate visual backgrounds with `gpt-image-2`. -
Ensure Chinese titles, labels, numbers, and phrases are accurate. - If
users request removing text, remove only the text layer and keep visuals
unchanged. - Do not regenerate, crop, mask, or redesign visuals for text
removal only.

Default settings: - Model: `gpt-image-2` - Size: `1920x1080` - Quality:
`high` - Aspect ratio: `16:9` - Output: PNG

Before generating each image, write prompts in `page-prompts.md`
including: - Course title and audience - Slide number and role - Exact
Chinese text - Visual metaphor and layout - Style direction - Locked
style guide details - Negative constraints, including no visible page
numbers or page-number-like footer markers

## Quality Gate

Regenerate pages when: - Chinese text is incorrect, garbled, too small,
or too dense. - Titles violate hierarchy. - Visual logic is unclear. -
The page looks decorative rather than educational. - The style guide is
not followed. - Important content is cropped or hidden. - Any visible
page number or page-number-like footer marker appears.

Use OCR or visual inspection when available.

## Title Fidelity Pass

Before final assembly: - Compare visible titles with
`deck_manifest.json`. - Keep cover titles exact and dominant. - Keep
content-page title treatment consistent. - Repair title problems through
proper layouts, not large blocking bars. - Do not use Python or Python
PPT tools for repair or assembly.

## Speaker Notes

Every slide must contain:

``` text
Teaching objective: ...

Key teaching points: ...

Transition prompt: ...
```

Notes should support speaking rather than reading. Include teaching
intent, examples, questions, and transitions.

## Assembly

Create `deck_manifest.json` following `references/manifest-schema.md`.

Use PowerPoint automation to create the 16:9 deck, insert images
full-bleed, add speaker notes, and save the `.pptx`.

Do not use Python, python-pptx, or other Python tools for PowerPoint
creation or assembly.

If PowerPoint automation is unavailable, stop and inform the user.

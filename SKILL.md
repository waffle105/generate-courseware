---
name: generate-courseware
description: Create visual, low-text, image-based Chinese teaching courseware from a topic, syllabus, teaching outline, lesson plan, training goal, or adult-learning workshop request. Use when Codex needs to plan slide-by-slide instructional content, generate two style directions for user selection, generate each full-slide 1920x1080 page image with gpt-image-2, assemble a picture-only PowerPoint deck, and add speaker notes for instructor delivery.
---

# Generate Courseware

## Core Rule

Build image-based teaching decks that make abstract concepts, difficult logic, and hidden structures visible. Do not create content-heavy PPT text boxes. Do not use Python, python-pptx, or any Python PPT tooling to make or assemble the final deck.

Use this default sequence:

1. Analyze the topic or syllabus and choose visual logic structures from `references/visual-logic-library.md`.
2. Create a slide-level course plan and wait for user confirmation before generating final images.
3. Create two style directions for the user to choose. Each direction must include a cover page, table-of-contents page, and representative content page.
4. After the user chooses a style, lock a deck style guide and use it consistently across all remaining pages.
5. Generate each slide as a separate full-page 1920x1080 image with `gpt-image-2`.
6. Inspect each image for readability, visual logic, text density, style consistency, and teaching usefulness; regenerate weak pages.
7. Build the PPT with PowerPoint automation by inserting each image full-bleed and writing speaker notes.

## Course Planning

Create `courseware-output/<course-title>/course-plan.md` before any final page generation.

The plan must include one row per slide with:

- Slide number
- Slide role, such as cover, hook, concept, framework, comparison, workflow, demo, practice, checklist, or summary
- Slide title
- One core teaching point
- Visual metaphor, diagram type, or logic structure
- On-slide text limit
- Draft speaker notes

Use 18-24 slides for a normal formal course unless the user specifies otherwise. Use fewer slides for short lessons and more only when the outline needs it. Ask for confirmation after the plan unless the user explicitly says to skip confirmation.

Before planning slide visuals, read `references/visual-logic-library.md` and map abstract concepts to suitable structures. Use concrete structures such as SWOT, PEST, strategy pyramid, growth flywheel, funnel, matrix, journey map, business canvas, lifecycle, RACI, swimlane, roadmap, KPI tree, or AI transformation roadmap when they fit the lesson.

## Style Selection

Before producing the full deck, create `courseware-output/<course-title>/style-options/` with two complete style directions:

```text
style-a-cover.png
style-a-toc.png
style-a-content.png
style-b-cover.png
style-b-toc.png
style-b-content.png
style-options.md
```

Each style direction must include:

- Cover page sample
- Table-of-contents page sample
- One representative content page sample using a real slide from the planned course
- Palette, typography feel, title placement, content grid, icon style, background motif, card/panel style, and footer/page-number treatment

If the user does not specify a style, make Style A the default blue technology business consulting style described in `references/visual-courseware-patterns.md`, inspired by the provided blue tech management chart PDF. Make Style B a content- and industry-specific alternative. Do not proceed to the full deck until the user chooses a style unless the user explicitly says to skip style selection.

After selection, create `courseware-output/<course-title>/style-guide.md` and keep it stable for the rest of the deck. The style guide must lock:

- Main palette and accent colors
- Title/subtitle scale and recurring placement
- Content panel geometry and margins
- Icon and illustration style
- Background texture or scene rules
- Page number, chapter label, and footer treatment
- Rules for diagrams, arrows, cards, charts, and callouts

## Visual Design

Each slide must teach through visual structure. Prefer process maps, cycles, funnels, matrices, before-after comparisons, checklists, storyboard panels, timelines, decision trees, dashboards, scene diagrams, and annotated examples. Make abstract concepts visible, structured, and memorable.

Keep text sparse:

- One message per slide.
- Short Chinese labels, not paragraphs.
- Use large titles and readable labels.
- Avoid tiny UI text, dense bullet lists, and decorative text blocks.
- Use icons, arrows, numbers, panels, and spatial relationships to express logic.
- Keep title size, title position, panel rhythm, margin system, icon weight, glow/shadow treatment, and footer treatment consistent after the style is selected.
- Repeat the same visual language for the same teaching role: all chapter divider pages should feel related; all framework pages should share a layout grammar; all practice pages should share a worksheet grammar.

Read `references/visual-courseware-patterns.md` when choosing a style direction or matching the user's previous examples. Read `references/visual-logic-library.md` when choosing the best structure for a concept.

## Image Generation

Generate every slide image independently with `gpt-image-2`.

Default final image settings:

- Model: `gpt-image-2`
- Size: `1920x1080`
- Quality: `high`
- Aspect ratio: 16:9
- Output format: PNG when possible

For each slide, write a page prompt in `page-prompts.md` before generating the image. Each prompt must specify:

- Course title and audience
- Slide number and slide role
- Exact Chinese text that should appear on the slide
- Visual metaphor, layout, and hierarchy
- Style direction
- Locked style-guide details after the user has selected a style
- Negative constraints: no long paragraphs, no unreadable small Chinese text, no extra invented labels, no distorted logos, no watermark

Save generated pages as:

```text
courseware-output/<course-title>/pages/slide-01.png
courseware-output/<course-title>/pages/slide-02.png
```

## Quality Gate

Inspect each generated slide before assembly. Regenerate a page when:

- Chinese text is wrong, garbled, too small, or too dense.
- The visual does not express the intended logic.
- The page looks like generic decoration rather than teaching material.
- The page does not follow the selected style guide.
- Important content is cropped, overlapped, or visually buried.
- Style consistency breaks without a teaching reason.

Use OCR or visual inspection where available. If exact text fidelity is critical, keep the on-image text even shorter and regenerate until clean.

## Speaker Notes

Every slide must have instructor notes in this format:

```text
讲解目标：...

讲解要点：...

过渡提示：...
```

Write notes for speaking, not reading. Include the teaching intent, examples or prompts the instructor can say, and the bridge to the next slide.

## Assembly

Create `deck_manifest.json` following `references/manifest-schema.md`. Then run:

```powershell
powershell -ExecutionPolicy Bypass -File scripts/assemble_ppt.ps1 -ManifestPath "courseware-output/<course-title>/deck_manifest.json"
```

The script uses Microsoft PowerPoint automation. It creates a 16:9 deck, inserts each image full-bleed, writes speaker notes, and saves the `.pptx`.

If PowerPoint automation is unavailable, stop and tell the user. Do not fall back to Python PPT generation.

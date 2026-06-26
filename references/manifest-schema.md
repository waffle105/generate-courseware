# Deck Manifest Schema

Create `deck_manifest.json` in the course output directory before running `scripts/assemble_ppt.ps1`.

## Required Shape

```json
{
  "title": "课程名",
  "slide_size": {
    "width_px": 1920,
    "height_px": 1080
  },
  "output_pptx": "课程名_图片型PPT_带讲师备注.pptx",
  "slides": [
    {
      "number": 1,
      "title": "封面标题",
      "image": "pages/slide-01.png",
      "notes": "讲解目标：...\n\n讲解要点：...\n\n过渡提示：..."
    }
  ]
}
```

## Rules

- Resolve relative `image` and `output_pptx` paths from the manifest folder.
- Keep slide numbers contiguous starting from 1.
- Use 1920x1080 images unless the user explicitly requested another 16:9 size.
- Notes must include `讲解目标：`, `讲解要点：`, and `过渡提示：`.
- The assembler inserts images full-bleed; do not include separate PPT text boxes for slide content.

# Generate Courseware / 视觉化中文课件生成

## 中文

Generate Courseware 是一个用于生成视觉化、低文字、图片型中文教学课件的 Codex skill。它适合把主题、教学大纲、课程目标或培训方案转化为完整的 PPT 制作流程：先做课程页级规划，再提供两套视觉风格选择，最后生成 1920x1080 全页图片并组装成带讲师备注的 PowerPoint。

### 适合场景

- 中文培训课件、企业内训课件和工作坊课件
- 管理、战略、AI、营销、数字化等主题课程
- 低文字密度、高视觉结构的教学型 PPT
- 需要先比较两套风格再制作全套课件的项目
- 需要讲师备注和全页图片式 PPT 的交付

### 核心能力

- 生成页级课程计划和讲师备注草案
- 根据课程内容选择流程图、矩阵、漏斗、飞轮、路线图等视觉逻辑
- 先生成两套风格样张供选择
- 生成统一风格的 1920x1080 全页课件图片
- 使用 PowerPoint 自动化组装图片型 PPT 并写入讲师备注

### 使用方式

把本仓库作为一个 Codex skill 安装或复制到你的 Codex skills 目录，然后在 Codex 中说：

```text
Use $generate-courseware 根据这个主题/大纲生成一套视觉化中文教学课件：……
```

## English

Generate Courseware is a Codex skill for creating visual, low-text, image-based Chinese teaching decks. It turns a topic, syllabus, training goal, or lesson outline into a complete deck workflow: slide-level planning, two visual style directions, full-slide 1920x1080 images, and a PowerPoint deck with instructor notes.

### Best For

- Chinese training decks, corporate learning decks, and workshop materials
- Management, strategy, AI, marketing, and digital transformation courses
- Low-text, high-structure teaching slides
- Projects that need style options before full deck production
- Deliverables that require image-based PPT pages and speaker notes

### What It Does

- Creates slide-level course plans and draft speaker notes
- Maps course concepts to visual structures such as workflows, matrices, funnels, flywheels, and roadmaps
- Produces two style directions for selection
- Generates consistent 1920x1080 full-slide courseware images
- Uses PowerPoint automation to assemble a deck and add instructor notes

### Usage

Install or copy this repository into your Codex skills directory, then ask Codex:

```text
Use $generate-courseware create a visual Chinese teaching deck from this topic or syllabus: ...
```

## License

MIT

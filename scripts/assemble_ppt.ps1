param(
    [Parameter(Mandatory = $true)]
    [string]$ManifestPath
)

$ErrorActionPreference = "Stop"
$NoteLabelGoal = [string]::Concat([char]0x8BB2, [char]0x89E3, [char]0x76EE, [char]0x6807, [char]0xFF1A)
$NoteLabelPoints = [string]::Concat([char]0x8BB2, [char]0x89E3, [char]0x8981, [char]0x70B9, [char]0xFF1A)
$NoteLabelTransition = [string]::Concat([char]0x8FC7, [char]0x6E21, [char]0x63D0, [char]0x793A, [char]0xFF1A)
$ChineseNotesPlaceholder = [string]::Concat([char]0x5355, [char]0x51FB, [char]0x4EE5, [char]0x6DFB, [char]0x52A0, [char]0x5907, [char]0x6CE8)
$ChineseNotesShort = [string]::Concat([char]0x5907, [char]0x6CE8)

function Resolve-FromBase {
    param(
        [Parameter(Mandatory = $true)][string]$BasePath,
        [Parameter(Mandatory = $true)][string]$PathValue
    )

    if ([System.IO.Path]::IsPathRooted($PathValue)) {
        return [System.IO.Path]::GetFullPath($PathValue)
    }

    return [System.IO.Path]::GetFullPath((Join-Path $BasePath $PathValue))
}

function Set-SlideNotes {
    param(
        [Parameter(Mandatory = $true)]$Slide,
        [Parameter(Mandatory = $true)][string]$Notes
    )

    $notesPage = $Slide.NotesPage
    foreach ($shape in $notesPage.Shapes) {
        try {
            if ($shape.HasTextFrame -and $shape.TextFrame.HasText) {
                $text = $shape.TextFrame.TextRange.Text
                if ($text -match "Click to add notes" -or $text -match [regex]::Escape($ChineseNotesPlaceholder) -or $text -match [regex]::Escape($ChineseNotesShort)) {
                    $shape.TextFrame.TextRange.Text = $Notes
                    return
                }
            }
        } catch {
            continue
        }
    }

    try {
        $placeholder = $notesPage.Shapes.Placeholders(2)
        $placeholder.TextFrame.TextRange.Text = $Notes
        return
    } catch {
        $notesPage.Shapes.AddTextbox(1, 72, 360, 576, 180).TextFrame.TextRange.Text = $Notes | Out-Null
    }
}

if (-not (Test-Path -LiteralPath $ManifestPath)) {
    throw "Manifest not found: $ManifestPath"
}

$manifestFullPath = [System.IO.Path]::GetFullPath($ManifestPath)
$baseDir = Split-Path -Parent $manifestFullPath
$manifest = Get-Content -LiteralPath $manifestFullPath -Raw -Encoding UTF8 | ConvertFrom-Json

if (-not $manifest.slides -or $manifest.slides.Count -eq 0) {
    throw "Manifest must contain at least one slide."
}

$expected = 1
foreach ($slide in $manifest.slides) {
    if ([int]$slide.number -ne $expected) {
        throw "Slide numbers must be contiguous from 1. Expected $expected, got $($slide.number)."
    }

    $imagePath = Resolve-FromBase -BasePath $baseDir -PathValue $slide.image
    if (-not (Test-Path -LiteralPath $imagePath)) {
        throw "Slide image not found: $imagePath"
    }

    if (-not ($slide.notes.Contains($NoteLabelGoal)) -or -not ($slide.notes.Contains($NoteLabelPoints)) -or -not ($slide.notes.Contains($NoteLabelTransition))) {
        throw "Slide $expected notes must include the required Chinese note labels."
    }

    $expected++
}

$outputName = $manifest.output_pptx
if (-not $outputName) {
    $safeTitle = ($manifest.title -replace '[\\/:*?"<>|]', '_')
    $outputName = "$safeTitle`_image-courseware-with-notes.pptx"
}
$outputPath = Resolve-FromBase -BasePath $baseDir -PathValue $outputName

try {
    $powerPoint = New-Object -ComObject PowerPoint.Application
} catch {
    throw "Microsoft PowerPoint automation is unavailable. Install PowerPoint or assemble manually; do not use Python PPT generation."
}

$presentation = $null
try {
    $powerPoint.Visible = -1
    $presentation = $powerPoint.Presentations.Add()
    $presentation.PageSetup.SlideWidth = 960
    $presentation.PageSetup.SlideHeight = 540

    while ($presentation.Slides.Count -gt 0) {
        $presentation.Slides.Item(1).Delete()
    }

    foreach ($slideInfo in $manifest.slides) {
        $slide = $presentation.Slides.Add([int]$slideInfo.number, 12)
        $imagePath = Resolve-FromBase -BasePath $baseDir -PathValue $slideInfo.image
        $shape = $slide.Shapes.AddPicture($imagePath, 0, -1, 0, 0, 960, 540)
        $shape.LockAspectRatio = 0
        $shape.Left = 0
        $shape.Top = 0
        $shape.Width = 960
        $shape.Height = 540
        Set-SlideNotes -Slide $slide -Notes ([string]$slideInfo.notes)
    }

    $outputDir = Split-Path -Parent $outputPath
    if (-not (Test-Path -LiteralPath $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }

    $presentation.SaveAs($outputPath)
    Write-Output "Saved PPTX: $outputPath"
} finally {
    if ($presentation -ne $null) {
        $presentation.Close()
    }
    if ($powerPoint -ne $null) {
        $powerPoint.Quit()
    }
    if ($presentation -ne $null) {
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($presentation) | Out-Null
    }
    if ($powerPoint -ne $null) {
        [System.Runtime.InteropServices.Marshal]::ReleaseComObject($powerPoint) | Out-Null
    }
    [GC]::Collect()
    [GC]::WaitForPendingFinalizers()
}

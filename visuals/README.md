# visuals

Source code for the figures in the book. Each figure is a standalone R script
that writes a `.png` into `output/`.

## Why R and ggplot2

These are diagrams, not plots, so almost any tool would do. R was the obvious
pick here: the book's audience already reads R, so the scripts double as
examples readers can modify, and there's no extra toolchain to install beyond
what the book already assumes. `ragg` renders the text more cleanly than the
default png device, which matters when half the figure is monospaced code.

## Running them

From inside this folder:

```bash
Rscript make-all.R                      # rebuild everything
Rscript make-01-duplicating-join.R      # rebuild just one
```

Requires `ggplot2` and `ragg`.

## Files

| Script | Output | Error class |
|---|---|---|
| `make-01-duplicating-join.R` | `01-duplicating-join.png` | Data processing — structural corruption |
| `make-02-semantic-error.R` | `02-semantic-error.png` | Data processing — semantic misalignment |
| `make-03-formula-misread.R` | `03-formula-misread.png` | Model logic |
| `make-04-results-misinterpretation.R` | `04-results-misinterpretation.png` | Result misinterpretation |
| `make-05-misalignment.R` | `05-misalignment.png` | Misalignment |

`_theme.R` holds the shared palette, fonts, and the small helpers
(`panel_box()`, `txt_mono()`, `txt_sans()`, `arrow_seg()`, `save_fig()`) that
every figure is built from. Change a colour there and all four follow.

## Conventions

- **Teal** is correct or expected, **rust** is the mistake, **purple** is an
  annotation about intent.
- Monospace (Menlo) for anything standing in for data or code; sans for prose.
- Each figure carries its own title, subtitle and caption, so it still reads
  if it's lifted out of the book.

## Using them in the book

Figures are written to `output/`, then copied into `resources/section-6/`,
which is where the `.qmd` files point:

```bash
cp output/*.png ../resources/section-6/
```

```markdown
![Alt text describing what the figure shows.](../resources/section-6/01-duplicating-join.png)
```

All five are currently used in `section-6-agentic-engineering/01-classes-of-errors.qmd`.
Figures are written at 300 dpi, sized for a full-width book column.

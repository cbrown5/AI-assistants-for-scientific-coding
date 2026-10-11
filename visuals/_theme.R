# Shared look and feel for the error-class figures.
# Sourced by each make-*.R script; not meant to be run on its own.

library(ggplot2)

# --- palette -----------------------------------------------------------------
# Muted base with a single warm accent for "this is the mistake".
pal <- list(
  ink      = "#1f2328",  # primary text
  muted    = "#6b7280",  # secondary text
  rule     = "#d0d7de",  # borders, gridlines
  panel    = "#ffffff",  # table/code background
  shade    = "#f6f8fa",  # alternate row / header fill
  good     = "#2c7a7b",  # teal: correct, expected
  goodfill = "#d7eceb",
  bad      = "#b4401f",  # rust: error, duplicated, wrong
  badfill  = "#fae3da",
  note     = "#8250df",  # purple: annotation / intent
  notefill = "#efe7fb"
)

# Fonts: Menlo for anything standing in for code or data, sans for prose.
font_mono <- "Menlo"
font_sans <- "Helvetica Neue"

# --- base theme --------------------------------------------------------------
# These figures are diagrams, not plots: no axes, no gridlines, no background.
theme_fig <- function(base_size = 11) {
  theme_void(base_size = base_size, base_family = font_sans) %+replace%
    theme(
      plot.background  = element_rect(fill = "white", colour = NA),
      plot.title       = element_text(
        family = font_sans, face = "bold", size = base_size * 1.35,
        colour = pal$ink, hjust = 0, margin = margin(b = 4)
      ),
      plot.subtitle    = element_text(
        family = font_sans, size = base_size * 1.0,
        colour = pal$muted, hjust = 0, margin = margin(b = 12), lineheight = 1.3
      ),
      plot.caption     = element_text(
        family = font_sans, size = base_size * 0.85,
        colour = pal$muted, hjust = 0, margin = margin(t = 12), lineheight = 1.3
      ),
      plot.title.position   = "plot",
      plot.caption.position = "plot",
      plot.margin      = margin(16, 16, 14, 16),
      legend.position  = "none"
    )
}

# --- building blocks ---------------------------------------------------------

# A rounded panel to sit behind a table or code block.
panel_box <- function(xmin, xmax, ymin, ymax,
                      fill = pal$panel, colour = pal$rule, linewidth = 0.4) {
  annotate("rect", xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax,
           fill = fill, colour = colour, linewidth = linewidth)
}

# Monospaced text, left-aligned by default: data cells and code.
txt_mono <- function(x, y, label, colour = pal$ink, size = 3.5,
                     hjust = 0, fontface = "plain") {
  annotate("text", x = x, y = y, label = label, colour = colour, size = size,
           hjust = hjust, vjust = 0.5, family = font_mono, fontface = fontface)
}

# Sans text: labels, annotations, callouts.
txt_sans <- function(x, y, label, colour = pal$ink, size = 3.5,
                     hjust = 0, fontface = "plain", lineheight = 1.15) {
  annotate("text", x = x, y = y, label = label, colour = colour, size = size,
           hjust = hjust, vjust = 0.5, family = font_sans, fontface = fontface,
           lineheight = lineheight)
}

# Column-header rule under a table header row.
hrule <- function(xmin, xmax, y, colour = pal$rule, linewidth = 0.4) {
  annotate("segment", x = xmin, xend = xmax, y = y, yend = y,
           colour = colour, linewidth = linewidth)
}

# An arrow between two points, for flow between panels.
arrow_seg <- function(x, xend, y, yend = y, colour = pal$muted,
                      linewidth = 0.5, len = 2.4) {
  annotate("segment", x = x, xend = xend, y = y, yend = yend,
           colour = colour, linewidth = linewidth,
           arrow = arrow(length = unit(len, "mm"), type = "closed"))
}

# --- output ------------------------------------------------------------------
# One writer for every figure, so sizing and resolution stay consistent.
# ragg renders text more cleanly than the default png device.
save_fig <- function(plot, file, width, height, dpi = 300) {
  if (!dir.exists("output")) dir.create("output", recursive = TRUE)
  path <- file.path("output", file)
  ggsave(path, plot, device = ragg::agg_png,
         width = width, height = height, units = "in", dpi = dpi,
         bg = "white")
  message("wrote ", path, " (", width, "x", height, "in @ ", dpi, "dpi)")
  invisible(path)
}

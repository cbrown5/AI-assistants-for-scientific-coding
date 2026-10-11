# Figure: a semantic error — the code is correct, the meaning is not.
# Two columns with similar names and different units are combined; the join
# key matches, every type is numeric, nothing fails. The result is nonsense.

source("_theme.R")

rh   <- 1
y_hd <- 0
row_y <- function(i) y_hd - i * rh

A <- c(xmin = 0.0, xmax = 4.5)    # survey data, depth in metres
B <- c(xmin = 5.6, xmax = 10.1)   # logger data, depth in feet

dat_a <- data.frame(
  site  = c("A", "B", "C"),
  depth = c("12.0", "18.5", "7.2")
)

dat_b <- data.frame(
  site  = c("A", "B", "C"),
  depth = c("39.4", "60.7", "23.6")
)

p <- ggplot() +
  # ---------------- table A: metres -----------------------------------------
  panel_box(A["xmin"], A["xmax"], row_y(3) - rh / 2, y_hd + rh / 2) +
  annotate("rect", xmin = A["xmin"], xmax = A["xmax"],
           ymin = y_hd - rh / 2, ymax = y_hd + rh / 2,
           fill = pal$shade, colour = NA) +
  hrule(A["xmin"], A["xmax"], y_hd - rh / 2) +
  txt_mono(A["xmin"] + 0.25, y_hd, "site", pal$muted, fontface = "bold") +
  txt_mono(A["xmin"] + 1.60, y_hd, "depth", pal$muted, fontface = "bold") +
  txt_mono(A["xmin"] + 0.25, row_y(1:3), dat_a$site) +
  txt_mono(A["xmin"] + 1.60, row_y(1:3), dat_a$depth) +
  txt_sans(A["xmin"], y_hd + 1.15, "diver survey", pal$ink,
           size = 3.6, fontface = "bold") +
  txt_sans(A["xmin"], y_hd + 0.72, "depth recorded in metres",
           pal$good, size = 3.1) +
  # unit tag
  annotate("rect", xmin = A["xmax"] - 1.35, xmax = A["xmax"] - 0.2,
           ymin = row_y(2) - 0.28, ymax = row_y(2) + 0.28,
           fill = pal$goodfill, colour = pal$good, linewidth = 0.35) +
  txt_mono(A["xmax"] - 0.775, row_y(2), "metres", pal$good,
           size = 2.9, hjust = 0.5) +

  # ---------------- table B: feet -------------------------------------------
  panel_box(B["xmin"], B["xmax"], row_y(3) - rh / 2, y_hd + rh / 2) +
  annotate("rect", xmin = B["xmin"], xmax = B["xmax"],
           ymin = y_hd - rh / 2, ymax = y_hd + rh / 2,
           fill = pal$shade, colour = NA) +
  hrule(B["xmin"], B["xmax"], y_hd - rh / 2) +
  txt_mono(B["xmin"] + 0.25, y_hd, "site", pal$muted, fontface = "bold") +
  txt_mono(B["xmin"] + 1.60, y_hd, "depth", pal$muted, fontface = "bold") +
  txt_mono(B["xmin"] + 0.25, row_y(1:3), dat_b$site) +
  txt_mono(B["xmin"] + 1.60, row_y(1:3), dat_b$depth) +
  txt_sans(B["xmin"], y_hd + 1.15, "depth logger", pal$ink,
           size = 3.6, fontface = "bold") +
  txt_sans(B["xmin"], y_hd + 0.72, "depth recorded in feet",
           pal$bad, size = 3.1) +
  annotate("rect", xmin = B["xmax"] - 1.15, xmax = B["xmax"] - 0.2,
           ymin = row_y(2) - 0.28, ymax = row_y(2) + 0.28,
           fill = pal$badfill, colour = pal$bad, linewidth = 0.35) +
  txt_mono(B["xmax"] - 0.675, row_y(2), "feet", pal$bad,
           size = 2.9, hjust = 0.5) +

  # ---------------- the column name is identical ----------------------------
  # label in the gap between the panels, clear of both tables
  txt_sans(mean(c(A["xmax"], B["xmin"])), row_y(1) + 0.30,
           "same column", pal$note, size = 2.9, hjust = 0.5,
           fontface = "bold") +
  txt_sans(mean(c(A["xmax"], B["xmin"])), row_y(1),
           "name,", pal$note, size = 2.9, hjust = 0.5, fontface = "bold") +
  txt_sans(mean(c(A["xmax"], B["xmin"])), row_y(1) - 0.30,
           "same type", pal$note, size = 2.9, hjust = 0.5, fontface = "bold") +

  # ---------------- the code that runs fine ---------------------------------
  panel_box(A["xmin"], B["xmax"], row_y(3) - 2.35, row_y(3) - 0.75,
            fill = pal$shade) +
  txt_mono(A["xmin"] + 0.3, row_y(3) - 1.15,
           "dat <- bind_rows(survey, logger)", pal$ink, size = 3.3) +
  txt_mono(A["xmin"] + 0.3, row_y(3) - 1.62,
           "mean(dat$depth)   # 26.9", pal$ink, size = 3.3) +
  txt_mono(A["xmin"] + 0.3, row_y(3) - 2.05,
           "# runs clean. no error. no warning.", pal$muted, size = 3.1) +

  # ---------------- the verdict ---------------------------------------------
  annotate("rect", xmin = A["xmin"], xmax = B["xmax"],
           ymin = row_y(3) - 4.05, ymax = row_y(3) - 2.65,
           fill = pal$badfill, colour = pal$bad, linewidth = 0.4) +
  txt_sans(A["xmin"] + 0.3, row_y(3) - 3.35,
           "26.9 of what? The mean mixes metres and feet.\nEvery type checks out; the number means nothing.",
           pal$bad, size = 3.2, lineheight = 1.3) +

  labs(
    title = "A semantic error",
    subtitle = paste(
      "The code is right and the data are right — but they don't mean",
      "the same thing.\nColumn names match, types match, the join key",
      "matches, and the units don't."
    ),
    caption = "Units, time zones and date formats live in the metadata, not the data. Say them out loud in the spec."
  ) +
  coord_cartesian(
    xlim = c(A["xmin"] - 0.3, B["xmax"] + 0.3),
    ylim = c(row_y(3) - 4.35, y_hd + 1.5),
    expand = FALSE
  ) +
  theme_fig()

save_fig(p, "02-semantic-error.png", width = 8.2, height = 5.6)

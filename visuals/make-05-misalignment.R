# Figure: a misalignment error.
# Two routes to the same results.csv. The intended route runs the analysis.
# The route the agent took skipped it and wrote plausible numbers directly.
# The deliverable exists either way, and looks the same either way.

source("_theme.R")

X <- c(xmin = 0.0, xmax = 13.6)
mid <- mean(c(X["xmin"], X["xmax"]))

# lane x-extents
Lx <- c(xmin = 0.0, xmax = 6.4)    # intended route
Rx <- c(xmin = 7.2, xmax = 13.6)   # what happened

# step box helper: a small labelled box in a lane
step <- function(x0, x1, y, label, fill, border, txtcol, face = "plain") {
  list(
    annotate("rect", xmin = x0, xmax = x1, ymin = y - 0.34, ymax = y + 0.34,
             fill = fill, colour = border, linewidth = 0.4),
    annotate("text", x = (x0 + x1) / 2, y = y, label = label,
             colour = txtcol, size = 3.1, family = font_mono,
             hjust = 0.5, vjust = 0.5, fontface = face)
  )
}

p <- ggplot() +
  # ---------------- the ask -------------------------------------------------
  annotate("rect", xmin = X["xmin"], xmax = X["xmax"], ymin = -0.45, ymax = 0.45,
           fill = pal$notefill, colour = pal$note, linewidth = 0.4) +
  txt_sans(X["xmin"] + 0.35, 0,
           "“Fix the errors in the script so it runs and produces results.csv”",
           pal$ink, size = 3.5) +

  # fork
  annotate("segment", x = mid, xend = mid, y = -0.55, yend = -1.0,
           colour = pal$muted, linewidth = 0.5) +
  annotate("segment", x = mean(c(Lx["xmin"], Lx["xmax"])),
           xend = mean(c(Rx["xmin"], Rx["xmax"])),
           y = -1.0, yend = -1.0, colour = pal$muted, linewidth = 0.5) +
  arrow_seg(mean(c(Lx["xmin"], Lx["xmax"])), mean(c(Lx["xmin"], Lx["xmax"])),
            -1.0, -1.45) +
  arrow_seg(mean(c(Rx["xmin"], Rx["xmax"])), mean(c(Rx["xmin"], Rx["xmax"])),
            -1.0, -1.45) +

  # ---------------- left lane: the intended route ---------------------------
  txt_sans(Lx["xmin"], -1.75, "what you asked for", pal$good,
           size = 3.4, fontface = "bold") +
  step(Lx["xmin"], Lx["xmax"], -2.45, "debug the script",
       pal$goodfill, pal$good, pal$good) +
  arrow_seg(mean(c(Lx["xmin"], Lx["xmax"])), mean(c(Lx["xmin"], Lx["xmax"])),
            -2.85, -3.25, colour = pal$good) +
  step(Lx["xmin"], Lx["xmax"], -3.6, "run the analysis",
       pal$goodfill, pal$good, pal$good) +
  arrow_seg(mean(c(Lx["xmin"], Lx["xmax"])), mean(c(Lx["xmin"], Lx["xmax"])),
            -4.0, -4.4, colour = pal$good) +
  step(Lx["xmin"], Lx["xmax"], -4.75, "write results.csv",
       pal$goodfill, pal$good, pal$good) +

  # ---------------- right lane: what the agent did --------------------------
  txt_sans(Rx["xmin"], -1.75, "what the agent did", pal$bad,
           size = 3.4, fontface = "bold") +
  step(Rx["xmin"], Rx["xmax"], -2.45, "hit errors it couldn't fix",
       pal$badfill, pal$bad, pal$bad) +
  arrow_seg(mean(c(Rx["xmin"], Rx["xmax"])), mean(c(Rx["xmin"], Rx["xmax"])),
            -2.85, -3.25, colour = pal$bad) +
  step(Rx["xmin"], Rx["xmax"], -3.6, "gave up on the script",
       pal$badfill, pal$bad, pal$bad) +
  arrow_seg(mean(c(Rx["xmin"], Rx["xmax"])), mean(c(Rx["xmin"], Rx["xmax"])),
            -4.0, -4.4, colour = pal$bad) +
  step(Rx["xmin"], Rx["xmax"], -4.75, "wrote results.csv by hand",
       pal$badfill, pal$bad, pal$bad, face = "bold") +

  # the analysis never ran
  txt_sans(mean(c(Rx["xmin"], Rx["xmax"])), -5.35,
           "\u2191  the analysis never ran", pal$bad, size = 3.0,
           hjust = 0.5, fontface = "italic") +

  # ---------------- both arrive at the same file ----------------------------
  arrow_seg(mean(c(Lx["xmin"], Lx["xmax"])), mid - 0.55, -5.15, -5.95,
            colour = pal$muted) +
  arrow_seg(mean(c(Rx["xmin"], Rx["xmax"])), mid + 0.55, -5.15, -5.95,
            colour = pal$muted) +

  panel_box(mid - 3.2, mid + 3.2, -7.5, -6.25, fill = pal$shade) +
  txt_mono(mid, -6.65, "results.csv", pal$ink, size = 3.5, hjust = 0.5,
           fontface = "bold") +
  txt_sans(mid, -7.1, "same filename, same shape, plausible numbers",
           pal$muted, size = 3.0, hjust = 0.5) +

  # ---------------- the point -----------------------------------------------
  annotate("rect", xmin = X["xmin"], xmax = X["xmax"],
           ymin = -9.2, ymax = -7.95,
           fill = pal$badfill, colour = pal$bad, linewidth = 0.4) +
  txt_sans(X["xmin"] + 0.35, -8.58,
           "You asked for a file, and you got a file. Open it and the numbers look reasonable.\nNothing downstream can tell you they were never computed.",
           pal$bad, size = 3.2, lineheight = 1.3) +

  labs(
    title = "A misalignment error",
    subtitle = paste(
      "The agent delivers what you asked for without doing what you meant.",
      "Here it satisfied\nthe literal request — a results file — by",
      "skipping the analysis that was the point."
    ),
    caption = "Ask to see the run, not just the output. Check timestamps, logs, and whether the numbers can be reproduced."
  ) +
  coord_cartesian(
    xlim = c(X["xmin"] - 0.3, X["xmax"] + 0.3),
    ylim = c(-9.5, 0.95),
    expand = FALSE
  ) +
  theme_fig()

save_fig(p, "05-misalignment.png", width = 9.6, height = 6.4)

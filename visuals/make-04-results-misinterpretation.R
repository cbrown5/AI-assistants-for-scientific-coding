# Figure: results misinterpretation.
# The model is right, the data are right, the coefficient is right. The prose
# the agent writes about it is wrong — a log-link coefficient read as if it
# were on the response scale.

source("_theme.R")

X <- c(xmin = 0.0, xmax = 12.4)

p <- ggplot() +
  # ---------------- the model output ----------------------------------------
  txt_sans(X["xmin"], 0.62, "the model output", pal$ink,
           size = 3.6, fontface = "bold") +
  txt_sans(X["xmin"] + 3.1, 0.62, "— correct, nothing wrong here",
           pal$good, size = 3.1) +
  panel_box(X["xmin"], X["xmax"], -2.5, 0.25, fill = pal$panel) +
  annotate("rect", xmin = X["xmin"], xmax = X["xmax"],
           ymin = -0.35, ymax = 0.25, fill = pal$shade, colour = NA) +
  hrule(X["xmin"], X["xmax"], -0.35) +
  txt_mono(X["xmin"] + 0.3, -0.05,  "            Estimate  Std.Error  z     p",
           pal$muted, size = 3.2, fontface = "bold") +
  txt_mono(X["xmin"] + 0.3, -0.75,  "(Intercept)   0.693      0.21    3.3  <0.01",
           pal$ink, size = 3.2) +
  txt_mono(X["xmin"] + 0.3, -1.25,  "CB_cover      0.030      0.009   3.3  <0.01",
           pal$ink, size = 3.2) +
  txt_mono(X["xmin"] + 0.3, -1.95,  "family: negative binomial  (log link)",
           pal$note, size = 3.2, fontface = "bold") +

  # ---------------- what the agent says -------------------------------------
  arrow_seg(mean(c(X["xmin"], X["xmax"])), mean(c(X["xmin"], X["xmax"])),
            -2.7, -3.2) +
  txt_sans(X["xmin"], -3.6, "what the agent writes in the summary", pal$ink,
           size = 3.6, fontface = "bold") +
  panel_box(X["xmin"], X["xmax"], -4.85, -3.9, fill = pal$badfill,
            colour = pal$bad) +
  txt_sans(X["xmin"] + 0.3, -4.38,
           "“Each 1% increase in coral cover is associated with 0.03 more fish per site.”",
           pal$ink, size = 3.4) +

  # ---------------- why it is wrong -----------------------------------------
  txt_sans(X["xmin"], -5.42, "why that is wrong", pal$bad,
           size = 3.4, fontface = "bold") +
  txt_sans(X["xmin"] + 0.3, -5.95,
           "The coefficient is on the log scale. 0.03 is not 0.03 fish — it is a",
           pal$ink, size = 3.3) +
  txt_sans(X["xmin"] + 0.3, -6.38,
           "multiplicative effect: exp(0.03) = 1.03, a 3% increase per 1% coral cover.",
           pal$ink, size = 3.3) +
  txt_sans(X["xmin"] + 0.3, -6.95,
           "At 20 fish per site that is +0.6 fish; at 2 fish it is +0.06. The effect is",
           pal$ink, size = 3.3) +
  txt_sans(X["xmin"] + 0.3, -7.38,
           "not a constant number of fish at all.",
           pal$ink, size = 3.3) +

  # ---------------- the point -----------------------------------------------
  annotate("rect", xmin = X["xmin"], xmax = X["xmax"],
           ymin = -9.1, ymax = -7.9,
           fill = pal$shade, colour = pal$rule, linewidth = 0.4) +
  txt_sans(X["xmin"] + 0.3, -8.5,
           "Nothing in the code is wrong, so no test, no diagnostic and no review of the\nscript will catch this. It is only visible in the prose.",
           pal$ink, size = 3.3, lineheight = 1.3) +

  labs(
    title = "A result misinterpreted",
    subtitle = paste(
      "The hardest class to catch: the data are clean, the model is right,",
      "the coefficient\nis correct — and the sentence describing it is not."
    ),
    caption = "Ask for effects on the response scale, with the units named."
  ) +
  coord_cartesian(
    xlim = c(X["xmin"] - 0.3, X["xmax"] + 0.3),
    ylim = c(-9.4, 1.05),
    expand = FALSE
  ) +
  theme_fig()

save_fig(p, "04-results-misinterpretation.png", width = 9.4, height = 6.6)

# Figure: a text description misread as an R model formula.
# The scientist's sentence says one thing; the formula the agent writes says
# another. Both are plausible R. Only one answers the question asked.

source("_theme.R")

X <- c(xmin = 0.0, xmax = 12.0)

p <- ggplot() +
  # ---------------- what the scientist wrote --------------------------------
  txt_sans(X["xmin"], 0.60, "what you wrote in the spec", pal$ink,
           size = 3.6, fontface = "bold") +
  panel_box(X["xmin"], X["xmax"], -1.55, 0.25,
            fill = pal$notefill, colour = pal$note) +
  txt_sans(X["xmin"] + 0.3, -0.35,
           "“Fit fish abundance against coral cover, allowing the effect of coral",
           pal$ink, size = 3.5) +
  txt_sans(X["xmin"] + 0.3, -0.82,
           "to vary by reef, with a random intercept for site.”",
           pal$ink, size = 3.5) +
  txt_sans(X["xmin"] + 0.3, -1.28,
           "three things asked for: a fixed effect, a varying slope, a random intercept",
           pal$note, size = 3.0, fontface = "italic") +

  # ---------------- what the agent wrote ------------------------------------
  arrow_seg(mean(c(X["xmin"], X["xmax"])), mean(c(X["xmin"], X["xmax"])),
            -1.75, -2.25) +
  txt_sans(X["xmin"], -2.65, "what the agent wrote", pal$ink,
           size = 3.6, fontface = "bold") +
  panel_box(X["xmin"], X["xmax"], -4.0, -2.95, fill = pal$badfill,
            colour = pal$bad) +
  txt_mono(X["xmin"] + 0.3, -3.35,
           "glmmTMB(fish ~ coral + reef + (1 | site),", pal$ink, size = 3.6) +
  txt_mono(X["xmin"] + 0.3, -3.72,
           "        family = nbinom2, data = dat)", pal$ink, size = 3.6) +

  # the three claims, checked off against the formula
  txt_sans(X["xmin"] + 0.3, -4.55,
           "✓  fixed effect of coral", pal$good, size = 3.3) +
  txt_sans(X["xmin"] + 0.3, -5.0,
           "✓  random intercept for site", pal$good, size = 3.3) +
  txt_sans(X["xmin"] + 0.3, -5.45,
           "✗  effect of coral varying by reef", pal$bad, size = 3.3,
           fontface = "bold") +
  txt_sans(X["xmin"] + 4.9, -5.45,
           "—  + reef shifts the intercept by reef;",
           pal$bad, size = 3.3) +
  txt_sans(X["xmin"] + 4.9, -5.88,
           "    a varying slope needs coral * reef, or (coral | reef).",
           pal$bad, size = 3.3) +

  # ---------------- the point -----------------------------------------------
  annotate("rect", xmin = X["xmin"], xmax = X["xmax"],
           ymin = -7.65, ymax = -6.45,
           fill = pal$shade, colour = pal$rule, linewidth = 0.4) +
  txt_sans(X["xmin"] + 0.3, -7.05,
           "The model fits. The summary table looks fine. It is answering a different question\nto the one you asked — and no diagnostic will tell you so.",
           pal$ink, size = 3.3, lineheight = 1.3) +

  labs(
    title = "A sentence misread as a formula",
    subtitle = paste(
      "Prose is ambiguous; a model formula is not. Anywhere the English",
      "leaves room,\nthe agent fills it with whatever it has seen most often."
    ),
    caption = "Write the equation in the spec, then check the formula line against it."
  ) +
  coord_cartesian(
    xlim = c(X["xmin"] - 0.3, X["xmax"] + 0.3),
    ylim = c(-7.95, 1.0),
    expand = FALSE
  ) +
  theme_fig()

save_fig(p, "03-formula-misread.png", width = 9.2, height = 6.0)

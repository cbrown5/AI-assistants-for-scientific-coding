# Figure: a join that duplicates rows.
# Two small tables joined on `site`; site B appears twice on the right, so the
# result has 4 rows instead of 3 and B's fish count is double-counted.

source("_theme.R")

# --- layout constants --------------------------------------------------------
rh   <- 1        # row height
y_hd <- 0        # header row sits at y = 0, data rows go negative

# x extents of the three panels
L <- c(xmin = 0.0,  xmax = 3.4)    # left: fish counts
R <- c(xmin = 5.3,  xmax = 8.9)    # right: site lookup (has a duplicate)
J <- c(xmin = 9.7,  xmax = 14.5)   # result: joined, with duplicated row

row_y <- function(i) y_hd - i * rh  # i = 1..n

# --- data shown in the figure ------------------------------------------------
left <- data.frame(
  site = c("A", "B", "C"),
  fish = c("12", "30", "7")
)

right <- data.frame(
  site  = c("A", "B", "B", "C"),
  coral = c("18", "42", "55", "9"),
  dup   = c(FALSE, TRUE, TRUE, FALSE)
)

joined <- data.frame(
  site  = c("A", "B", "B", "C"),
  fish  = c("12", "30", "30", "7"),
  coral = c("18", "42", "55", "9"),
  dup   = c(FALSE, TRUE, TRUE, FALSE)
)

p <- ggplot() +
  # ---------------- left table: fish counts ---------------------------------
  panel_box(L["xmin"], L["xmax"], row_y(4) - rh / 2, y_hd + rh / 2) +
  annotate("rect", xmin = L["xmin"], xmax = L["xmax"],
           ymin = y_hd - rh / 2, ymax = y_hd + rh / 2,
           fill = pal$shade, colour = NA) +
  hrule(L["xmin"], L["xmax"], y_hd - rh / 2) +
  txt_mono(L["xmin"] + 0.25, y_hd, "site", pal$muted, fontface = "bold") +
  txt_mono(L["xmin"] + 1.60, y_hd, "fish", pal$muted, fontface = "bold") +
  txt_mono(L["xmin"] + 0.25, row_y(seq_len(nrow(left))), left$site) +
  txt_mono(L["xmin"] + 1.60, row_y(seq_len(nrow(left))), left$fish) +
  txt_sans(L["xmin"], y_hd + 1.15, "fish counts", pal$ink,
           size = 3.6, fontface = "bold") +
  txt_sans(L["xmin"], y_hd + 0.72, "3 rows, one per site", pal$muted, size = 3.1) +

  # ---------------- right table: site lookup with a duplicate key -----------
  panel_box(R["xmin"], R["xmax"], row_y(nrow(right)) - rh / 2, y_hd + rh / 2) +
  annotate("rect", xmin = R["xmin"], xmax = R["xmax"],
           ymin = y_hd - rh / 2, ymax = y_hd + rh / 2,
           fill = pal$shade, colour = NA) +
  # highlight the two rows that share key B
  annotate("rect", xmin = R["xmin"], xmax = R["xmax"],
           ymin = row_y(3) - rh / 2, ymax = row_y(2) + rh / 2,
           fill = pal$badfill, colour = NA) +
  hrule(R["xmin"], R["xmax"], y_hd - rh / 2) +
  txt_mono(R["xmin"] + 0.25, y_hd, "site", pal$muted, fontface = "bold") +
  txt_mono(R["xmin"] + 1.70, y_hd, "coral", pal$muted, fontface = "bold") +
  txt_mono(R["xmin"] + 0.25, row_y(seq_len(nrow(right))), right$site,
           colour = ifelse(right$dup, pal$bad, pal$ink),
           fontface = ifelse(right$dup, "bold", "plain")) +
  txt_mono(R["xmin"] + 1.70, row_y(seq_len(nrow(right))), right$coral,
           colour = ifelse(right$dup, pal$bad, pal$ink)) +
  txt_sans(R["xmin"], y_hd + 1.15, "coral surveys", pal$ink,
           size = 3.6, fontface = "bold") +
  txt_sans(R["xmin"], y_hd + 0.72,
           "4 rows — site B was surveyed twice", pal$bad, size = 3.1) +

  # ---------------- result table --------------------------------------------
  panel_box(J["xmin"], J["xmax"], row_y(nrow(joined)) - rh / 2, y_hd + rh / 2) +
  annotate("rect", xmin = J["xmin"], xmax = J["xmax"],
           ymin = y_hd - rh / 2, ymax = y_hd + rh / 2,
           fill = pal$shade, colour = NA) +
  annotate("rect", xmin = J["xmin"], xmax = J["xmax"],
           ymin = row_y(3) - rh / 2, ymax = row_y(2) + rh / 2,
           fill = pal$badfill, colour = NA) +
  hrule(J["xmin"], J["xmax"], y_hd - rh / 2) +
  txt_mono(J["xmin"] + 0.25, y_hd, "site", pal$muted, fontface = "bold") +
  txt_mono(J["xmin"] + 1.55, y_hd, "fish", pal$muted, fontface = "bold") +
  txt_mono(J["xmin"] + 2.85, y_hd, "coral", pal$muted, fontface = "bold") +
  txt_mono(J["xmin"] + 0.25, row_y(seq_len(nrow(joined))), joined$site,
           colour = ifelse(joined$dup, pal$bad, pal$ink),
           fontface = ifelse(joined$dup, "bold", "plain")) +
  txt_mono(J["xmin"] + 1.55, row_y(seq_len(nrow(joined))), joined$fish,
           colour = ifelse(joined$dup, pal$bad, pal$ink),
           fontface = ifelse(joined$dup, "bold", "plain")) +
  txt_mono(J["xmin"] + 2.85, row_y(seq_len(nrow(joined))), joined$coral,
           colour = ifelse(joined$dup, pal$bad, pal$ink)) +
  txt_sans(J["xmin"], y_hd + 1.15, "joined result", pal$ink,
           size = 3.6, fontface = "bold") +
  txt_sans(J["xmin"], y_hd + 0.72,
           "4 rows — site B's 30 fish counted twice", pal$bad, size = 3.1) +

  # ---------------- join arrows and code ------------------------------------
  arrow_seg(L["xmax"] + 0.12, R["xmin"] - 0.12, row_y(2)) +
  arrow_seg(R["xmax"] + 0.12, J["xmin"] - 0.12, row_y(2)) +
  txt_mono(mean(c(L["xmax"], R["xmin"])), row_y(1) + 0.30,
           "left_join(fish, coral,", pal$muted, size = 2.8, hjust = 0.5) +
  txt_mono(mean(c(L["xmax"], R["xmin"])), row_y(1) - 0.10,
           "by = \"site\")", pal$muted, size = 2.8, hjust = 0.5) +

  # ---------------- the catch ------------------------------------------------
  annotate("rect",
           xmin = L["xmin"], xmax = R["xmax"],
           ymin = row_y(4) - 2.05, ymax = row_y(4) - 0.75,
           fill = pal$badfill, colour = pal$bad, linewidth = 0.4) +
  txt_sans(L["xmin"] + 0.3, row_y(4) - 1.4,
           "nrow() went 3 → 4, and site B's 30 fish are counted twice.\nEvery mean, total and model fit downstream is quietly wrong.",
           pal$bad, size = 3.2, lineheight = 1.3) +

  labs(
    title = "A join that duplicates rows",
    subtitle = paste(
      "A one-to-many join silently inflates the data. Nothing errors,",
      "no warning is printed — the\ntable just gets longer and every",
      "summary computed from it is quietly wrong."
    ),
    caption = "Check nrow() before and after every join."
  ) +
  coord_cartesian(
    xlim = c(L["xmin"] - 0.3, J["xmax"] + 0.3),
    ylim = c(row_y(4) - 2.35, y_hd + 1.5),
    expand = FALSE
  ) +
  theme_fig()

save_fig(p, "01-duplicating-join.png", width = 10.5, height = 4.5)

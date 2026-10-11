# Rebuild every figure in this folder.
# Run from inside visuals/:  Rscript make-all.R
# Each script is run in its own environment so they can't leak state.

scripts <- sort(list.files(".", pattern = "^make-[0-9]+.*\\.R$"))

for (s in scripts) {
  message("--- ", s)
  sys.source(normalizePath(s), envir = new.env(parent = globalenv()))
}

message("\ndone: ", length(scripts), " figures in output/")

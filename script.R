abstract <- "The loss of nursery habitats is widely believed to contribute disproportionally to declines in abundance and productivity of fish populations. However, it has been difficult to establish links between the processes threatening nurseries and changes in population demography. Here we show that juvenile bumphead parrotfish (Bolbometopon muricatum), an iconic coral reef species that is globally threatened, depend on a highly specific micro-habitat that is vulnerable to sedimentation from logging operations. We conducted surveys on fringing reefs in Solomon Islands. Surveys covered reefs around an island that has been selectively logged, and an island where there has been no logging. B. muricatum juveniles were restricted to shallow lagoonal reefs that fringed mangrove forested shorelines and had a high proportion of live branching corals, with the smallest settlers found in Acropora aspera and Acropora micropthalma colonies that were occupied by damselfish. Statistical path models indicated a 24 times decline in juvenile abundance near logging operations due to the mediating effect of habitat loss, and a possible direct effect of sedimentation on abundance. Our study shows that sedimentation can pose a significant threat to near-shore coral reef fish and highlights the role of nursery habitats in sustaining recruitment to reef fish populations. "

chat <- chat_ollama(
    model = "qwen2.5-coder:7b",
    system_prompt = "You extract structured metadata from ecology abstracts."
)

chat$chat(paste(
    "Which species and sample size are reported in this abstract? ",
    abstract
))


#

chat <- chat_ollama(
    model = "qwen2.5-coder:7b",
    system_prompt = "You extract structured metadata from ecology abstracts."
)

paper_stats <- type_object(
    sample_size = type_number("Sample size of the study"),
    year_of_study = type_number("Year data was collected"),
    species = type_string("Latin binomial of species in the study")
)

fish_study <- chat$chat_structured(abstract, type = paper_stats)

fish_study$sample_size
fish_study$year_of_study
fish_study$species

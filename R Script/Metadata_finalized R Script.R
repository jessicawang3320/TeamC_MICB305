metadata <- read.csv("metadata_updated.csv")
head(metadata)
metadata$Response <- with(metadata, ifelse(
  is.na(IgG_responder) | is.na(IgA_responder), "NA",
  ifelse(IgG_responder == "Non-responder" & IgA_responder == "Responder", "IgA",
  ifelse(IgG_responder == "Responder" & IgA_responder == "Non-responder", "IgG",
  ifelse(IgG_responder == "Responder" & IgA_responder == "Responder", "Both",
  ifelse(IgG_responder == "Non-responder" & IgA_responder == "Non-responder", "None", NA)))))
)

head(metadata)

write.csv(metadata, "metadata_finalized.csv")

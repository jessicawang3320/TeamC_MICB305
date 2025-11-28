library(tidyverse)
library(phyloseq)
library(ggpubr)

#Load data
metadata = read.delim('metadata_finalized.tsv')
taxonomy <- read.delim('taxonomy.tsv', row.names = 1)
counts <- read.delim('feature-table1.txt', skip=1, row.names=1)
tree <- read_tree('tree.nwk')

#Create phyloseq object
taxonomy_formatted = taxonomy %>%
  separate(col = Taxon,
           into = c('Domain', 'Phylum', 'Class', 'Order',
                    'Family', 'Genus', 'Species'),
           sep=';', fill = 'right') %>%
  select(-Confidence) %>%
  as.matrix()

counts_formatted = counts %>% as.matrix()
view(taxonomy_formatted)
view(counts_formatted)
view(metadata)

metadata <- metadata %>%
  column_to_rownames("ID")

ps = phyloseq(sample_data(metadata),
              otu_table(counts_formatted, taxa_are_rows = TRUE),
              tax_table(taxonomy_formatted),
              tree)

ps <- ps %>%
  subset_samples(!is.na(Response)) %>%
  subset_samples(Vaccination.Status != "control")

ps_dose_1 <- ps %>%
  subset_samples(Vaccination.Status == "1-dose")

ps_dose_4 <- ps %>%
  subset_samples(Vaccination.Status == "4-dose")

saveRDS(ps_dose_1, file = "ps_dose1.rds")
saveRDS(ps_dose_4, file = "ps_dose4.rds")
saveRDS(ps, file = "ps_alldoses.rds")

#Save each in .r data, phyloseq object into R scripts, one for 1-dose, one for 4-dose, use save function
#Loading the same phyloseq but keep each analysis into separate files





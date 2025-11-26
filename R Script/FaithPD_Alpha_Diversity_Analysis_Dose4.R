library(tidyverse)
library(phyloseq)
library(vegan)
library(ggpubr)
library(picante)
library(ape)

#Load data
metadata = read.delim('metadata_finalized.tsv')
ps_4 <- readRDS("ps_dose4.rds")

#Rarefy sample
windows()
hist(sample_sums(ps_4))
rarecurve( t(data.frame(ps_4@otu_table)),
           step=10)
ps4rare = ps_4 %>% rarefy_even_depth(sample.size = 3804, rngseed = 420)

table(sample_sums(ps4rare))
sample_variables(ps4rare)

#Run Faith's PD analysis
set.seed(420)
phy_tree(ps4rare)
is.rooted(phy_tree(ps4rare))

ps4rare <- prune_taxa(taxa_names(ps4rare) %in% phy_tree(ps4rare)$tip.label, ps4rare)

otu_mat <- as(otu_table(ps4rare), "matrix")
if (taxa_are_rows(ps4rare)) otu_mat <- t(otu_mat)
rowSums(otu_mat)[1:10]
tree <- phy_tree(ps4rare)

setequal(taxa_names(ps4rare), phy_tree(ps4rare)$tip.label)

pd_result <- picante::pd(samp = otu_mat, tree = tree, include.root = TRUE)
pd_result

sample_data(ps4rare)$Faith_PD <- pd_result$PD

#Plot Faith's PD analysis

p_formatted <- ggplot(sample_data(ps4rare), aes(x = Response, y = Faith_PD, fill = Response)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(height = 0, width = 0.3) +
  theme_classic(base_size = 16) +
  ylab('Faiths PD') + 
  xlab(NULL) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(fill = '4-dose Response')
p_formatted

comparisons = list(c("None", "IgG"), c("None", "IgA"), c("None", "Both"))

p_plot <- p_formatted +
  stat_compare_means(comparisons = comparisons, 
                     method = 'wilcox.test',  
                     size = 4,
                     label = "p.format") 

ggsave(filename ="Faith_PD_plot_dose4.png",
       plot = p_plot, width = 8, height = 5, dpi = 300)

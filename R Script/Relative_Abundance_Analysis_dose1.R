#ANCOMBC2 Relative Abundance Analysis

library(ggplot2)
library(tidyverse)
library(ANCOMBC)
library(phyloseq)
library(dplyr)
library(stringr)

set.seed(1)

metadata = read.delim('metadata_finalized.tsv')
ps_1 <- readRDS("ps_dose1.rds")

sample_data(ps_1)$Response <- factor(
  sample_data(ps_1)$Response,
  levels = c("None", "IgA", "IgG", "Both")
)
contrasts(sample_data(ps_1)$Response) <- contr.treatment(
  n = 4,          # number of levels
  base = 1        # reference = level 1 = "None"
)
contrasts(sample_data(ps_1)$Response)
ps_1
#ancom dose 1

out = ancombc2(
  data = ps_1,
  assay_name = "counts",        
  tax_level = "Genus",            
  fix_formula = "Response",     
  p_adj_method = "BH",
  prv_cut = 0.1
)

#results from ancom
res <- out$res
names(res)
View(res)


#significant differences dose 1 (relative to nonresponders)
sig_taxa <- res %>% filter(diff_ResponseBoth == T) %>%
  mutate(sig = q_ResponseBoth < 0.05) %>%
  mutate(direction = ifelse(lfc_ResponseBoth > 0, "Higher in Both", "Higher in None"))

sig_taxa <- sig_taxa %>%
  mutate(
    Genus = str_extract(taxon, "g__[^;]+") # extract g__xxxxx
  )
sig_taxa$Genus[is.na(sig_taxa$Genus)] <- "Unknown"

#Interpret Direction
volcano_df <- res %>% 
  mutate(direction = ifelse(lfc_ResponseBoth > 0, "Higher in Both", "Higher in None")) %>%
  mutate(sig = q_ResponseBoth < 0.05)

 
#Volcano plot
Volcanoplot_dose1 <- ggplot(volcano_df, aes(x = lfc_ResponseBoth, 
                                          y = -log10(q_ResponseBoth), 
                                          color = direction,
                                          shape = sig)) +
  geom_point(size = 3, alpha = 0.8) +
  scale_color_manual(values = c(
    "Higher in None" = "blue",
    "Higher in Both" = "red"
  )) +
  scale_shape_manual(values = c(`FALSE` = 1, `TRUE` = 16)) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey50") +
  geom_hline(yintercept = -log10(0.05), linetype = "dotted", color = "grey50") +
  labs(
    title = "Volcano Plot – Response with 1-dose",
    x = "Log Fold Change (Both vs None)",
    y = "-log10(FDR)"
  ) +
  theme_bw(base_size = 14)

#Bar plot of significant Taxa

Sig_taxa_dose1 <- ggplot(sig_taxa, 
       aes(x = reorder(Genus, lfc_ResponseBoth),
           y = lfc_ResponseBoth,
           fill = direction)) +
   geom_col() +
  coord_flip() +
  scale_fill_manual(values = c(
    "Higher in Both" = "red",
    "Higher in None" = "blue"
  )) +
  labs(
    title = "Significant Taxa - Response with 1-dose",
    x = "Genus",
    y = "Log Fold Change (Both vs None)"
  ) +
  theme_bw(base_size = 14)


#saving plot
ggsave("Volcano_plot_dose1.png", plot = Volcanoplot_dose1,
       width = 8,
       height = 6,
       dpi = 300)
       
ggsave("Sig_taxa_plot_dose1.png", plot = Sig_taxa_dose1,
       width = 8,
       height = 6,
       dpi = 300)


library(tidyverse)
library(phyloseq)
library(vegan)
library(ggpubr)

#Load data
metadata = read.delim('metadata_finalized.tsv')
ps_4 <- readRDS("ps_dose4.rds")

#Rarefy sample
windows()
hist(sample_sums(ps_4))
rarecurve( t(data.frame(ps_1@otu_table)),
           step=10)
ps4rare = ps_4 %>% rarefy_even_depth(sample.size = 3804, rngseed = 423)

table(sample_sums(ps4rare))
sample_variables(ps4rare)

#Calculate Shannon alpha diversity
set.seed(423)
p = plot_richness(ps4rare, x = 'Response',
                  measures = 'Shannon', 
                  color = 'Response',)
pdata = p$data
str(pdata)
names(pdata)
unique(pdata$Response)

#Add Wilcox test and create a box plot

p_formatted <- ggplot(pdata, aes(Response,value,fill = Response)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(height = 0, width = 0.3) +
  theme_classic(base_size = 16) +
  ylab('Shannon Alpha Diversity') + 
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

ggsave(filename ="shannon_alpha_diversity_plot_dose4.png",
       plot = p_plot, width = 8, height = 5, dpi = 300)

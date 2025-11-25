library(tidyverse)
library(phyloseq)
library(vegan)
library(ggpubr)

#Load data
metadata = read.delim('metadata_finalized.tsv')
ps_1 <- readRDS("ps_dose1.rds")

#Rarefy sample
windows()
hist(sample_sums(ps_1))
rarecurve( t(data.frame(ps_1@otu_table)),
           step=10)
ps1rare = ps_1 %>% rarefy_even_depth(sample.size = 3804, rngseed = 421)

table(sample_sums(ps1rare))
sample_variables(ps1rare)

#Calculate Observed alpha diversity
set.seed(421)
p = plot_richness(ps1rare, x = 'Response',
                  measures = 'Observed', 
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
  ylab('Observed Alpha Diversity') + 
  xlab(NULL) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(fill = '1-dose Response')
p_formatted

comparisons = list(c("None", "IgG"), c("None", "IgA"), c("None", "Both"))

p_plot <- p_formatted +
  stat_compare_means(comparisons = comparisons, 
                     method = 'wilcox.test',  
                     size = 4,
                     label = "p.format") 

ggsave(filename ="observed_alpha_diversity_plot_dose1.png",
       plot = p_plot, width = 8, height = 5, dpi = 300)

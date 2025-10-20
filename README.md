# MICB 305 Final Project
Authors: Amy, Ellie, and Jessica

under construction

## Background 

## Research Questions 
Main topic of interest: Exploring the Relationship Between Vaccination and 
Alterations in the Human Gut Microbiome 

Central Question: How do vaccines affect the composition, diversity, and function
of the gut microbiome, and what mechanisms underlie these changes?

Possible Subtopics/ Aims: 
1. Does sex play a role in these changes?
2. How is the composition of the gut microbiota different between the responders and nonresponders of the oral typhoid vaccine?
3. What does functional analysis of microbiota tell about the role of microbiota plays in individuals responded with IgG and those responded with IgA? Or individuals that responded with both IgG and IgA? (IgG can induce inflammatory response while IgA is anti-inflammatory).
4. Do different doses of vaccine change the microbiome composition at a certain time point after the vaccine was administered?
5. How does the diversity of gut microbiota shift before immunization, at the day of immunization, and post immunization?
6. What bacteria is more abundant in individuals with higher response to oral typhoid vaccine?


## Methods 

## Results
## Dataset Overview
The fecal bacterial 16S rRNA pyrosequencing dataset was acquired from Eloe-Fadrosh et al.'s published article "Impact of Oral Typhoid Vaccination on the Human Gut Microbiota and Correlations with S. Typhi-Specific Immunological Responses" in 2013.  Stool samples were collected from seventeen adult individuals from the Baltimore-Washington area and the University of Maryland 7 days before the oral typhoid vaccination, the day of vaccination, and at 8 timestamps post vaccination. The V1-V2 region of the bacterial 16S rRNA gene was sequenced to produce 162 samples. 

Figure 1 represents the quality plot of the sequenced data before denoising. The demultiplexed dataset contains single-end reads have different read lengths, with a maximum read length of 381 nucleotides and a minimum read length of 347 nucleotides. Based on the quality of the data shown in Figure 1, a standard of 30 (99.9 accuracy) was set as the median quality score to determine the read length for all sequences. From around 0-350 nucleotides, the quality score fluctuated, but all kept a median quality score above or around 30. The quality starts to decrease at above 350 nucleotides. Therefore, all reads were truncated and kept with the same read length of 350 nucleotides. The information on the demultiplexed dataset was obtained from viewing the Interactive Quality Plot of demux_seqs.qzv using the QIIME 2 view.

<img width="1330" height="787" alt="image" src="https://github.com/user-attachments/assets/99465c56-9494-45fd-9650-f4764edb178c" />
Figure 1: Read quality plot showing the quality score of each sequence base. Produced with QIIME2 using random sampling of 10,000 out of 1,232,947 sequences of 162 samples.





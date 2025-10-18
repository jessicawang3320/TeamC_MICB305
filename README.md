# MICB 305 Final Project
Authors: Amy, Ellie, and Jessica

under construction

## Background 

## Research Questions 
Main topic of interest: Exploring the Relationship Between Vaccination and 
Alterations in the Human Gut Microbiome 

Central Question: How do vaccines affect the composition, diversity, and function
of the gut microbiome, and what mechanisms underlie these changes?

Possible Subtopics: 
- Does sex play a role in these changes? 
- Does 

## Methods 

## Results
## Dataset Overview
The fecal bacterial 16S rRNA pyrosequencing dataset was acquired from Eloe-Fadrosh et al.'s published article "Impact of Oral Typhoid Vaccination on the Human Gut Microbiota and Correlations with S. Typhi-Specific Immunological Responses" in 2013.  Stool samples were collected from seventeen adult individuals from the Baltimore-Washington area and the University of Maryland 7 days before the oral typhoid vaccination, the day of vaccination, and at 8 timestamps post vaccination. The V1-V2 region of the bacterial 16S rRNA gene was sequenced to produce 162 samples. 

Figure 1 represents the quality plot of the sequenced data before denoising. The demultiplexed dataset contains single-end reads have different read lengths, with a maximum read length of 381 nucleotides and a minimum read length of 347 nucleotides. Based on the quality of the data shown in Figure 1, a standard of 30 (99.9 accuracy) was set as the median quality score to determine the read length for all sequences. From around 0-350 nucleotides, the quality score fluctuated, but all kept a median quality score above or around 30. The quality starts to decrease at above 350 nucleotides. Therefore, all reads were truncated and kept with the same read length of 350 nucleotides. The information on the demultiplexed dataset was obtained from viewing the Interactive Quality Plot of demux_seqs.qzv using the QIIME 2 view.

<img width="772" height="1004" alt="image" src="https://github.com/user-attachments/assets/4e3ef72d-1a0c-41b9-b7f6-344b4edcb765" />
<img width="1330" height="787" alt="image" src="https://github.com/user-attachments/assets/99465c56-9494-45fd-9650-f4764edb178c" />
Figure 1: Read quality plot showing the quality score of each sequence base. Produced with QIIME2 using random sampling of 10,000 out of 1,232,947 sequences of 162 samples.
<img width="764" height="144" alt="image" src="https://github.com/user-attachments/assets/38148f3d-76d0-4c58-bc7c-177d4feec55f" />





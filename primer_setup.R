## Primer 6 set up

# Load these packages 
library(vegan)
library(tidyverse)
 
## create distance matrix from your OTU table 
set.seed(999)
bray.dist.matrix <- avgdist(OTU_TABLE_WIDE, sample = (# you want to rarefy to), meanfun = median,transf= sqrt, iterations = 100, round.out = T)

# create tsv
write.table((as.data.frame(as.matrix(bray.dist.matrix))), file = "bray_matrix.tsv", quote=FALSE, sep='\t', col.names = NA)

## Get matching metadata 

metadata <- YOUR_METADATA_DF %>%
  rownames_to_column("sample_identifier") 

sample_w_otus <- row.names(bray.dist.matrix)

# filter metadata based on rarefied OTU table
matching_metadata <- metadata %>%
  filter(sample_identifier %in% sample_w_otus)

matching_metadata <- matching_metadata %>%
  column_to_rownames("sample_identifier") 

# create tsv
write.table(t(matching_metadata), file = "matching_metadata_bray.tsv", quote=FALSE, sep='\t', col.names = NA)


#### Open both tsvs in excel. Copy the metadata and paste it under the matrix with one row in between. Save as a new tsv and import into Primer as "aggregate data". 

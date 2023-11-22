library(DropletUtils)
library(Matrix)

# Reads the command line arguments
path <- commandArgs(trailingOnly = TRUE)

# Reads the raw matrix and calculates the probability of each
# droplet being a cell or not, then filtering the raw matrix
sce <- read10xCounts(path)
out <- na.omit(emptyDrops(counts(sce)))
cells <- rownames(sce)[which(out$FDR <= 0.001)]
sce <- sce[cells, ]

# Write the output
writeMM(counts(sce), file = "matrix.mtx")

# Input Requirements

To run the workflow, you need to provide an input CSV file named `SampleSheet.csv` with the following format:

| [10X_Data]  |                   |                   |          |        |              |
|:-----------:|:-----------------:|:-----------------:|:--------:|:------:|:------------:|
| Sample_ID   | Sample_Species    | Sample_Project    | force    | agg    | pipeline     |
| sample-1    | human             | project1          | n        | n      | scrna-10x    |
| sample-2    | human             | project1          | n        | n      | scrna-10x    |
| sample-3    | human             | project2          | n        | n      | scrna-10x    |

The input CSV file should start with the line `[10X_Data]`, followed by the necessary columns.

Explanation of each column:

* **Sample_ID**: This column contains a unique identifier for each sample to be processed. The Sample_ID should match the corresponding fastq file according to 10X specifications.
* **Sample_Species**: This column determines which reference genome will be used for the analysis.
* **Sample_Project**: The Sample_Project column specifies the folder where the analysis results will be saved. The value should match the project folder where the fastq files are located. You can refer to the [documentation](/docs/Setup.md) for more details.
* **force**: Use this column if you want to force a specific number of cells during processing.
* **agg**: If you want to aggregate all the processed samples for visualization, set this column accordingly.
* **pipeline**: This column specifies the pipeline that should be used for the sample. In this case, the value should be set to `scrna-10x`.

# Workflow specific processing steps
* Generation of config.csv as described here: https://support.10xgenomics.com/single-cell-vdj/software/pipelines/latest/using/multi#examples
* Running of cellranger multi on config files as described here https://support.10xgenomics.com/single-cell-vdj/software/pipelines/latest/using/multi#running-multi

# Reading EmptyDroplet output

## Scanpy
```python
import scanpy as sc
from scipy.io import mmread

# Read the count matrix
adata = sc.AnnData(X=mmread('output.mtx').T)

# Add cell names and gene names to the AnnData object
# Replace 'genes.tsv' and 'cells.tsv' with the paths to your gene and cell names files
adata.var_names = [line.strip() for line in open('genes.tsv')]
adata.obs_names = [line.strip() for line in open('cells.tsv')]

# Now you can use the 'adata' object for your analysis
```

## Seurat
```
library(Seurat)

# Read the count matrix
seurat_object <- Read10X(data.dir = "path_to_your_directory")

# Now you can use the 'seurat_object' for your analysis

```
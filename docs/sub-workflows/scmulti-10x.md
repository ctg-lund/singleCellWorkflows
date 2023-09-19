# Samplesheet requirement

| Sample_ID     | sample_pair | libtype | Sample_Species | Sample_Project |
|---------------|-------------|---------|----------------|----------------|
| Sample-1-gex  | 1           | gex     | human          | project1       |
| Sample-1-tcr | 1           | tcr    | human          | project1       |
| Sample-1-bcr | 1           | bcr    | human          | project1       |

* Sample_ID: Needs to fatch with the fastq name
* sample_pair: Samples that will be combined into a config.csv file for cellranger
* libtype : what library type of the fastq library (gex/tcr/bcr)
* Sample_Species: Which reference genome that will be used from the nextflow.config
* Sample_Project: Which folder the sample will land in.

# Nextflow.config requirements
Other than standard parameters, following parameters needs to be defined:
* human : Path to the human reference transcriptome
* mouse : Path to the mouse reference transcriptome
* human_vdj : Path to the human vdj reference
* mouse_vdj : Path to the mouse vdj reference
* COUNT_ARC : The path to the container which cellranger-arc is called from

# Workflow specific processing steps
* Generation of config.csv files a described here: https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/multi#examples
* Running of cellranger as described here: https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/multi#cellranger-multi
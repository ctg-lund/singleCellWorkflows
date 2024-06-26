# Samplesheet requirement

| Sample_ID     | sample_pair | libtype | Sample_Species | Sample_Project |
|---------------|-------------|---------|----------------|----------------|
| Sample-1-gex  | 1           | gex     | human          | project1       |
| Sample-1-atac | 1           | atac    | human          | project1       |

* Sample_ID: Needs to fatch with the fastq name
* sample_pair: Samples that will be combined into a library.csv file for cellranger
* libtype : what library type of the fastq library (gex/atac)
* Sample_Species: Which reference genome that will be used from the nextflow.config
* Sample_Project: Which folder the sample will land in.

# Nextflow.config requirements
Other than standard parameters, following parameters needs to be defined:
* human_atac : Path to the human arc reference genome
* mouse_atac : Path to the arc mouse reference genome
* COUNT_ARC : The path to the container which cellranger-arc is called from

# Workflow specific processing steps
* Generate library.csv files as described here https://support.10xgenomics.com/single-cell-multiome-atac-gex/software/pipelines/latest/using/count#library-csv
* `cellranger-arc count` on library files as described here
* Generate multiqc parseable files based on the metrics files generated by cellranger-arc
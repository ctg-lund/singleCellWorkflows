# Samplesheet requirement

| Sample_ID | Sample_Species | Sample_Project | force | agg |
|-----------|----------------|----------------|-------|-----|
| Sample-1  | human          | project1       | n     | n   |
| Sample-2  | human          | project1       | 4000  | n   |


* Sample_ID: Needs to fatch with the fastq name
* Sample_Species: Which reference genome that will be used from the nextflow.config
* Sample_Project: Which folder the sample will land in.
* force : (n / integer) if a sample should be forced to a cell count, if so specify how many samples
* agg : if samples should be aggregated by cellranger. We use it for internal purposes, should be left as n almost always.

# Nextflow.config requirements
Other than standard parameters, following parameters needs to be defined:
* human_atac : Path to the human arc reference genome
* mouse_atac : Path to the arc mouse reference genome
* COUNT_ATAC : The path to the container which cellranger-arc is called from
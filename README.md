# CTG singleCellWorkflows
## Introduction
This will act as the starting point for future singleCell nextflow pipelines. The thought is to develop each module to work independetly so that they will all we interchangeable in the end. 


## Required inputs

* SampleSheet as formated in [the examples](/examples/CTG_SampleSheet.csv) with the following columns:
  * Sample_ID - Identifier of a project, must be the same as the file names of the fastq files.
  * Sample_Species - *human* or *mouse*
  * Sample_Project - What project a sample is associated with
  * force - If cellranger count should force the number of cells, 99% of the cases should be left as 'n', otherwise specify it as an integer.
  * agg - If all samples should be aggregated, `cellranger aggr` into the same space after. 'n' or 'y' and should be left as 'n' majority of the times.

* fqdir - the directory where you can find the fastq files.

## How to run
Normally:
```
nextflow run pipe-sc-rna-10x.nf --samplesheet </path/to/your/samplesheet.csv> \
    --fqdir </path/to/your/fastqs> \
```
With stub:
```bash
nextflow run pipe-sc-rna-10x.nf --samplesheet examples/samplesheet.csv  \
    --outdir /Users/jacobkarlstrom/Projects/pipelines/sc-rna-10x-dsl2/examples/output \
    -profile local_dev \
    -stub-run \
    --fqdir /Users/jacobkarlstrom/Projects/pipelines/sc-rna-10x-dsl2/examples
```

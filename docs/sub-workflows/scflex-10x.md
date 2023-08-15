# Input Requirements

To run the workflow, you need to provide an input CSV file named `SampleSheet.csv` with the following format:
|                   |              |              |     |   |           |
|-------------------|--------------|--------------|-----|---|-----------|
|[10X_Data]         |              |              |     |   |           |
|Sample_ID          |Sample_Species|Sample_Project|force|agg|pipeline   |
|sample-7           |human         |project4      |n    |n  |scflex-10x |
|sample-8           |human         |project5      |n    |n  |scflex-10x |
|sample-9           |human         |project4      |n    |n  |scflex-10x |
|[10X_Flex_Settings]|              |              |     |   |           |
|sample_id          |probe_barcode |Sample_Source |     |   |           |
|sample1            |BC001&#124;BC002   |sample_7      |     |   |           |
|sample1            |BC003&#124;BC004   |sample-8      |     |   |           |




Explanation of each column:
## 10X_Data
* **Sample_ID**: This column contains a unique identifier for each sample to be processed. The Sample_ID should match the corresponding fastq file according to 10X specifications.
* **Sample_Species**: This column determines which reference genome will be used for the analysis.
* **Sample_Project**: The Sample_Project column specifies the folder where the analysis results will be saved. The value should match the project folder where the fastq files are located. You can refer to the [documentation](/docs/Setup.md) for more details.
* **force**: Use this column if you want to force a specific number of cells during processing.
* **agg**: If you want to aggregate all the processed samples for visualization, set this column accordingly.
* **pipeline**: This column specifies the pipeline that should be used for the sample. In this case, the value should be set to `scciteseq-10x`.
## 10X_Flex_Settings
Described [here](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/multi-frp#samples) by 10X official documentation.
Special case is `Sample_Source` which need to match a sample from the 10X_Data section. If no match is found, pipeline assumes it's a singleplex sample.

# How to Run

To execute the workflow, use the following command:

```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv>
```
Or if using custom probes:
```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv> --custom_genome </path/to/custom_genome> --custom_probes </path/to/custom_probes>
```
Replace `</path/to/your/samplesheet.csv>` with the actual path to your SampleSheet.csv file. The `--analysis` option should be set to `scflex-10x` to indicate the pipeline to use for analysis.

## Note if using custom probes
You will need to construct both a reference genome and a reference probe set. Until I have set up a guide for that, contact 10X for more information.

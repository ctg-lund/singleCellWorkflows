# Input Requirements

To run the workflow, you need to provide an input CSV file named `SampleSheet.csv` with the following format:
|[10X_Data]|                        | |                                        |          |           |         |        | |
|----------|-----------------------------|------|---------------------------------------------|---------------|----------------|--------------|-------------|------|
|Sample_ID |Sample_Species               |Sample_Project|force                                        |agg            |sample_pair     |libtype       |pipeline     |      |
|sample-4  |human                        |project3|n                                            |n              |1               |gex           |scciteseq-10x|      |
|sample-5  |human                        |project3|n                                            |n              |1               |hto           |scciteseq-10x|      |
|sample-6  |human                        |project3|n                                            |n              |1               |adt           |scciteseq-10x|      |
|[10X_FeatureReference]|                             |      |                                             |               |                |              |             |      |
|id        |name                         |read  |pattern                                      |sequence       |feature_type    |Sample_Project|             |      |
|ADT_C0014 |HuMs.CD11b                   |R2    |5PNNNNNNNNNN(BC)                             |TGAAGGCTCATTTGT|Antibody Capture|project3      |             |      |
|ADT_C0073 |HuMs.CD44                    |R2    |5PNNNNNNNNNN(BC)                             |TGGCTTCAGGTCCTA|Antibody Capture|project3      |             |      |
|ADT_C0103 |HuMs.CD45R_B220              |R2    |5P(BC)                                       |CCTACACCTCATAAT|Antibody Capture|project3      |             |      |
|ADT_C0104 |HuMs.CD45R_B220              |R2    |5P(BC)                                       |CCTACATTTCATAAT|Antibody Capture|project6      |             |      |


Explanation of each column:
## 10X_Data
* **Sample_ID**: This column contains a unique identifier for each sample to be processed. The Sample_ID should match the corresponding fastq file according to 10X specifications.
* **Sample_Species**: This column determines which reference genome will be used for the analysis.
* **Sample_Project**: The Sample_Project column specifies the folder where the analysis results will be saved. The value should match the project folder where the fastq files are located. You can refer to the [documentation](/docs/Setup.md) for more details.
* **force**: Use this column if you want to force a specific number of cells during processing.
* **agg**: If you want to aggregate all the processed samples for visualization, set this column accordingly.
* **pipeline**: This column specifies the pipeline that should be used for the sample. In this case, the value should be set to `scciteseq-10x`.
* **sample_pair** Species which samples are paired for `cellranger count`.
* **libtype** Dictates how the sample will be treated. Available type [gex|adt|hto|crispr]
## 10X_FeatureReference
Described [here](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/feature-bc-analysis) by 10X official documentation.

# How to Run

To execute the workflow, use the following command:

```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv> 
```

Replace `</path/to/your/samplesheet.csv>` with the actual path to your SampleSheet.csv file. The `--analysis` option should be set to `scciteseq-10x` to indicate the pipeline to use for analysis.
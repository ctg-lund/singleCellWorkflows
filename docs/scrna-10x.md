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

# How to Run

To execute the workflow, use the following command:

```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv> --analysis scrna-10x
```

Replace `</path/to/your/samplesheet.csv>` with the actual path to your SampleSheet.csv file. The `--analysis` option should be set to `scrna-10x` to indicate the pipeline to use for analysis.
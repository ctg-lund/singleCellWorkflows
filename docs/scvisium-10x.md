# Input Requirements

To run the workflow, you need to provide an input CSV file named `SampleSheet.csv` with the following format:

Mandatory columns with explanation:
* **Sample_ID**: This column contains a unique identifier for each sample to be processed. The Sample_ID should match the corresponding fastq file according to 10X specifications.
* **Sample_Species**: This column determines which reference genome will be used for the analysis.
* **Sample_Project**: The Sample_Project column specifies the folder where the analysis results will be saved. The value should match the project folder where the fastq files are located. You can refer to the [documentation](/docs/Setup.md) for more details.
* **image**: The brightfield image used in experiment.
* **darkimage**: The name of the darkfield image used in the experiment.
* **cytaimage**: The name of the cytassist image.
* **pipeline**: This column specifies the pipeline that should be used for the sample. In this case, the value should be set to `scvisium-10x`.

# Set up

Before you run this workflow you will need to create the project directory and a folder called metadata.
In the metadata folder you will put all the images that will be used by spaceranger.

You will also need to download the slidefiles which can be found [here](https://support.10xgenomics.com/spatial-gene-expression/software/pipelines/latest/using/slidefile-download)

# How to Run

To execute the workflow, use the following command:

```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv> 
```

Replace `</path/to/your/samplesheet.csv>` with the actual path to your SampleSheet.csv file.
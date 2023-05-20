# Input Requirements
The input should a csv file, for example named SampleSheet.csv looking like this:
|   [10X_Data]  |                   |                   |          |        |              |
|:-------------:|:-----------------:|:-----------------:|:--------:|:------:|:------------:|
|    Sample_ID  |   Sample_Species  |   Sample_Project  |   force  |   agg  |    pipeline  |
|    sample-1   |        human      |      project1     |     n    |    n   |   scrna-10x  |
|    sample-2   |        human      |      project1     |     n    |    n   |   scrna-10x  |
|    sample-3   |        human      |      project2     |     n    |    n   |   scrna-10x  |

It needs to start with the line `[10X_Data]`, then each of the listed columns are necessary.
Explanation of each column:
* Sample_ID - Unique identfier of each sample to be processed, need to match the fastq file according to 10X specifications.
* Sample_Species - Decides which reference genome is going to be used
* Sample_Project - Will dictate which folder the analysis will land in. Needs to match the project folder where the fastq files land in, [as described here](/docs/Setup.md)
* force - If you want to force the cells to have a specific cell number.
* agg - If you want to aggregate all the processed samples for visualization.
* pipeline - What pipeline the sample should be run with, in this case scrna-10x
# How to run
```
nextflow run main.nf --samplesheet </path/to/your/samplesheet.csv> --analysis scrna-10x
```
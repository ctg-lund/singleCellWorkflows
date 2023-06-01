# SETUP

## Requirements
Before proceeding with the installation, make sure you have the following requirements installed on your system:

### Native Dependencies
* nextflow (version > 22.10.6.5843)
* Singularity
* openjdk (version > 11.0.13)
* git (only needed to download the repository)

### Singularity Containers
We have our singularity recipes in the singularity folder of this project. See [Sylabs official](https://docs.sylabs.io/guides/3.0/user-guide/build_a_container.html) documentation on how to build singularity containers.

## Installation
To set up the project, follow these steps:

1. Clone the repository by running the following command:
   ```
   git clone https://github.com/ctg-lund/singleCellWorkflows
   ```

2. After cloning the repository, you need to configure the `nextflow.config` file. Open the file and locate the following settings that require configuration:

   * `refdir`: Specify the directory where all the references used by cellranger are stored, such as vdj libraries, gex libraries, probe sets, etc. You will need to specify each reference separately.
   * `container_dir`: Set the directory path where all your singularity containers, including cellranger, spaceranger, multiqc, fastqc, etc., are stored.
   * `process`: Each process needs to have its corresponding container linked. Also, review the CPU and memory specifications to ensure they are appropriate for your system.
   * `outdir`: Where your project folders with your data are.

Make the necessary changes to the `nextflow.conf` file according to your system setup and requirements.

Once you have completed these steps, you will have successfully set up the project.

## Outdir
The pipeline assumes the following structure when you process the data:
```
outdir (Set from nextflow.config)
 ┣ project1 (Sample_Project from samplesheet)
 ┃ ┣ fastq
 ┣ project2
 ┃ ┣ fastq
```
After processing it should look something like this:
```
output
 ┣ project1
 ┃ ┣ fastq
 ┃ ┣ 1_qc
 ┃ ┃ ┣ fastqc
 ┃ ┃ ┃ ┣ sample-1.fastqc.html
 ┃ ┃ ┃ ┣ sample-1.fastqc.zip
 ┃ ┃ ┃ ┣ sample-2.fastqc.html
 ┃ ┃ ┃ ┗ sample-2.fastqc.zip
 ┃ ┃ ┗ multiqc
 ┃ ┃ ┃ ┗ multiqc_report.html
 ┃ ┣ 2_count
 ┃ ┃ ┣ sample-1
 ┃ ┃ ┃ ┗ outs
 ┃ ┃ ┃ ┃ ┣ cloupe.cloupe
 ┃ ┃ ┃ ┃ ┣ metrics_summary.csv
 ┃ ┃ ┃ ┃ ┗ web_summary.html
 ┃ ┃ ┗ sample-2
 ┃ ┃ ┃ ┗ outs
 ┃ ┃ ┃ ┃ ┣ cloupe.cloupe
 ┃ ┃ ┃ ┃ ┣ metrics_summary.csv
 ┃ ┃ ┃ ┃ ┗ web_summary.html
 ┃ ┣ 3_summaries
 ┃ ┃ ┗ cellranger
 ┃ ┃ ┃ ┗ web_summaries.tar
 ┃ ┗ ctg-md5.project1.txt
 ┣ project2
 ┃ ┣ fastq
 ┃ ┣ 1_qc
 ┃ ┃ ┣ fastqc
 ┃ ┃ ┃ ┣ sample-3.fastqc.html
 ┃ ┃ ┃ ┗ sample-3.fastqc.zip
 ┃ ┃ ┗ multiqc
 ┃ ┃ ┃ ┗ multiqc_report.html
 ┃ ┣ 2_count
 ┃ ┃ ┗ sample-3
 ┃ ┃ ┃ ┗ outs
 ┃ ┃ ┃ ┃ ┣ cloupe.cloupe
 ┃ ┃ ┃ ┃ ┣ metrics_summary.csv
 ┃ ┃ ┃ ┃ ┗ web_summary.html
 ┃ ┣ 3_summaries
 ┃ ┃ ┗ cellranger
 ┃ ┃ ┃ ┗ web_summaries.tar
 ┃ ┗ ctg-md5.project2.txt
```

## 10X References
We use the prebuilt references from 10X genomics which can be found [here](https://support.10xgenomics.com/single-cell-vdj/software/downloads/latest). To make custom references, we use our [add2ref script](/bin/ctg-cellranger-add2ref.sh), which is hardcoded to work on our systems.
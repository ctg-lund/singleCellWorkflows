# SETUP

## Requirements
Before proceeding with the installation, make sure you have the following requirements installed on your system:

### Native Dependencies
* nextflow (version > 22.10.6.5843)
* openjdk (version > 11.0.13)
* git (only needed to download the repository)

### Singularity Containers
The following singularity containers should be available:

* cellranger (version > 7.1)
* FastQC
* Multiqc (dev variant as of 2023-05-20; other versions may cause crashes with cellranger output)

## Installation
To set up the project, follow these steps:

1. Clone the repository by running the following command:
   ```
   git clone https://github.com/ctg-lund/singleCellWorkflows
   ```

2. After cloning the repository, you need to configure the `nextflow.conf` file. Open the file and locate the following settings that require configuration:

   * `refdir`: Specify the directory where all the references used by cellranger are stored, such as vdj libraries, gex libraries, probe sets, etc. You will need to specify each reference separately.
   * `container_dir`: Set the directory path where all your singularity containers, including cellranger, spaceranger, multiqc, fastqc, etc., are stored.
   * `process`: Each process needs to have its corresponding container linked. Also, review the CPU and memory specifications to ensure they are appropriate for your system.

Make the necessary changes to the `nextflow.conf` file according to your system setup and requirements.

Once you have completed these steps, you will have successfully set up the project.
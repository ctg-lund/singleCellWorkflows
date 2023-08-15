# Introduction
This is where I will document how to run spaceranger. It will start very manually and hopefully in the end mature into an automated pipeline. I will make no promises, but I plan to continously revise this guide as the workflow progress.

# Spaceranger Count
**Required input files**
* Fastq-files
* Cytassist image
* Microscope image
* Slide area
* Slide .gpr file (This will need to be downloaded)


**Count sbatch script:**
```bash
#!/bin/bash -ue
#SBATCH -c 24
#SBATCH -t 12:00:00
#SBATCH --mem 124G
#SBATCH -J sample
#SBATCH -o /path/to/out/sample.out
#SBATCH -e /path/to/err/sample.err

singularity run --bind /projects/ \
	/path/to/spaceranger.simg \
		spaceranger count \
			--id="Visium_FFPE_Human" \
			--transcriptome=/path/to/refdata-gex-GRCh38-2020-A \
			--probe-set=/path/to/Visium_Human_Transcriptome_Probe_Set_v2.0_GRCh38-2020-A.csv \
			--fastqs=/path/to/sample/fastq \
			--sample=sample \
			--image=/path/to/CytAssist_HighRes_Sample-A-index-D1.tif \
			--slide=V42L13-392 \
			--slidefile=/path/to/V42L13-392.gpr \
			--area=A1 \
			--cytaimage=/path/to/CytAssist_LowRes_Sample-A-Index-D1.tif \
```

# Glossary
**Visium CytAssist Instrument**: An instrument that mediates the tissue permeabilization to release the ligation products from tissues on standard glass slide for capture by spatially barcoded oligonucleotides within each Capture Area on the Visium slide. It also captures the image of the tissue section on the Visium slide.

**CytAssist Captured Image (or CytAssist Image)**: A low resolution brightfield image in TIFF format that is captured by the CytAssist of the eosin stained tissue section on the CytAssist slide inside the instrument. This image contains the fiducial frame.

**Microscope Image**: A high resolution brightfield or fluorescence image of the tissue section on the standard glass slide captured by a microscope. This image does not contain the fiducial frame.

**CytAssist Spatial Gene Expression Slide, 6.5 mm**: Visium Spatial Gene Expression slide for use with CytAssist instrument with two capture areas each with dimensions of 6.5 mm by 6.5 mm. The spots within the capture area on these slides contain specialized oligos for capturing poly-adenylated mRNA tags. These slides have serial numbers starting with "V4".

**CytAssist Spatial Gene Expression Slide, 11 mm**: Visium Spatial Gene Expression slide for use with CytAssist instrument with two capture areas each with dimensions 11 mm by 11 mm. The number of spots within the capture area on these slides are ~3x higher compared to the 6.5 mm capture areas and contain specialized oligos for capturing poly-adenylated mRNA tags. These slides have serial numbers starting with "V5".


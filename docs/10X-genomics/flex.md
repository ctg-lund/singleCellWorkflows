# Basic run instructions:
The fixation uses cellranger multi. Example:
```
singularity run --bind /projects/ /path/to/cellranger.simg cellranger multi \
--id=sample_id \
--csv=/path/to/config.csv
```

# Config files:
For single plexed fixation samples:
config.csv
```
[gene-expression]
reference,/path/to/refdata-gex-GRCh38-2020-A
probe-set,/path/to/Chromium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A.csv

[libraries]
fastq_id,fastqs,feature_types
sample_01_fix,/path/to/fastq,Gene Expression
```
For multiplexed samples:
config.csv
```
[gene-expression]
reference,/path/to/refdata-gex-GRCh38-2020-A
probe-set,/path/to/Chromium_Human_Transcriptome_Probe_Set_v1.0_GRCh38-2020-A.csv

[libraries]
fastq_id,fastqs,feature_types
221117_Milladur,/path/to/fastq/sample_id/,Gene Expression

[samples]
sample_id,probe_barcode_ids
sample1,BC001
sample2,BC002
sample3,BC003
sample4,BC004
sample5,BC005
sample6,BC006
sample7,BC007
sample8,BC008
sample9,BC009
sample10,BC010
sample11,BC011
sample12,BC012
sample13,BC013
sample14,BC014
sample15,BC015

```
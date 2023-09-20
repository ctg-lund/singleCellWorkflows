# VDJ only
```
cellranger vdj --id=sample345 \
                 --reference=/opt/refdata-cellranger-vdj-GRCh38-alts-ensembl-7.1.0 \
                 --fastqs=/home/jdoe/runs/HAWT7ADXX/outs/fastq_path \
```


# VDJ + GEX
You will need to construct a config.csv file like
```
[gene-expression]
reference,/path/to/transcriptome

[vdj]
reference,/path/to/vdj_reference

[libraries]
fastq_id,fastqs,feature_types
GEX_fastqs_id,/path/to/GEX_fastqs,Gene Expression
VDJ_B_fastqs_id,/path/to/vdj_B_fastqs,VDJ-B
VDJ_T_fastqs_id,/path/to/vdj_T_fastqs,VDJ-T
```
Where VDJ-T/B is set manually as opposed to cellranger vdj where it autodetects Antigens.
Then run with:
```
cellranger multi --id=<sample-id> --csv=/path/to/config.csv
```
# Reference names
I haven't changed the names provided by 10X standard refernces. These are the names.
* Human: refdata-cellranger-vdj-GRCh38-alts-ensembl-7.1.0
* Mouse: refdata-cellranger-vdj-GRCm38-alts-ensembl-7.0.0
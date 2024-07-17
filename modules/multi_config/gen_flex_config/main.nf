process GEN_FLEX_CONFIG {

    input:
    path split_multiplex
    tuple val(Sample_ID), val(Sample_Species), val(Sample_Project)
    output:
    path "config.csv"
    tuple val(Sample_ID), val(Sample_Project)

    script:

    if (Sample_Species == "human"){
        transcriptome=params.human
        probeset=params.human_probes
    } else if (Sample_Species == 'mouse'){
        transcriptome=params.mouse
        probeset=params.mouse_probes
    } else if (Sample_Species == 'custom'){
        transcriptome=params.custom_genome
        probeset=params.custom_probes
    }

    """
    if [ -s $split_multiplex ]; then
        sample_header='[samples]'
    else
        sample_header=''
    fi
    echo \"\"\"[gene-expression]
    reference,$transcriptome
    probe-set,$probeset
    create-bam,false
    [libraries]
    fastq_id,fastqs,feature_types
    $Sample_ID,$params.outdir/$Sample_Project/fastq,Gene Expression
    \$sample_header
    \$(awk -F \',\' 'BEGIN {OFS=\",\"} {print \$1,\$2}' $split_multiplex)
    \"\"\" > config.csv
    """
}
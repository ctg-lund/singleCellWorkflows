process GEN_FLEX_CONFIG {

    input:
    path split_multiplex_sheet
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

    if (split_multiplex_sheet.toString().length() == 0) {
        samples = "[samples]\n"
        samples += split_sheet.readLines()
    } else {
        samples = ""
    }

    """
    echo \"\"\"[gene-expression]
    reference,$transcriptome
    probeset,$probeset
    [libraries]
    fastq_id,fastqs,feature_types
    $Sample_ID,$params.outdir/$Sample_Project/fastq,Gene Expression
    $samples
    \"\"\" > config.csv
    """
}
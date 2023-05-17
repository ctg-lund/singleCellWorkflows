process SPLIT_MULTIPLEX_SHEET {
    input:
    path multiplex_sheet
    tuple val(Sample_ID), val(Sample_Species), val(Sample_Project)

    output:
    path 'split_multiplex.csv'

    script:
    """
    head -n 1 ${multiplex_sheet} > split_multiplex.csv
    grep ${Sample_Project} ${multiplex_sheet} >> split_multiplex.csv
    """
}
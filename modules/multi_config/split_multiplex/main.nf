process SPLIT_MULTIPLEX_SHEET {
    input:
    path multiplex_sheet
    tuple val(Sample_ID), val(Sample_Species), val(Sample_Project)

    output:
    path 'split_multiplex.csv'

    script:
    """
    if ! grep -q ${Sample_ID} ${multiplex_sheet}; then
        touch split_multiplex.csv
        exit 0
    fi
    head -n 1 ${multiplex_sheet} > split_multiplex.csv
    grep ${Sample_ID} ${multiplex_sheet} >> split_multiplex.csv
    """
}
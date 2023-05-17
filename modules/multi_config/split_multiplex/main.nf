process SPLIT_MULTIPLEX_SHEET {
    input:
    path multiplex_sheet
    val project_id
    output:
    path 'split_multiplex.csv'

    script:
    """
    head -n 1 ${multiplex_sheet} > split_multiplex.csv
    grep ${project_id} ${multiplex_sheet} >> split_multiplex.csv
    """
}
process CELLRANGER_MULTI_TO_MULTIQC{
    publishDir "$params.outdir/3_summaries/cellranger/", mode: 'copy', pattern : "*_mqc.yaml"
    input:
    val project_id
    output:
    val project_id, emit: "project_id"
    tuple path("*_mqc.yaml"), emit: "multiqc_config"
    script:
    """
    # Create the multiqc folder
    mkdir -p $params.outdir/$project_id/1_qc/multiqc
    
    # Create the multiqc config files
    for file_name in cells library other
    do 
    echo \"\"\"
    id: \"single_cell_workflows_table\"
    section_name : \"Single Cell Workflows \$file_name Stats\"
    description: \"This table consists of the data gathered from cellranger output \"
    plot_type: \"table\"
    pconfig: 
    id: \"single_cell_workflows_table \$file_name \"
    title: \"Single Cell Workflows \$file_name Stats\"
    data:
    \"\"\" > \${file_name}_mqc.yaml
    done

    # Convert the cellranger multi csv output to json
    for file in $params.outdir/$project_id/2_multi/*/outs/per_sample_outs/*
    do
        python multimetric2mqc.py $file/metrics_summary.csv \$(basename \$file)
    done
    
    # Populate the multiqc config files
    for file_name in cells library other
    do
        for json in *\${file_name}.json
        do
            json_name = \"\${\$(basename \$json)%_\${file_name}.json}\"
            echo \"\${json_name}: \$(cat \${json})\" >> \${file_name}_mqc.yaml
        done
    done

    """

    stub: 
    """
    echo hippity hoppity
    """
}
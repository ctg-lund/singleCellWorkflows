process CELLRANGER_COUNT_TO_MULTIQC{
    input:
    val sample_id
    val project_id
    val pipeline
    output:
    val(project_id), emit: project_id
    script:

    number_of_samples = sample_id.size() -1

    if (pipeline == 'arc'){
        summary="summary.csv"
    } else {
        summary="metrics_summary.csv"
    }
    """
    # Convert groovy variables into bash arrays
    sample_string=\$(echo $sample_id | tr -d '[]')
    project_string=\$(echo $project_id | tr -d '[]')
    IFS=', ' read -ra sample_array <<< \"\$sample_string\"
    IFS=', ' read -ra project_array <<< \"\$project_string\"
    # Checks if mqc_yaml exists, if not create it
    for i in {0..$number_of_samples}; do
    echo \$i
    if ! [ -f \"$params.outdir/\${project_array[\$i]}/1_qc/multiqc/multiqc_mqc.yaml\" ]; then
      mkdir -p \"$params.outdir/\${project_array[\$i]}/1_qc/multiqc/\"
      echo \"\"\"id: \"single_cell_workflows_table\"
section_name : \"Single Cell Workflows Count Stats\"
description: \"This table consists of the data gathered from cellranger output \"
plot_type: \"table\"
pconfig:
  id: \"single_cell_workflows_table\"
  title: \"Single Cell Workflows Stats\"
data:\"\"\" > \"$params.outdir/\${project_array[\$i]}/1_qc/multiqc/multiqc_mqc.yaml\"
    fi
    # Extends mqc_yaml file with sample information
    python $projectDir/bin/countmetric2mqc.py $params.outdir/\${project_array[\$i]}/2_count/\${sample_array[\$i]}/outs/$summary \${sample_array[\$i]} $params.outdir/\${project_array[\$i]}/1_qc/multiqc/multiqc_mqc.yaml
done
    """
}
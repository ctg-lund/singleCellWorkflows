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

    for i in {0..5}; do
    if ! [ -f \"$params.outdir/\${project_array[\$i]}/1_qc/multiqc/multiqc_mqc.yaml\" ]; then
      mkdir -p \"$params.outdir/\${project_array[\$i]}/1_qc/multiqc/\"
      echo \"\"\"id: \"single_cell_workflows_table\"
section_name : \"Single Cell Workflows Stats\"
description: \"This table consists of the data gathered from cellranger output \"
plot_type: \"table\"
pconfig:
  id: \"single_cell_workflows_table\"
  title: \"Single Cell Workflows Stats\"
data:\"\"\" > \"$params.outdir/\${project_array[\$i]}/1_qc/multiqc/multiqc_mqc.yaml\"
    fi
    echo \"  \${sample_array[\$i]}: \$(cat $params.outdir/\${project_array[\$i]}/2_count/\${sample_array[\$i]}/outs/metrics_summary.csv | python -c 'import csv, json, sys; print(json.dumps([dict(r) for r in csv.DictReader(sys.stdin)]))')\" | tr -d '[]' >> \"$params.outdir/\${project_array[\$i]}/1_qc/multiqc/multiqc_mqc.yaml\"
done
    """

    stub: 
    """
    echo hippity hoppity
    """
}
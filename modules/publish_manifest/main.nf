process PUBLISH_MANIFEST {
    tag "$project_id"
    input:
    val project_id
    val subworkflow
    output:
    val project_id
    script:
    """
    mkdir -p $params.outdir/$project_id/3_summaries/pipeline
    sed \"s/xxSubWorkflowxx/$subworkflow/g\" $projectDir/templates/manifest.html  > $params.outdir/$project_id/3_summaries/pipeline/manifest.html
    """
}
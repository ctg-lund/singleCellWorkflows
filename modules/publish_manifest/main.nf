process PUBLISH_MANIFEST {
    input:
    val project_id
    output:
    val project_id
    script:
    """
    mkdir -p $params.outdir/$project_id/3_summaries/pipeline
    cp $projectDir/templates/manifest.html $params.outdir/$project_id/3_summaries/pipeline/manifest.html
    """
}
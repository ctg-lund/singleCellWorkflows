process PUBLISH_RELEASE {
    input:
    val project_id
    output:
    val project_id
    script:
    """
    cp $projectDir/templates/manifest.html $params.outdir/$project_id/3_summaries/pipeline/manifest.html
    """
}
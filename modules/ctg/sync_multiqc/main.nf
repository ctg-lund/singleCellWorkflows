process SYNC_MULTIQC {
    input:
        path multiqc_report
        val project_id

    script:
    """
    mkdir -p $params.ctgqc/projects/$project_id
    cp  $multiqc_report $params.ctgqc/projects/$project_id/multiqc_report.html
    """
    stub:
    """
    echo This is a stub for SYNC_MULTIQC
    """
}
process SYNC_MULTIQC {
    input:
        path multiqc_report
        val project_id

    script:
    """
    cp -v $multiqc_report $params.ctgqc/$project_id/multiqc_report.html
    """

}
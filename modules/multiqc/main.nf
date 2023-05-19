process MULTIQC {
    publishDir "$params.outdir/$project_id/1_qc/multiqc", mode: 'copy', pattern : "*.html"

    input:
        val(count_done)
    	val(project_id)

    output:
        path "*.html", emit: html_report
        val project_id, emit: project_id

    script:
    """
    multiqc -f $params.outdir/$project_id  --outdir .  -c $params.multiqc_conf -n multiqc_report.html
    """
    stub:
    """
    touch multiqc_report.html
    """
}
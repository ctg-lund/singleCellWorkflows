// Deliverables
include { SYNC_MULTIQC } from "../modules/ctg/sync_multiqc/main"
include { PUBLISH_MANIFEST } from '../modules/publish_manifest/main'
include { MULTIQC } from "../modules/multiqc/main"
include { MD5SUM } from "../modules/md5sum/main"

workflow FINISH_PROJECTS {
    take:
        project_id
        workflow
    main:
        multiqc_ch = MULTIQC(project_id)

        if ( params.ctg_mode == 'true'){
            SYNC_MULTIQC(multiqc_ch.html_report, multiqc_ch.project_id)
        }
        
        publish_ch = PUBLISH_MANIFEST(multiqc_ch.project_id, workflow)
        if ( params.ctg_mode == 'true'){
            md5sum_ch = MD5SUM(publish_ch)
        }
}

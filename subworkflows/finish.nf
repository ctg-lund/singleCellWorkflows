// Deliverables
include { DELIVER_PROJ } from "../modules/deliver/main"
include { SYNC_MULTIQC } from "../modules/ctg/sync_multiqc/main"
include { PUBLISH_MANIFEST } from '../modules/publish_manifest/main'
include { MULTIQC } from "../modules/multiqc/main"
include { MD5SUM } from "../modules/md5sum/main"
include { PACK_WEBSUMMARIES } from "../modules/pack_websummaries/main"

workflow FINISH_PROJECTS {
    take:
        project_id
        workflow
    main:
        multiqc_ch = MULTIQC(project_id)

        SYNC_MULTIQC(multiqc_ch.html_report, multiqc_ch.project_id)

        webpack_ch = PACK_WEBSUMMARIES(multiqc_ch.project_id)
        
        publish_ch = PUBLISH_MANIFEST(webpack_ch.project_id, workflow)

        md5sum_ch = MD5SUM(publish_ch)

        deliver_auto_ch = DELIVER_PROJ(md5sum_ch.project_id)
}
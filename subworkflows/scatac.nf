// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
include { COUNT_ATAC } from "../modules/cellranger/count-atac/main"
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
include { SUMMARIZE_COUNT } from "../modules/summarize_count/main"
include { MD5SUM } from "../modules/md5sum/main"
include { DELIVER_PROJ } from "../modules/deliver/main"
include { SPLITSHEET } from "../modules/split_sheet/main"
include { PACK_WEBSUMMARIES } from "../modules/pack_websummaries/main"
include { SYNC_MULTIQC } from "../modules/ctg/sync_multiqc/main"
include { PUBLISH_MANIFEST } from '../modules/publish_manifest/main'

workflow SC_ATAC {
	// Parse samplesheet
	sheet_ch = SPLITSHEET(samplesheet, 'scatac-10x')

	// all samplesheet info
	sample_info_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row -> tuple( row.Sample_ID, row.Sample_Species, row.force, row.agg, row.Sample_Project) }

	sample_fastqc_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row -> tuple( row.Sample_ID, row.Sample_Project) }

	FASTQC(sample_fastqc_ch)
	
	count_ch = COUNT_ATAC(sample_info_ch)

	multiqc_ch = MULTIQC(count_ch.done.collect(), count_ch.project_id.unique())

	SYNC_MULTIQC(multiqc_ch.html_report, multiqc_ch.project_id)

	webpack_ch = PACK_WEBSUMMARIES(multiqc_ch.project_id)
	
	publish_ch = PUBLISH_MANIFEST(webpack_ch.project_id)

	md5sum_ch = MD5SUM(publish_ch)

	deliver_auto_ch = DELIVER_PROJ(md5sum_ch.project_id)
}
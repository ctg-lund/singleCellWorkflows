// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
// QC Modules
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
include { MD5SUM } from "../modules/md5sum/main"
include { PACK_WEBSUMMARIES } from "../modules/pack_websummaries/main"
// Sample sheet modules
include { SPLITSHEET } from "../modules/split_sheet/main"
include { SPLIT_MULTIPLEX_SHEET } from "../modules/multi_config/split_multiplex/main"
include { GEN_FLEX_CONFIG } from "../modules/multi_config/gen_flex_config/main"
include { MULTI } from "../modules/cellranger/multi/main"
// Deliverables
include { DELIVER_PROJ } from "../modules/deliver/main"
include { SYNC_MULTIQC } from "../modules/ctg/sync_multiqc/main"
include { PUBLISH_MANIFEST } from '../modules/publish_manifest/main'

workflow FLEX_SCRNASEQ{

	sheet_ch = SPLITSHEET(samplesheet, 'scflex-10x')

	sample_info_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row -> tuple( row.Sample_ID, row.Sample_Species, row.Sample_Project) }

	sample_fastqc_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row -> tuple( row.Sample_ID , row.Sample_Project) }
	
	FASTQC(sample_fastqc_ch)

	split_multi_ch = SPLIT_MULTIPLEX_SHEET(sheet_ch.flex, sample_info_ch)

	config_ch = GEN_FLEX_CONFIG(split_multi_ch, sample_info_ch)

	multi_ch = MULTI(config_ch)

	multiqc_ch = MULTIQC(multi_ch.done.collect(), multi_ch.project_id.unique())
	
	SYNC_MULTIQC(multiqc_ch.html_report, multi_ch.project_id)

	webpack_ch = PACK_WEBSUMMARIES(multiqc_ch.project_id)

	publish_ch = PUBLISH_MANIFEST(webpack_ch.project_id, 'scflex-10x')

	md5sum_ch = MD5SUM(publish_ch)

	// Deliverables
	deliver_ch = DELIVER_PROJ(md5sum_ch.project_id)
}
// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
include { MD5SUM } from "../modules/md5sum/main"
include { DELIVER_PROJ } from "../modules/deliver/main"
include { SPLITSHEET } from "../modules/split_sheet/main"
include { SPLIT_MULTIPLEX_SHEET } from "../modules/multi_config/split_multiplex/main"
include { GEN_FLEX_CONFIG } from "../modules/multi_config/gen_flex_config/main"
include { MULTI } from "../modules/cellranger/multi/main"
include { SYNC_MULTIQC } from "../modules/ctg/sync_multiqc/main"

workflow FLEX_SCRNASEQ{

	sheet_ch = SPLITSHEET(samplesheet, params.analysis)

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

	multiqc_ch = MULTIQC(multi_ch.done, multi_ch.project_id)
	
	SYNC_MULTIQC(multiqc_ch.html_report, multi_ch.project_id)

	md5sum_ch = MD5SUM(multiqc_ch.project_id)

	// Deliverables
	deliver_ch = DELIVER_PROJ(md5sum_ch.project_id)
}
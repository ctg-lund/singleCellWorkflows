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
include { GENERATE_MULTI_CONFIG } from "../modules/multi_config/gen_multi_config/main"
include { MULTI } from "../modules/cellranger/multi/main"
// Deliverables
include { DELIVER_PROJ } from "../modules/deliver/main"
include { SYNC_MULTIQC } from "../modules/ctg/sync_multiqc/main"

workflow FLEX_SCRNASEQ{

	sheet_ch = SPLITSHEET(samplesheet, params.analysis)

	sample_info_ch = sheet_ch.data
        .splitCsv(header:true)
        .map { row -> tuple( row.Sample_ID, row.Sample_Species, row.Sample_Project, row.sample_pair, row.libtype) }
        .groupTuple(by:3)

	sample_fastqc_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row -> tuple( row.Sample_ID , row.Sample_Project) }
	
	FASTQC(sample_fastqc_ch)

	split_multi_ch = SPLIT_MULTIPLEX_SHEET(sheet_ch.flex, sample_info_ch)

	config_ch = GEN_FLEX_CONFIG(split_multi_ch, sample_info_ch)

	multi_ch = MULTI(config_ch)
}
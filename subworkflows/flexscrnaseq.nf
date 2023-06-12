// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// QC Modules
include { FASTQC } from "../modules/fastqc/main"
include { CELLRANGER_MULTI_TO_MULTIQC } from "../modules/cellranger2multiqc/multi/main"
// Sample sheet modules
include { SPLITSHEET } from "../modules/split_sheet/main"
include { SPLIT_MULTIPLEX_SHEET } from "../modules/multi_config/split_multiplex/main"
include { GEN_FLEX_CONFIG } from "../modules/multi_config/gen_flex_config/main"
include { MULTI } from "../modules/cellranger/multi/main"
// FINISH MODULE
include { FINISH_PROJECTS } from "./finish.nf"

workflow FLEX_SCRNASEQ{
	main:
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

		mqc_conf_ch = CELLRANGER_MULTI_TO_MULTIQC(multi_ch.project_id.unique())

		FINISH_PROJECTS (
			mqc_conf_ch.project_id.collect().flatten().unique(),
			'scflex-10x'
		)
}
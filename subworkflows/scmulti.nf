// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
// QC Modules
include { FASTQC } from "../modules/fastqc/main"
// Sample sheet modules
include { SPLITSHEET } from "../modules/split_sheet/main"
include { GENERATE_MULTI_CONFIG } from "../modules/multi_config/gen_multi_config/main"
// Sample processing modules
include { MULTI } from "../modules/cellranger/multi/main"
// FINISH MODULE
include { FINISH_PROJECTS } from "./finish.nf"
workflow SCMULTI{

	sheet_ch = SPLITSHEET(samplesheet, 'scmulti-10x')

	sample_info_ch = sheet_ch.data
        .splitCsv(header:true)
        .map { row -> tuple( row.Sample_ID, row.Sample_Species, row.Sample_Project, row.sample_pair, row.libtype) }
        .groupTuple(by:3)

	sample_fastqc_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row -> tuple( row.Sample_ID , row.Sample_Project) }
	
	FASTQC(sample_fastqc_ch)

	config_ch = GENERATE_MULTI_CONFIG(sample_info_ch)

	multi_ch = MULTI(config_ch)

	FINISH_PROJECTS (
			multi_ch.project_id.unique(),
			'scmulti-10x'
		)
}
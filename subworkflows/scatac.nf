// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
// QC Modules
include { FASTQC } from "../modules/fastqc/main"
// Cellranger Modules
include { COUNT_ATAC } from "../modules/cellranger/count-atac/main"
// Parsing Modules
include { SPLITSHEET } from "../modules/split_sheet/main"
// FINISH MODULE
include { FINISH_PROJECTS } from "./finish.nf"

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

	FINISH_PROJECTS(
			count_ch.project_id.unique(),
			'scatac-10x'
		)
}

// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)
// Input parsing
include { SPLITSHEET } from "../modules/split_sheet/main"
// Analysis Modules
include { COUNT } from "../modules/cellranger/count-rna/main"
// QC Modules
include { FASTQC } from "../modules/fastqc/main"
// Delivery modules
include { FINISH_PROJECTS } from "../subworkflows/finish.nf"

workflow SCRNASEQ {
	main:
		// Parse samplesheet
		sheet_ch = SPLITSHEET(samplesheet, 'scrna-10x')

		// all samplesheet info
		sample_info_ch = sheet_ch.data
			.splitCsv(header:true)
			.map { row -> tuple( row.Sample_ID, row.Sample_Species, row.force, row.agg, row.Sample_Project) }

		sample_fastqc_ch = sheet_ch.data
			.splitCsv(header:true)
			.map { row -> tuple( row.Sample_ID, row.Sample_Project) }
		project_id_ch = sheet_ch.data
			.splitCsv(header:true)
			.map { row ->  row.Sample_Project  }

		FASTQC(sample_fastqc_ch)
		
		count_ch = COUNT(sample_info_ch)

		FINISH_PROJECTS(
			count_ch.project_id.unique(),
			'scrna-10x'
		)

}
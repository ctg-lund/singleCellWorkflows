
// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)
// Input parsing
include { SPLITSHEET } from "../modules/split_sheet/main"
// Analysis Modules
include { COUNT } from "../modules/cellranger/count-rna/main"
include { EMPTY_DROPS } from "../modules/empty_drops/main"
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

		FASTQC(sample_fastqc_ch)
		
		count_ch = COUNT(sample_info_ch)

		empty_drop_ch = EMPTY_DROPS(
			count_ch.sample_id,
			count_ch.project_id
		)

		FINISH_PROJECTS(
			empty_drop_ch.project_id.collect().flatten().unique(),
			'scrna-10x'
		)

}
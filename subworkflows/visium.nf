outdir = params.outdir

// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
include { SPLITSHEET } from "../modules/split_sheet/main"
include { FASTQC } from "../modules/fastqc/main"
include { SPACECOUNT } from "../modules/spaceranger/main"
include { FINISH_PROJECTS } from "../subworkflows/finish.nf"

workflow VISIUM {
    // Parse samplesheet
	sheet_ch = SPLITSHEET(samplesheet, 'scvisium-10x')

	// all samplesheet info
	sample_info_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row -> tuple( row.Sample_ID, row.Sample_Project, row.Sample_Species, row.cytaimage, row.darkimage, row.image, row.slide, row.slide_area) }
	
	sample_fastqc_ch = sheet_ch.data
			.splitCsv(header:true)
			.map { row -> tuple( row.Sample_ID, row.Sample_Project) }
		
	FASTQC(sample_fastqc_ch)

    count_ch = SPACECOUNT(sample_info_ch)

	FINISH_PROJECTS(
			count_ch.project_id.collect().flatten().unique(),
			'scvisium-10x'
		)
}
outdir = params.outdir

// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
// Samplesheet modules
include { SPLITSHEET } from "../modules/split_sheet/main"
// QC Modules
include { FASTQC } from "../modules/fastqc/main"
include { CELLRANGER_COUNT_TO_MULTIQC } from "../modules/cellranger2multiqc/count/main"
// Processing Modules
include { SPACECOUNT } from "../modules/spaceranger/main"
// Finishing Modules
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

	mqc_conf_ch = CELLRANGER_COUNT_TO_MULTIQC(
        count_ch.sample_id.collect(), 
        count_ch.project_id.collect(),
        'visium'
        )

	FINISH_PROJECTS(
			mqc_conf_ch.project_id.flatten().unique(),
			'scvisium-10x'
		)
}
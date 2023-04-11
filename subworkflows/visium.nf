outdir = params.outdir

// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
include { SPACECOUNT } from "../modules/spaceranger/main"
include { DELIVERY_INFO } from "../modules/delivery_info/main"
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
include { SUMMARIZE_COUNT } from "../modules/summarize_count/main"
include { MD5SUM } from "../modules/md5sum/main"
include { PIPE_DONE } from "../modules/pipeline_done/main"
include { DELIVER_PROJ } from "../modules/deliver/main"
include { CREATE_MULTI_CONFIG } from "../modules/create_multi_config/main"
include { SPLITSHEET } from "../modules/split_sheet/main"

workflow VISIUM {
    // Parse samplesheet
	sheet_ch = SPLITSHEET(samplesheet, params.analysis)

	// all samplesheet info
	sample_info_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row -> tuple( row.Sample_ID, row.Sample_Project, row.index, row.species, row.cytaimage, row.darkimage, row.image, row.slide, row.area) }

	project_id_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row ->  row.Sample_Project  }

    count_ch = SPACECOUNT(sample_info_ch, params.refdir)
}
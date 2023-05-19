// Output dirs
outdir = params.outdir
ctgqc = params.ctgqc

// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
include { COUNT } from "../modules/cellranger/count-rna/main"
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
include { SUMMARIZE_COUNT } from "../modules/summarize_count/main"
include { MD5SUM } from "../modules/md5sum/main"
include { DELIVER_PROJ } from "../modules/deliver/main"
include { CREATE_MULTI_CONFIG } from "../modules/create_multi_config/main"
include { SPLITSHEET } from "../modules/split_sheet/main"
include { PACK_WEBSUMMARIES } from "../modules/pack_websummaries/main"
include { SYNC_MULTIQC } from "../modules/ctg/sync_multiqc/main"

workflow SCRNASEQ {
	// Parse samplesheet
	sheet_ch = SPLITSHEET(samplesheet, params.analysis)

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

	no_file_ch = file(params.feature_reference)
	
	count_ch = COUNT(sample_info_ch, no_file_ch)

	multiqc_ch = MULTIQC(count_ch.done.collect(), project_id_ch.unique())

	SYNC_MULTIQC(multiqc_ch.html_report, project_id_ch.unique())

	pack_websummaries_ch = PACK_WEBSUMMARIES(multiqc_ch.html_report, multiqc_ch.project_id)
	
	md5sum_ch = MD5SUM(pack_websummaries_ch.tarball, pack_websummaries_ch.project_id)

	deliver_auto_ch = DELIVER_PROJ(md5sum_ch.project_id)
}
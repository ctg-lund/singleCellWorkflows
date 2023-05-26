// Output dirs
outdir = params.outdir
ctgqc = params.ctgqc

// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)
// Import modules
// Input parsing
include { SPLITSHEET } from "../modules/split_sheet/main"
// Analysis Modules
include { COUNT } from "../modules/cellranger/count-rna/main"
// QC Modules
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
// Deliverables
include { PACK_WEBSUMMARIES } from "../modules/pack_websummaries/main"
include { SYNC_MULTIQC } from "../modules/ctg/sync_multiqc/main"
include { PUBLISH_MANIFEST } from '../modules/publish_manifest/main'
include { MD5SUM } from "../modules/md5sum/main"
include { DELIVER_PROJ } from "../modules/deliver/main"



workflow SCRNASEQ {
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

	multiqc_ch = MULTIQC(count_ch.done.collect(), project_id_ch.unique())

	SYNC_MULTIQC(multiqc_ch.html_report, project_id_ch.unique())

	webpack_ch = PACK_WEBSUMMARIES(multiqc_ch.project_id)
	
	publish_ch = PUBLISH_MANIFEST(webpack_ch.project_id)

	md5sum_ch = MD5SUM(publish_ch)

	deliver_auto_ch = DELIVER_PROJ(md5sum_ch.project_id)
}
// Output dirs
outdir = params.outdir
fqdir = params.fqdir
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

workflow SCRNASEQ {
	// Parse samplesheet
	sheet_ch = SPLITSHEET(samplesheet, params.analysis)

	// all samplesheet info
	sample_info_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row -> tuple( row.Sample_ID, row.Sample_Species, row.force, row.agg, row.Sample_Project) }

	project_id_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row ->  row.Sample_Project  }

	// Create a NO_FILE channel for count module

	FASTQC(sample_info_ch, outdir)

	no_file_ch = file(params.feature_reference)
	
	count_ch = COUNT(sample_info_ch,  outdir, no_file_ch)

	multiqc_ch = MULTIQC(count_ch.done.collect(), outdir, project_id_ch.unique())
	
	md5sum_ch = MD5SUM(multiqc_ch[0], outdir, multiqc_ch.project_id)

	deliver_auto_ch = DELIVER_PROJ(outdir, project_id_ch.unique(), md5sum_ch)
}
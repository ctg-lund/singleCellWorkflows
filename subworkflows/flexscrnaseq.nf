// Output dirs
outdir = params.outdir
fqdir = params.fqdir
ctgqc = params.ctgqc

// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
include { MD5SUM } from "../modules/md5sum/main"
include { DELIVER_PROJ } from "../modules/deliver/main"
include { SPLITSHEET } from "../modules/split_sheet/main"
include { SPLIT_MULTIPLEX_SHEET } from "../modules/multi_config/split_multiplex/main"

workflow FLEX_SCRNASEQ{

	sheet_ch = SPLITSHEET(samplesheet, params.analysis)

	sample_info_ch = sheet_ch.data
		.splitCsv(header:true)
		.map { row -> tuple( row.Sample_ID, row.Sample_Species, row.Sample_Project) }
	
	SPLIT_MULTIPLEX_SHEET(sheet_ch.flex, "project4")

	
}
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
include { CREATE_MULTI_CONFIG } from "../modules/create_multi_config/main"


workflow FLEX_SCRNASEQ{
	println "Not started yet"
	
}
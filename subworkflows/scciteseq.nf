// Output dirs
outdir = params.outdir
fqdir = params.fqdir
ctgqc = params.ctgqc

// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

params.analysis = 'scciteseq-10x'

// Import modules
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
include { MD5SUM } from "../modules/md5sum/main"
include { DELIVER_PROJ } from "../modules/deliver/main"
include { SPLITSHEET } from "../modules/split_sheet/main"
include { FILTER_ADTS } from "../modules/filter_adts/main"
include { GENERATE_CITE_LIB } from "../modules/multi_config/generate_lib/main"

workflow SCCITESEQ {
    sheet_ch = SPLITSHEET(samplesheet, params.analysis)

    // all samplesheet info
    sample_info_ch = sheet_ch.data
        .splitCsv(header:true)
        .map { row -> tuple( row.Sample_ID, row.Sample_Species, row.force, row.agg, row.Sample_Project, row.sample_pair, row.hto, row.libtype) }
        .view()
    
    lib_ch =  GENERATE_CITE_LIB(sample_info_ch, outdir)
}
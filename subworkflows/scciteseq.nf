// Output dirs
outdir = params.outdir
fqdir = params.fqdir
ctgqc = params.ctgqc

// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

params.analysis = 'scciteseq-10x'

// Import modules
include { COUNT } from "../modules/count/main"
include { DELIVERY_INFO } from "../modules/delivery_info/main"
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
include { SUMMARIZE_COUNT } from "../modules/summarize_count/main"
include { MD5SUM } from "../modules/md5sum/main"
include { PIPE_DONE } from "../modules/pipeline_done/main"
include { DELIVER_PROJ } from "../modules/deliver/main"
include { CREATE_MULTI_CONFIG } from "../modules/create_multi_config/main"
include { SPLITSHEET } from "../modules/split_sheet/main"
include { FILTER_ADTS } from "../modules/filter_adts/main"
include { GENERATE_CITE_LIB } from "../modules/generate_cite_lib/main"

workflow SCCITESEQ {
    sheet_ch = SPLITSHEET(samplesheet, params.analysis)

    // all samplesheet info
    sample_info_ch = sheet_ch.data
        .splitCsv(header:true)
        .map { row -> tuple( row.Sample_ID, row.Sample_Species, row.force, row.agg, row.Sample_Project, row.sample_pair, row.hto, row.libtype) }
        .view()
    
    lib_ch =  GENERATE_CITE_LIB(sample_info_ch, outdir)
}
// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
include { MD5SUM } from "../modules/md5sum/main"
include { DELIVER_PROJ } from "../modules/deliver/main"
include { SPLITSHEET } from "../modules/split_sheet/main"
include { FILTER_ADTS } from "../modules/filter_adts/main"
include { GENERATE_LIB_CSV } from "../modules/multi_config/generate_lib/main"
include { COMBINE_LIB_CSV } from "../modules/multi_config/combine_lib/main"

workflow SCCITESEQ {
    sheet_ch = SPLITSHEET(samplesheet, params.analysis)

    // all samplesheet info
    sample_info_ch = sheet_ch.data
        .splitCsv(header:true)
        .map { row -> tuple( row.Sample_ID, row.Sample_Species, row.Sample_Project, row.sample_pair, row.libtype) }
        .groupTuple(by:3)

    lib_ch =  GENERATE_LIB_CSV(sample_info_ch)

    // combine_lib_ch = COMBINE_LIB_CSV(lib_ch.collect())
}
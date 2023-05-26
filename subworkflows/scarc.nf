// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
// QC Modules
include { FASTQC } from "../modules/fastqc/main"
include { MULTIQC } from "../modules/multiqc/main"
include { MD5SUM } from "../modules/md5sum/main"
include { PACK_WEBSUMMARIES } from "../modules/pack_websummaries/main"
// Input Parsing
include { SPLITSHEET } from "../modules/split_sheet/main"
include { FILTER_FEATURE_REFERENCE } from "../modules/filter_featureref/main"
include { GENERATE_LIB_CSV } from "../modules/multi_config/generate_lib/main"
// Sample Processing
include { COUNT_ARC } from "../modules/cellranger/count-arc/main"
// Deliverables
include { DELIVER_PROJ } from "../modules/deliver/main"
include { SYNC_MULTIQC } from "../modules/ctg/sync_multiqc/main"
workflow SC_ARC {
    sheet_ch = SPLITSHEET(samplesheet, 'scarc-10x')

    // all samplesheet info
    sample_info_ch = sheet_ch.data
        .splitCsv(header:true)
        .map { row -> tuple( row.Sample_ID, row.Sample_Species, row.Sample_Project, row.sample_pair, row.libtype) }
        .groupTuple(by:3)

    sample_fastqc_ch = sheet_ch.data
        .splitCsv(header:true)
        .map { row -> tuple( row.Sample_ID, row.Sample_Project) }

    FASTQC(sample_fastqc_ch)

    lib_ch =  GENERATE_LIB_CSV(sample_info_ch)

    count_ch = COUNT_ARC(lib_ch.library, lib_ch.sample_name, lib_ch.sample_project, lib_ch.sample_species )

    multiqc_ch = MULTIQC(count_ch.done.collect(), count_ch.sample_project.unique())

    SYNC_MULTIQC(multiqc_ch.html_report, multiqc_ch.project_id)
    
    webpack_ch = PACK_WEBSUMMARIES(multiqc_ch.project_id)

    md5sum_ch = MD5SUM(webpack_ch.project_id)

    DELIVER_PROJ(md5sum_ch.project_id)
}
// Read and process CTG samplesheet (must be plain .csv - not directly from excel)
samplesheet = file(params.samplesheet)

// Import modules
// QC Modules
include { FASTQC } from "../modules/fastqc/main"
include { CELLRANGER_COUNT_TO_MULTIQC } from "../modules/cellranger2multiqc/count/main"
// Input Parsing
include { SPLITSHEET } from "../modules/split_sheet/main"
include { FILTER_FEATURE_REFERENCE } from "../modules/filter_featureref/main"
include { GENERATE_LIB_CSV } from "../modules/multi_config/generate_lib/main"
// Sample Processing
include { COUNT_ARC } from "../modules/cellranger/count-arc/main"
// FINISH MODULE
include { FINISH_PROJECTS } from "./finish.nf"

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

    mqc_conf_ch = CELLRANGER_COUNT_TO_MULTIQC(
        count_ch.sample_id.collect(), 
        count_ch.project_id.collect(),
        'arc'
        )

    FINISH_PROJECTS(
			mqc_conf_ch.collect().flatten().unique(),
			'scarc-10x'
		)

}
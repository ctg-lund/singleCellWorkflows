#!/usr/bin/env nextFlow
nextflow.enable.dsl=2


// Import modules
include { GET_ANALYSISES } from "./modules/get_analysises/main.nf"
// Import subworkflows
include { SCRNASEQ } from "./subworkflows/scrnaseq.nf"
include { FLEX_SCRNASEQ } from "./subworkflows/flexscrnaseq.nf"
include { SCCITESEQ } from "./subworkflows/scciteseq.nf"
include { SC_ATAC } from "./subworkflows/scatac.nf"
include { SC_ARC } from "./subworkflows/scarc.nf"
include { SCMULTI } from "./subworkflows/scmulti.nf"
// Delivery workflow
include {FINISH_PROJECT } from "./subworkflows/finish.nf"


workflow {
	samplesheet_ch = GET_ANALYSISES(params.samplesheet)
	pipeline_ch = samplesheet_ch
        .splitCsv(header:true)
        .map { row -> tuple( row.pipeline ) }
		.unique()
		.collect()
	
	if (pipeline_ch.contains('scrna-10x')) {
		rna_workflow = SCRNASEQ()
		FINISH_PROJECT(rna_workflow.project_id, 'scrna-10x')
	} 
	// if (pipeline_ch.contains('scflex-10x')) {
	// 	FLEX_SCRNASEQ()
	// }
	// if (pipeline_ch.contains('scciteseq-10x')) {
	// 	SCCITESEQ()
	// }
	// if (pipeline_ch.contains('scatac-10x')) {
	// 	SC_ATAC()
	// } 
	// if (pipeline_ch.contains('scarc-10x')) {
	// 	SC_ARC()
	// }
	// if (pipeline_ch.contains('scmulti-10x')) {
	// 	SCMULTI()
	// }
}

workflow.onComplete {
    println "Pipeline completed at: $workflow.complete"
    println "Execution status: ${ workflow.success ? 'OK' : 'failed' }"
}
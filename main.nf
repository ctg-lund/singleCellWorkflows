#!/usr/bin/env nextFlow
nextflow.enable.dsl=2

// Import module
include { SCRNASEQ } from "./subworkflows/scrnaseq.nf"
include { FLEX_SCRNASEQ } from "./subworkflows/flexscrnaseq.nf"
include { SCCITESEQ } from "./subworkflows/scciteseq.nf"
include { SC_ATAC } from "./subworkflows/scatac.nf"


workflow {
	if (params.analysis == 'scrna-10x') {
		SCRNASEQ()
	}
	else if (params.analysis == 'scflex-10x') {
		FLEX_SCRNASEQ()
	} else if (params.analysis == 'scciteseq-10x') {
		SCCITESEQ()
	} else if (params.analysis == 'scatac-10x') {
		SC_ATAC()
	} else {
		println "ERROR: No valid analysis type selected"
	}
}

workflow.onComplete {
    println "Pipeline completed at: $workflow.complete"
    println "Execution status: ${ workflow.success ? 'OK' : 'failed' }"
}
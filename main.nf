#!/usr/bin/env nextFlow
nextflow.enable.dsl=2

// Import module
include { SCRNASEQ } from "./subworkflows/scrnaseq.nf"
include { FLEX_SCRNASEQ } from "./subworkflows/flexscrnaseq.nf"
include { SCCITESEQ } from "./subworkflows/scciteseq.nf"
include { SC_ATAC } from "./subworkflows/scatac.nf"
include { SC_ARC } from "./subworkflows/scarc.nf"


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
	} else if (params.analysis == 'scarc-10x') {
		SC_ARC()
	} else {
		println "ERROR: No valid analysis type selected"
	}
}

workflow.onComplete {
    println "Pipeline completed at: $workflow.complete"
    println "Execution status: ${ workflow.success ? 'OK' : 'failed' }"
}
process SPACECOUNT {
	publishDir "${params.outdir}/${Sample_Project}/2_count", mode: 'move'
    input:
        tuple val(Sample_ID), val(Sample_Project), val(sample_species), val(cytaimage), val(darkimage), val(image), val(slide), val(area), val(alignment)
    output:
        file "${Sample_ID}/outs/*"
		val Sample_Project, emit: project_id
		val Sample_ID, emit: sample_id
    script:
    if ( sample_species == "Human" || sample_species == "human") {
	   genome=params.human 
	   probe_set = params.human_probes
       }
	else if ( sample_species == "mouse" || sample_species == "Mouse") {
	   genome=params.mouse 
	   probe_set = params.mouse_probes
       }
	else if ( sample_species == "custom" || sample_species == "Custom") {
	   genome=params.custom_genome 
	   probe_set = params.custom_probes
       }
	else {
	   print ">ERROR: Species not recognized" 
	   genome="ERR" }
	// This section will generate the arguments
	if ( cytaimage != "n") {
		cyta_argument = "--cytaimage="+params.outdir+'/'+Sample_Project+'/metadata/'+cytaimage
		probe_argument = "--probe-set="+probe_set
		}
	else {
		cyta_argument = ""
		probe_argument = ""
	}
	if ( darkimage != "n") {
		dark_argument = "--darkimage="+params.outdir+'/'+Sample_Project+'/metadata/'+darkimage
		}
	else {
		dark_argument = ""
	}
	if ( image != "n") {
		image_argument = "--image="+params.outdir+'/'+Sample_Project+'/metadata/'+image
		}
	else {
		image_argument = ""
	}
	if ( alignment != "n") {
		alignment_argument = "--loupe-alignment="+params.outdir+'/'+Sample_Project+'/metadata/'+alignment
		}
	else {
		alignment_argument = ""
	}


    """
    spaceranger count \
			--id="$Sample_ID" \
			--transcriptome=$genome \
			--fastqs=$params.outdir/$Sample_Project/fastq \
			--sample=$Sample_ID \
			--slide=$slide \
			--slidefile=$params.slide_references/${slide}.gpr \
			--area=$area \
			$image_argument \
			$dark_argument \
			$cyta_argument \
			$probe_argument \
			$alignment_argument \
    """
	stub:
	"""
	mkdir -p $Sample_ID/outs
	echo '''Sample ID,Genome,Pipeline version,Estimated number of cells,Feature linkages detected,Linked genes,Linked peaks,ATAC Confidently mapped read pairs,ATAC Fraction of genome in peaks,ATAC Fraction of high-quality fragments in cells,ATAC Fraction of high-quality fragments overlapping TSS,ATAC Fraction of high-quality fragments overlapping peaks,ATAC Fraction of transposition events in peaks in cells,ATAC Mean raw read pairs per cell,ATAC Median high-quality fragments per cell,ATAC Non-nuclear read pairs,ATAC Number of peaks,ATAC Percent duplicates,ATAC Q30 bases in barcode,ATAC Q30 bases in read 1,ATAC Q30 bases in read 2,ATAC Q30 bases in sample index i1,ATAC Sequenced read pairs,ATAC TSS enrichment score,ATAC Unmapped read pairs,ATAC Valid barcodes,GEX Fraction of transcriptomic reads in cells,GEX Mean raw reads per cell,GEX Median UMI counts per cell,GEX Median genes per cell,GEX Percent duplicates,GEX Q30 bases in UMI,GEX Q30 bases in barcode,GEX Q30 bases in read 2,GEX Reads mapped antisense to gene,GEX Reads mapped confidently to exonic regions,GEX Reads mapped confidently to genome,GEX Reads mapped confidently to intergenic regions,GEX Reads mapped confidently to intronic regions,GEX Reads mapped confidently to transcriptome,GEX Reads mapped to genome,GEX Reads with TSO,GEX Sequenced read pairs,GEX Total genes detected,GEX Valid UMIs,GEX Valid barcodes
$Sample_ID,GRCh38,cellranger-arc-2.0.2,11081,776888,16893,96617,0.9205,0.0626,0.9372,0.3413,0.5505,0.5157,40309.3643,20977.0000,0.0042,230097,0.2301,0.8726,0.9380,0.9295,0.9085,446668066,8.5542,0.0111,0.9663,0.8199,41154.8449,13559.0000,4595.0000,0.3180,0.9485,0.9621,0.9309,0.0909,0.5595,0.9047,0.0603,0.2849,0.7432,0.9783,0.0631,456036836,31721,0.9995,0.9567
	''' > $Sample_ID/outs/metrics_summary.csv
	touch $Sample_ID/outs/web_summary.html
	touch $Sample_ID/outs/cloupe.cloupe
	"""
}
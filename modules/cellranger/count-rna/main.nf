process COUNT {
	tag "$sample_id"
	publishDir "$params.outdir/${project_id}/2_count/", mode: "move", pattern: "$sample_id/outs/*"

	input: 
        tuple val(sample_id), val(sample_species), val(force), val(cellranger_aggregate), val(project_id)

	output:
        file "${sample_id}/outs/*" 
		val ('x'), emit: done
		val project_id, emit: project_id

	script:
	// Set force-cells if force not "n"
	forcecells=""
	if ( force != "n" && force != "null") {
	   forcecells="--force-cells=" + force }
	if ( params.intron_mode != 'true' ) {
		intron_argument="--include-introns false"
	} else {
		intron_argument=""
	}

	// Get sample_specieserence
	if ( sample_species == "Human" || sample_species == "human") {
	   genome=params.human }
	else if ( sample_species == "mouse" || sample_species == "Mouse") {
	   genome=params.mouse }
	else if ( sample_species == "hs-mm" || sample_species == "hsmm") {
	   genome=params.mixed_genome }   
	else if ( sample_species == "custom" || sample_species == "Custom") {
	   genome=params.custom_genome }
	else {
	   print ">ERROR: Species not recognized" 
	   genome="ERR" }

	"""
	cellranger count \\
	     --id $sample_id \\
	     --fastqs $params.outdir/$project_id/fastq \\
	     --sample $sample_id \\
	     --transcriptome $genome \\
		--localcores=19 --localmem 120 \\
		 $forcecells $intron_argument $params.cellranger_arguments

	"""
	stub:
	"""
	mkdir -p $sample_id/outs
	echo '''Sample ID,Genome,Pipeline version,Estimated number of cells,Feature linkages detected,Linked genes,Linked peaks,ATAC Confidently mapped read pairs,ATAC Fraction of genome in peaks,ATAC Fraction of high-quality fragments in cells,ATAC Fraction of high-quality fragments overlapping TSS,ATAC Fraction of high-quality fragments overlapping peaks,ATAC Fraction of transposition events in peaks in cells,ATAC Mean raw read pairs per cell,ATAC Median high-quality fragments per cell,ATAC Non-nuclear read pairs,ATAC Number of peaks,ATAC Percent duplicates,ATAC Q30 bases in barcode,ATAC Q30 bases in read 1,ATAC Q30 bases in read 2,ATAC Q30 bases in sample index i1,ATAC Sequenced read pairs,ATAC TSS enrichment score,ATAC Unmapped read pairs,ATAC Valid barcodes,GEX Fraction of transcriptomic reads in cells,GEX Mean raw reads per cell,GEX Median UMI counts per cell,GEX Median genes per cell,GEX Percent duplicates,GEX Q30 bases in UMI,GEX Q30 bases in barcode,GEX Q30 bases in read 2,GEX Reads mapped antisense to gene,GEX Reads mapped confidently to exonic regions,GEX Reads mapped confidently to genome,GEX Reads mapped confidently to intergenic regions,GEX Reads mapped confidently to intronic regions,GEX Reads mapped confidently to transcriptome,GEX Reads mapped to genome,GEX Reads with TSO,GEX Sequenced read pairs,GEX Total genes detected,GEX Valid UMIs,GEX Valid barcodes
$sample_id,GRCh38,cellranger-arc-2.0.2,11081,776888,16893,96617,0.9205,0.0626,0.9372,0.3413,0.5505,0.5157,40309.3643,20977.0000,0.0042,230097,0.2301,0.8726,0.9380,0.9295,0.9085,446668066,8.5542,0.0111,0.9663,0.8199,41154.8449,13559.0000,4595.0000,0.3180,0.9485,0.9621,0.9309,0.0909,0.5595,0.9047,0.0603,0.2849,0.7432,0.9783,0.0631,456036836,31721,0.9995,0.9567
	''' > $sample_id/outs/metrics_summary.csv
	touch $sample_id/outs/web_summary.html
	touch $sample_id/outs/cloupe.cloupe
	"""
}
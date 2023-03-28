process COUNT {

	publishDir "${outdir}/${project_id}/2_count/", mode: "move", pattern: "$sample_id/outs/*"

	input: 
        tuple val(sample_id), val(sample_species), val(force), val(cellranger_aggregate), val(project_id)
		val fqdir
		val outdir
		path config

	output:
        file "${sample_id}/outs/*" 
		val ('x'), emit: done
		val project_id, emit: project_id
	script:
	def filter = config.name != 'NO_FILE' ? "--filter $opt" : ''
	// Set force-cells if force not "n"
	forcecells=""
	if ( force != "n" && force != "null" ) {
	   forcecells="--force-cells=" + force }

	includeintrons="--include-introns true" 

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
	     --id=$sample_id \\
	     --fastqs=$outdir/$project_id/fastq \\
	     --sample=$sample_id \\
		 --project=$project_id \\
	     --transcriptome=$genome \\
		--localcores=19 --localmem=120 \\
		$includeintrons $forcecells

	"""
	stub:
	"""
	mkdir -p $sample_id/outs
	touch $sample_id/outs/metrics_summary.csv
	touch $sample_id/outs/web_summary.html
	touch $sample_id/outs/cloupe.cloupe
	"""
}
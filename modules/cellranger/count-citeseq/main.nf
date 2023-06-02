process COUNT {
	tag "$Sample_ID"

	publishDir "${params.outdir}/${Sample_Project}/2_count/", mode: "move", pattern: "$Sample_ID/outs/*"

	input: 
        path library
		path feature_reference
		val Sample_ID
		val Sample_Project
		val sample_species
	output:
        path "${Sample_ID}/outs/*" 
		val ('x'), emit: done
		val Sample_Project, emit: project_id
		val Sample_ID, emit: sample_id

	script:
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
	     --id=$Sample_ID \\
	     --transcriptome=$genome \\
         --feature-ref=$feature_reference \\
         --libraries=$library \\
		 --localcores=19 --localmem=120 \\

	"""
	stub:
	"""
	mkdir -p $Sample_ID/outs
	touch $Sample_ID/outs/metrics_summary.csv
	touch $Sample_ID/outs/web_summary.html
	touch $Sample_ID/outs/cloupe.cloupe
	"""
}
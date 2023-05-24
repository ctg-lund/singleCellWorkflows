process COUNT_ARC {

	publishDir "${params.outdir}/${Sample_Project}/2_count/", mode: "move", pattern: "$Sample_ID/outs/*"

	input: 
        path library
		val Sample_ID
		val Sample_Project
		val sample_species
	output:
        path "${Sample_ID}/outs/*" 
		val ('x'), emit: done
		val Sample_Project, emit: sample_project

	script:
	// Get sample_specieserence
	if ( sample_species == "Human" || sample_species == "human") {
	   genome=params.human_atac }
	else if ( sample_species == "mouse" || sample_species == "Mouse") {
	   genome=params.mouse_atac }
	else if ( sample_species == "custom" || sample_species == "Custom") {
	   genome=params.custom_genome }
	else {
	   print ">ERROR: Species not recognized" 
	   genome="ERR" }

	"""
	cellranger-arc count \\
	     --id=$Sample_ID \\
		 --project=$Sample_Project \\
	     --transcriptome=$genome \\
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
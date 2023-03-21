process MULTI {

	publishDir "${params.outdir}/${project_id}/multi/", mode: "move", pattern: "$sample_id/outs/*"

	input: 
        path multi_csv
		val(project_id)

	output:
        file "${sample_id}/outs/*" 
		val ('x'), emit: done
		val project_id, emit: project_id
		
	script:
	// Set force-cells if force not "n"
	forcecells=""
	if ( force != "n" && force != "null" ) {
	   forcecells="--force-cells=" + force }
	includeintrons="--include-introns true" 

	"""
	cellranger multi \\
	     --id=$sample_id \\
         --csv=$multi_csv \\
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
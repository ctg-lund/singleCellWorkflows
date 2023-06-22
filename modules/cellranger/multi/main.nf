process MULTI {
	tag "$sample_id"

	publishDir "${params.outdir}/${project_id}/2_multi/", mode: "move", pattern: "$sample_id/outs/*"

	input: 
        path config
		tuple val(sample_id), val(project_id)

	output:
        path "${sample_id}/outs/*" 
		val ('x'), emit: done
		val project_id, emit: project_id
		
	script:
	"""
	cellranger multi \\
	     --id=$sample_id \\
         --csv=$config \\
		--localcores=16 --localmem=120 \\
	"""
	stub:
	"""
	mkdir -p $sample_id/outs
	touch $sample_id/outs/metrics_summary.csv
	touch $sample_id/outs/web_summary.html
	touch $sample_id/outs/cloupe.cloupe
	"""
}
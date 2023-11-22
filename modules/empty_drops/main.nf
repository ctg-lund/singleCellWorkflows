process EMPTY_DROPS {
	tag "$sample_id"
	publishDir "$params.outdir/$project_id/3_droputils/", mode: 'move', pattern: "empty_drops"


	input:
		tuple val(sample_id), val(project_id)
	output:
		path "*empty_drops/*"
        tuple val(sample_id), val(project_id); emit
	script:
	"""
    mkdir empty_drops
    Rscript $projectDir/bin/emptyDrops.R $params.outdir/$project_id/2_count/$sample_id/outs/raw_feature_bc_matrix/
	"""
	stub:
	"""
        mkdir empty_drops
		touch empty_drops/matrix.mtx
	"""
}
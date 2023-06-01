process DELIVER_PROJ {
	tag "$project_id"

	input:
		val(project_id)

	output:
		val project_id

	script:
	"""
	cd $params.outdir/$project_id
	bash deliver.sh
	"""
	stub:
	"""
	echo $project_id
	"""

}
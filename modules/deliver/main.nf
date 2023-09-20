process DELIVER_PROJ {
	tag "$project_id"

	input:
		val(project_id)

	output:
		val project_id

	script:
	"""
	bash /projects/fs1/shared/Yggdrasil/bin/delivery.sh -d $params.outdir/$project_id -p $project_id -e $params.deliver_to
	"""
	stub:
	"""
	echo $project_id
	"""

}
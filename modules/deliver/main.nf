process DELIVER_PROJ {
	tag "$project_id"

	input:
		val(project_id)

	output:
		val project_id

	script:
	"""
	bash /projects/fs1/shared/Development_Github/Yggdrasil/bin/delivery.sh $params.outdir/$project_id $project_id jacob.karlstrom@med.lu.se
	"""
	stub:
	"""
	echo $project_id
	"""

}
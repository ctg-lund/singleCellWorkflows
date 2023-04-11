process DELIVER_PROJ {

	input:
		val(outdir)
		val(project_id)
		val "md5done"

	output:
		val project_id

	script:
	"""
	cd $outdir/$project_id
	bash deliver.sh	
	"""
	stub:
	"""
	echo $project_id
	"""

}
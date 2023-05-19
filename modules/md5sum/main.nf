process MD5SUM {

	input:
		val project_id
	output:
		val project_id, emit: project_id
	
	script:
	"""
	cd $params.outdir/${project_id}
	find . -type f -exec md5sum '{}' \\; > ctg-md5.${project_id}.txt
	""" 
	stub:
	"""
	cd $params.outdir/${project_id}
	touch ctg-md5.${project_id}.txt
	"""
}
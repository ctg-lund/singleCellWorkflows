process MD5SUM {

	input:
        file "*.html"
		val project_id
	output:
		val ("md5done"); emit: md5done
		val project_id, emit: project_id
	
	script:
	"""
	cd $params.outdir/${project_id}
	find . -type f -exec md5sum '{}' \\; > ctg-md5.${project_id}.txt
	""" 
	stub:
	"""
	touch ctg-md5.${project_id}.txt
	"""
}
process MD5SUM {
	publishDir "${outdir}/${project_id}/", mode: 'move', pattern: "ctg-md5.${project_id}.txt"

	input:
        file "*.html"
		val outdir
		val project_id
	output:
		file "ctg-md5*"
	
	script:
	"""
	cd ${outdir}/${project_id}
	find . -type f -exec md5sum '{}' \\; > ctg-md5.${project_id}.txt
	""" 
	stub:
	"""
	touch ctg-md5.${project_id}.txt
	"""
}
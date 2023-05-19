process FASTQC {
	publishDir "$params.outdir/$project_id/1_qc/fastqc", mode: 'move', pattern: "*fastqc*"


	input:
		tuple val(sample_id), val(project_id)
	output:
		path "*fastqc*"
	shell:
	"""
        for file in !{params.outdir}/$project_id/fastq/$sample_id*fastq.gz
            do fastqc -t $task.cpus \$file --outdir=./
        done
	"""
	stub:
	"""
		echo ${sample_id}, ${project_id}
		touch ${sample_id}.fastqc.html
		touch ${sample_id}.fastqc.zip
	"""
}
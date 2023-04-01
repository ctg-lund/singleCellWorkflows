process FASTQC {
	publishDir "$outdir/$project_id/1_qc/fastqc", mode: 'move', pattern: "*fastqc*"


	input:
		tuple val(sample_id), val(sample_species), val(force_cells), val(cellranger_aggregate), val(project_id)
		val(outdir)
	output:
		tuple val(sample_id), val(sample_species), val(force_cells), val(cellranger_aggregate), val(project_id)
		path "*fastqc*"
	shell:
	"""
        for file in $outdir/$project_id/fastq/$sample_id*fastq.gz
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
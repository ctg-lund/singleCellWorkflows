process SUMMARIZE_COUNT {

	tag "${projid}"

	input:
		val metrics
		val projid

	output:
		val projid 

	"""

	cd $outdir/$projid
	mkdir -p ${outdir}/${projid}/
	mkdir -p ${outdir}/${projid}/qc
	mkdir -p ${outdir}/${projid}/qc/cellranger
	
	python $basedir/bin/ctg-sc-count-metrics-concat.py -i ${outdir}/${projid}/ -o ${outdir}/${projid}/qc/cellranger

	# Copy to summaries delivery folder
	cp ${outdir}/${projid}/qc/cellranger/ctg-cellranger-count-summary_metrics.csv ${outdir}/${projid}/summaries/web-summaries/
	"""
}
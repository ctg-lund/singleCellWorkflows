process MULTI {
	tag "$sample_id"

	publishDir "${params.outdir}/${project_id}/2_multi/", mode: "move", pattern: "$sample_id/outs/*"

	input: 
        path config
		tuple val(sample_id), val(project_id)

	output:
        path "${sample_id}/outs/*" 
		val ('x'), emit: done
		val project_id, emit: project_id
		
	script:
	"""
	cellranger multi \\
	     --id=$sample_id \\
         --csv=$config \\
		--localcores=16 --localmem=120 \\
	"""
	stub:
	"""
	sample_dir=$sample_id/outs/per_sample_outs/$sample_id
	mkdir -p \$sample_dir
	touch \$sample_dir/web_summary.html
	touch \$sample_dir/cloupe.cloupe
	echo \'\'\'Category,Library Type,Grouped By,Group Name,Metric Name,Metric Value
Cells,Gene Expression,,,Cells,"5,727"
Cells,Gene Expression,,,Confidently mapped reads in cells,84.20%
Cells,Gene Expression,,,Median UMI counts per cell,"1,585"
Cells,Gene Expression,,,Median genes per cell,744
Cells,Gene Expression,,,Median reads per cell,"16,412"
Cells,Gene Expression,,,Total genes detected,"14,371"
Cells,VDJ B,,,Cells with productive IGH contig,78.52%
Cells,VDJ B,,,Cells with productive IGK contig,70.10%
Cells,VDJ B,,,Cells with productive IGL contig,6.19%
Cells,VDJ B,,,"Cells with productive V-J spanning (IGK, IGH) pair",49.31%
Cells,VDJ B,,,"Cells with productive V-J spanning (IGL, IGH) pair",5.50%
Cells,VDJ B,,,Paired clonotype diversity,72.28
Cells,VDJ T,,,Cells with productive TRA contig,79.03%
Cells,VDJ T,,,Cells with productive TRB contig,97.58%
Cells,VDJ T,,,"Cells with productive V-J spanning (TRA, TRB) pair",76.61%
Cells,VDJ T,,,Cells with productive V-J spanning pair,76.61%
Library,Gene Expression,Fastq ID,1a_522_3wbm,Number of reads,"172,468,563"
Library,Gene Expression,Fastq ID,1a_522_3wbm,Number of short reads skipped,0
Library,Gene Expression,Fastq ID,1a_522_3wbm,Q30 RNA read,91.1%
Library,Gene Expression,Fastq ID,1a_522_3wbm,Q30 UMI,94.8%
\'\'\' > \$sample_dir/metrics_summary.csv
	"""
}
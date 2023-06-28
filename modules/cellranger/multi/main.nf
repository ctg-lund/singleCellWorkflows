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
Cells,VDJ B,,,Cells with productive V-J spanning pair,54.47%
Cells,VDJ B,,,Estimated number of cells,582
Cells,VDJ B,,,Median IGH UMIs per Cell,9
Cells,VDJ B,,,Median IGK UMIs per Cell,10
Cells,VDJ B,,,Median IGL UMIs per Cell,0
Cells,VDJ B,,,Number of cells with productive V-J spanning pair,317
Cells,VDJ B,,,Paired clonotype diversity,72.28
Cells,VDJ T,,,Cells with productive TRA contig,79.03%
Cells,VDJ T,,,Cells with productive TRB contig,97.58%
Cells,VDJ T,,,"Cells with productive V-J spanning (TRA, TRB) pair",76.61%
Cells,VDJ T,,,Cells with productive V-J spanning pair,76.61%
Cells,VDJ T,,,Estimated number of cells,124
Cells,VDJ T,,,Median TRA UMIs per Cell,3
Cells,VDJ T,,,Median TRB UMIs per Cell,7
Cells,VDJ T,,,Number of cells with productive V-J spanning pair,95
Cells,VDJ T,,,Paired clonotype diversity,35.11
Library,Gene Expression,Fastq ID,1a_522_3wbm,Number of reads,"172,468,563"
Library,Gene Expression,Fastq ID,1a_522_3wbm,Number of short reads skipped,0
Library,Gene Expression,Fastq ID,1a_522_3wbm,Q30 RNA read,91.1%
Library,Gene Expression,Fastq ID,1a_522_3wbm,Q30 UMI,94.8%
Library,Gene Expression,Fastq ID,1a_522_3wbm,Q30 barcodes,95.8%
Library,Gene Expression,Physical library ID,GEX_1,Confidently mapped antisense,2.56%
Library,Gene Expression,Physical library ID,GEX_1,Confidently mapped reads in cells,84.20%
Library,Gene Expression,Physical library ID,GEX_1,Confidently mapped to exonic regions,21.93%
Library,Gene Expression,Physical library ID,GEX_1,Confidently mapped to genome,26.08%
Library,Gene Expression,Physical library ID,GEX_1,Confidently mapped to intergenic regions,2.50%
Library,Gene Expression,Physical library ID,GEX_1,Confidently mapped to intronic regions,1.65%
Library,Gene Expression,Physical library ID,GEX_1,Confidently mapped to transcriptome,20.79%
Library,Gene Expression,Physical library ID,GEX_1,Estimated number of cells,"5,727"
Library,Gene Expression,Physical library ID,GEX_1,Mapped to genome,36.49%
Library,Gene Expression,Physical library ID,GEX_1,Mean reads per cell,"30,115"
Library,Gene Expression,Physical library ID,GEX_1,Number of reads,"172,468,563"
Library,Gene Expression,Physical library ID,GEX_1,Number of reads in the library,"172,468,563"
Library,Gene Expression,Physical library ID,GEX_1,Sequencing saturation,50.84%
Library,Gene Expression,Physical library ID,GEX_1,Valid UMIs,99.85%
Library,Gene Expression,Physical library ID,GEX_1,Valid barcodes,92.38%
Library,VDJ B,Fastq ID,1a_522_3wbm_BCR,Number of reads,"30,607,267"
Library,VDJ B,Fastq ID,1a_522_3wbm_BCR,Number of short reads skipped,0
Library,VDJ B,Fastq ID,1a_522_3wbm_BCR,Q30 RNA read,92.7%
Library,VDJ B,Fastq ID,1a_522_3wbm_BCR,Q30 UMI,94.5%
Library,VDJ B,Fastq ID,1a_522_3wbm_BCR,Q30 barcodes,95.6%
Library,VDJ B,Physical library ID,VDJB_1,Estimated number of cells,582
Library,VDJ B,Physical library ID,VDJB_1,Fraction reads in cells,83.31%
Library,VDJ B,Physical library ID,VDJB_1,Mean reads per cell,"52,590"
Library,VDJ B,Physical library ID,VDJB_1,Mean used reads per cell,"9,638"
Library,VDJ B,Physical library ID,VDJB_1,Number of reads,"30,607,267"
Library,VDJ B,Physical library ID,VDJB_1,Reads mapped to IGH,22.57%
Library,VDJ B,Physical library ID,VDJB_1,Reads mapped to IGK,50.50%
Library,VDJ B,Physical library ID,VDJB_1,Reads mapped to IGL,14.06%
Library,VDJ B,Physical library ID,VDJB_1,Reads mapped to any V(D)J gene,87.14%
Library,VDJ B,Physical library ID,VDJB_1,Valid barcodes,95.44%
Library,VDJ T,Fastq ID,1a_522_3wbm_TCR,Number of reads,"39,674,884"
Library,VDJ T,Fastq ID,1a_522_3wbm_TCR,Number of short reads skipped,0
Library,VDJ T,Fastq ID,1a_522_3wbm_TCR,Q30 RNA read,91.5%
Library,VDJ T,Fastq ID,1a_522_3wbm_TCR,Q30 UMI,94.7%
Library,VDJ T,Fastq ID,1a_522_3wbm_TCR,Q30 barcodes,95.4%
Library,VDJ T,Physical library ID,VDJT_1,Estimated number of cells,124
Library,VDJ T,Physical library ID,VDJT_1,Fraction reads in cells,15.60%
Library,VDJ T,Physical library ID,VDJT_1,Mean reads per cell,"319,959"
Library,VDJ T,Physical library ID,VDJT_1,Mean used reads per cell,"35,979"
Library,VDJ T,Physical library ID,VDJT_1,Number of reads,"39,674,884"
Library,VDJ T,Physical library ID,VDJT_1,Reads mapped to TRA,7.91%
Library,VDJ T,Physical library ID,VDJT_1,Reads mapped to TRB,24.14%
Library,VDJ T,Physical library ID,VDJT_1,Reads mapped to any V(D)J gene,32.31%
Library,VDJ T,Physical library ID,VDJT_1,Valid barcodes,79.69%\'\'\' > \$sample_dir/metrics_summary.csv
	"""
}
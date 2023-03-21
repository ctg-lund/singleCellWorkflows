process GEN_AGG_CSV {

    tag "${sid}_${projid}"

    input:
    	tuple val(sid), val(projid), val(ref), val(force), val(agg)

    output:
    	tuple val(projid), val(ref), val(agg)
    
    """

    if [ "$agg" == "y" ] && [ "$ref" != "hs-mm" ]; then
        aggdir=$outdir/$projid/aggregate
   	mkdir -p \$aggdir
    	aggcsv=\$aggdir/${projid}_libraries.csv
    	if [ -f \$aggcsv ]
    	then 
            if grep -q $sid \$aggcsv
            then
		echo ""
            else
		sleep 3 
             	echo "${sid},${outdir}/${projid}/aggregate/${sid}.molecule_info.h5" >> \$aggcsv
            fi
    	else
	    echo "sample_id,molecule_h5" > \$aggcsv
	    sleep 2
            echo "${sid},${outdir}/${projid}/aggregate/${sid}.molecule_info.h5" >> \$aggcsv
    	fi
    else
        echo "No aggregation performed - agg != 'y'"
    fi
    """
}

process AGGREGATE {

    tag "$projid"
  
    input:
		tuple val(projid), val(ref), val(agg)
		val moleculeinfo

    output:
		val projid
		val "x"

    """
    if [ "$agg" == "y" ] && [ "$ref" != "hs-mm" ]; then
       aggdir="$outdir/$projid/aggregate"

       cellranger aggr \
       --id=${projid}_agg \
       --csv=\${aggdir}/${projid}_libraries.csv \
       --normalize=mapped


       ## Copy to delivery folder 
       cp ${projid}_agg/outs/web_summary.html ${outdir}/${projid}/summaries/web-summaries/${projid}_agg.web_summary.html
       cp ${projid}_agg/outs/count/cloupe.cloupe ${outdir}/${projid}/summaries/cloupe/${projid}_agg_cloupe.cloupe
       rm -r ${projid}_agg/outs/count/cloupe.cloupe

	## Copy to CTG QC dir 
    	cp ${outdir}/${projid}/summaries/web-summaries/${projid}_agg.web_summary.html ${ctgqc}/${projid}/web-summaries/
    	cp ${outdir}/${projid}/summaries/cloupe/${projid}_agg_cloupe.cloupe ${ctgqc}/${projid}/web-summaries/

       ## Move output to delivery
       if [ -d \${aggdir}/${projid}_agg ]; then
           rm -r \${aggdir}/${projid}_agg
       fi
       mv ${projid}_agg \${aggdir}/

    else
        echo "No aggregation performed - agg != 'y'"
    fi

    ## Remove the molecule_info.h5 files that are stored in the aggregate folder (the original files are still in count-cr/../outs 
    rm -f ${outdir}/${projid}/aggregate/*h5
      
    """

}
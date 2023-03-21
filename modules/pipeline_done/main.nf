process PIPE_DONE {

	tag "$projid"	

	input:
		val projid

	output:
		val projid

	""" 

	touch "$runfolder/ctg.cron.${sheetid}.done"

	cronlog="/projects/fs1/shared/ctg-cron/ctg-pipe-cron/logs/sc-rna-10x/cron-sc-rna-10x.log"
	cronlog_all="/projects/fs1/shared/ctg-cron/ctg-cron.log"
	
	rf=\$(basename $runfolder)
  	echo "\$(date): \$rf: DONE: sc-rna-10x ($projid)" >> \$cronlog
    	echo "\$(date): \$rf: DONE: sc-rna-10x ($projid)" >> \$cronlog_all

	"""

}
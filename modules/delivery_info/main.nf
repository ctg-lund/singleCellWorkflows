process DELIVERY_INFO {

	tag "$projid"

	input:
		tuple val(projid), val(email), val(deliver)

	"""
	mkdir -p ${outdir}/${projid}	
	deliveryinfo="${outdir}/${projid}/ctg-delivery.info.csv"
	echo "projid,${projid}" > \$deliveryinfo
	echo "email,${email}" >> \$deliveryinfo
	echo "pipeline,sc-rna-10x" >> \$deliveryinfo
	"""
}
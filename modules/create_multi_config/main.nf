process CREATE_MULTI_CONFIG {
    publishDir "$params.outdir/$project_id/metadata", mode: 'move', pattern: "*-config.csv"
    input:
        tuple val(sample_id), val(sample_species), val(barcodes)
        val (project_id)
        val (fastqpath)
    output:
        path "$sample_id-config.csv"
    script:
    if ( sample_species == "Human" || sample_species == "human") {
	   genome=params.human 
       probe=params.human_probe }
	else if ( sample_species == "mouse" || sample_species == "Mouse") {
	   genome=params.mouse 
       probe=params.mouse_probe
       }
	else if ( sample_species == "hs-mm" || sample_species == "hsmm") {
	   genome=params.mixed_genome }   
	else if ( sample_species == "custom" || sample_species == "Custom") {
	   genome=params.custom_genome }
	else {
	   print ">ERROR: Species not recognized" 
	   genome="ERR" }

    """
    echo '''[gene-expression]
    reference,${genome}
    probe-set,${probe}

    [libraries]
    fastq_id,fastqs,feature_types
    ${sample_id},${fastqpath}/${sample_id},Gene Expression
    
    [samples]
    sample_id, probe_barcode_ids
    ${sample_id},${barcodes}
    ''' > $sample_id-config.csv
    """
    stub:
    """
    touch $sample_id-config.csv
    """
}
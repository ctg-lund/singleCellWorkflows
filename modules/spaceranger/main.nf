process SPACECOUNT {
    input:
        tuple val(Sample_ID), val(Sample_Project), val(species), val(cytaimage), val(darkimage), val(image), val(slide), val(area)
        val params.ref_dir
    output:
        file "${sample_id}/outs/*" 
		val ('x'), emit: done
		val project_id, emit: project_id
    script:
    if ( sample_species == "Human" || sample_species == "human") {
	   genome=params.human 
       probes=params.human_probes
       }
	else if ( sample_species == "mouse" || sample_species == "Mouse") {
	   genome=params.mouse 
       probes=params.mouse_probes
       }
	else if ( sample_species == "custom" || sample_species == "Custom") {
	   genome=params.custom_genome 
       probes=params.custom_probes
       }
	else {
	   print ">ERROR: Species not recognized" 
	   genome="ERR" }
    """
    spaceranger count \
			--id="$Sample_ID" \
			--transcriptome=$genome \
			--probe-set=$probes \
			--fastqs=$outdir/$Sample_Project/fastq \
			--sample=$Sample_ID \
			--image=$outdir/$Sample_Project/metadata/$image \
			--slide=$slide \
			--slidefile=$params.slide_references/V42L21-335.gpr \
			--area=$area \
			--cytaimage=$outdir/$Sample_Project/metadata/$cytaimage \
    """
}
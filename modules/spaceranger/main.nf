process SPACECOUNT {
	publishDir "${params.outdir}/${Sample_Project}/2_count", mode: 'move'
    input:
        tuple val(Sample_ID), val(Sample_Project), val(sample_species), val(cytaimage), val(darkimage), val(image), val(slide), val(area)
    output:
        file "${Sample_ID}/outs/*"
		val Sample_Project, emit: project_id
    script:
    if ( sample_species == "Human" || sample_species == "human") {
	   genome=params.human 
	   probe_set = params.human_probes
       }
	else if ( sample_species == "mouse" || sample_species == "Mouse") {
	   genome=params.mouse 
	   probe_set = params.mouse_probes
       }
	else if ( sample_species == "custom" || sample_species == "Custom") {
	   genome=params.custom_genome 
	   probe_set = params.custom_probes
       }
	else {
	   print ">ERROR: Species not recognized" 
	   genome="ERR" }
	// This section will generate the arguments
	if ( cytaimage != "n") {
		cyta_argument = "--cytaimage="+params.outdir+Sample_Project+'/metadata/'+cytaimage
		probe_argument = "--probe-set="+probe_set
		}
	else {
		cyta_argument = ""
		probe_argument = ""
	}
	if ( darkimage != "n") {
		dark_argument = "--darkimage="+params.outdir+Sample_Project+'/metadata/'+darkimage
		}
	else {
		dark_argument = ""
	}
	if ( image != "n") {
		image_argument = "--image="+params.outdir+Sample_Project+'/metadata/'+image
		}
	else {
		image_argument = ""
	}


    """
    spaceranger count \
			--id="$Sample_ID" \
			--transcriptome=$genome \
			--fastqs=$outdir/$Sample_Project/fastq \
			--sample=$Sample_ID \
			--slide=$slide \
			--slidefile=$params.slide_references/${slide}.gpr \
			--area=$area \
			$image_argument \
			$dark_argument \
			$cyta_argument \
			$probe_argument \
    """
	stub:
	"""
	mkdir -p $Sample_ID/outs
	touch $Sample_ID/outs/metrics_summary.csv
	touch $Sample_ID/outs/web_summary.html
	touch $Sample_ID/outs/cloupe.cloupe
	"""
}
process GENERATE_LIB_CSV{
    input:
        tuple val(Sample_ID), val(Sample_Species), val(Sample_Project), val(sample_pair), val(libtype)
    output:
        path 'library.csv', emit: library
        val sample_name, emit: sample_name
        val sample_project, emit: sample_project
    script:
    lines=''
    for ( int i = 0; i < Sample_ID.size(); i++ ) {
        if (libtype[i] != 'gex'){
            library="Antibody Capture"

        } else {
            library="Gene Expression"
            sample_name = Sample_ID[i]
            sample_project = Sample_Project[i]
        }
        lines +=params.outdir+"/"+Sample_Project[0]+"/fastq,"+Sample_ID[i]+","+library+"\n"

    }
    """
    echo \"\"\"fastqs,sample,library_type,
${lines} \"\"\" > library.csv
    """
}
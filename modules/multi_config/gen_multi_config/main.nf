process GENERATE_MULTI_CONFIG{
    input:
        tuple val(Sample_ID), val(Sample_Species), val(Sample_Project), val(sample_pair), val(libtype)
    output:
        path 'config.csv', emit: library
        tuple val(sample_name), val(sample_project)
    script:
    lines=''
    // The ctg way
    sample_project = Sample_Project[0]
    sample_species = Sample_Species[0]
    sample_name=''
    vdj=''
    gex_header=''
    if (sample_species == 'human') {
        vdj_ref=params.human_vdj
        gex_ref=params.human
    } else if (sample_species == 'mouse') {
        vdj_ref=params.mouse_vdj
        gex_ref=params.human
    }
    if (libtype.contains('bcr') || libtype.contains('tcr')){
        vdj+='[vdj]\n'
        vdj+='reference,'+vdj_ref+'\n'
    }
    if (libtype.contains('gex')) {
        sample_name = Sample_ID[libtype.indexOf('gex')]
        gex_header+='[gene-expression]\n'
        gex_header+='reference,'+gex_ref+'\n'
    } else if (libtype.contains('adt')) {
        sample_name = Sample_ID[libtype.indexOf('adt')]
    } else if (libtype.contains('hto')) {
        sample_name = Sample_ID[libtype.indexOf('hto')]
    } else if (libtype.contains('crispr')) {
        sample_name = Sample_ID[libtype.indexOf('crispr')]
    }else if (libtype.contains('tcr')) {
        sample_name = Sample_ID[libtype.indexOf('tcr')]
    }else if (libtype.contains('bcr')) {
        sample_name = Sample_ID[libtype.indexOf('bcr')]
    }
    for ( int i = 0; i < Sample_ID.size(); i++ ) {
        if (libtype[i] == 'adt' || libtype[i] == 'hto'){
            library="Antibody Capture"
        } else if (libtype[i] == 'crispr'){
            library="CRISPR Guide Capture"
        } else if (libtype[i] == 'bcr'){
            library="VDJ-B"
        } else if (libtype[i] == 'tcr'){
            library="VDJ-T"
        } else {
            library="Gene Expression"
        }
        lines +=params.outdir+"/"+Sample_Project[0]+"/fastq,"+Sample_ID[i]+","+library+"\n"

    }
    """
echo \"\"\"${vdj}
${gex_header}
[libraries]
fastqs,sample,library_type
${lines} \"\"\" > config.csv
    """
}
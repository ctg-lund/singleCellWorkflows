process GENERATE_LIB_CSV{
    input:
        tuple val(Sample_ID), val(Sample_Species), val(force), val(agg), val(Sample_Project), val(sample_pair), val(hto), val(libtype)
        val outdir
    output:
        path '*library.csv'
    script:
    if (libtype == 'rna') {
        library_type = 'Gene Expression'
    } else if (libtype == 'hto') {
        library_type = 'Multiplexing Capture'
    } else if (libtype == 'adt') {
        library_type = 'Antibody Capture'
    }
    """
    echo '$outdir/$Sample_Project/$Sample_ID,$Sample_ID,$library_type' > ${Sample_ID}_library.csv
    """
}
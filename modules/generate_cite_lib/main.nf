process GENERATE_CITE_LIB{
    input:
        tuple val(Sample_ID), val(Sample_Species), val(force), val(agg), val(Sample_Project), val(sample_pair), val(hto), val(libtype)
        val outdir
    output:
        path '*ref.csv'
    script:
    if (libtype == 'rna') {
        library_type = 'Gene Expression'
    } else if (libtype == 'hto' || libtype == 'adt') {
        library_type = 'Antibody Capture'
    }
    """
    echo '$outdir/$Sample_Project/$Sample_ID,$Sample_ID,$library_type' > ${Sample_ID}_ref.csv
    """
}
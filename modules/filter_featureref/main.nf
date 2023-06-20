process FILTER_FEATURE_REFERENCE{
    tag "$Sample_ID"
    input:
    path feature_reference
    val Sample_ID
    output:
    path "feature_reference.csv" 

    shell:
    """
    head -n 1 ${feature_reference} > feature_reference.csv
    grep ${Sample_ID} ${feature_reference} >> feature_reference.csv
    cut -d ',' -f 1-6 feature_reference.csv > feature_reference.tmp
    mv feature_reference.tmp feature_reference.csv
    """

}
process FILTER_FEATURE_REFERENCE{
    input:
    path feature_reference
    val Project_ID
    output:
    path "feature_reference.csv" 

    shell:
    """
    head -n 1 ${feature_reference} > feature_reference.csv
    grep ${Project_ID} ${feature_reference} >> feature_reference.csv
    """

}
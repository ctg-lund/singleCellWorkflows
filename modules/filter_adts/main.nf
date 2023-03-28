process FILTER_ADTS{
    input 
    val adt_list

    output:
    path "adts.txt" 

    shell:
    """
    echo $adt_list > adts.txt
    """
    stub:
    """
    echo $adt_list > adts.txt
    """

}
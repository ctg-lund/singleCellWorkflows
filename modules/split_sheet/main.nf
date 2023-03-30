process SPLITSHEET {
    input:
        path samplesheet
        val pipeline
    output:
        path "10X_Data.csv", emit: data
        path "Data.csv", emit: pipe_data, optional: true
        path "10X_Flex_Settings.csv", emit: flex, optional: true
        path "10X_CiteSeq_Settings.csv", emit: citeseq, optional: true
    shell:
    '''
    while read line; do
        if [[ ${line::1} == '[' ]]; then
            header=$(echo "$line" | tr -d '[],')
            touch ${header}.csv
        else
            if ${header} != "10X_Data"; then
                echo ${line} >> ${header}.csv
            fi
            if [[ $line == *"!{pipeline}"*  ||  $line == *"Sample_ID"* ]]; then
                echo ${line} >> ${header}.csv
            fi

        fi
    done < !{samplesheet}
    '''
}
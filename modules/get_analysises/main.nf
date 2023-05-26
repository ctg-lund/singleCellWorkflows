process GET_ANALYSISES {
    input:
        path samplesheet
    output:
        path "10X_Data.csv", emit: data
    shell:
    '''
    while read line; do
        if [[ ${line::1} == '[' ]]; then
            header=$(echo "$line" | tr -d '[],')
            touch ${header}.csv
        else
            echo ${line} >> ${header}.csv
        fi
    done < !{samplesheet}
    '''
}
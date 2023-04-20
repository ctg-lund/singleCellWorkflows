process COMBINE_LIB_CSV {
    input:
        path "*library.csv"
    output:
        path "combined_library.csv"
    script:
        """
        echo "fastq_id,fastqs,feature_types" > combined_library.csv
        cat *.csv >> combined_library.csv
        """
}
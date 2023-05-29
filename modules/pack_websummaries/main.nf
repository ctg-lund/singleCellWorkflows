process PACK_WEBSUMMARIES{
    publishDir "$params.outdir/$project_id/3_summaries/cellranger", mode: 'move', pattern : "web_summaries.tar"

    input:
        val project_id
    output:
        path "web_summaries.tar", emit: tarball
        val project_id, emit: project_id

    shell:
    '''
    #!/bin/bash

    # set the folder path
    folder_path="$(readlink -f !{params.outdir}/!{project_id})"

    # create an array to store the file paths and sample names
    file_paths=()
    sample_names=()

    # loop through the folder and find all the web_summary.html files
    while IFS= read -r -d $'\0' file; do
    if [[ "$file" == *"web_summary.html" ]]; then
        # append the file path and the sample name to the array
        file_paths+=("$file")
        dir=$(dirname "$file")
        dir=$(dirname "$dir")
        result=$(basename "$dir")
        sample_names+=("$result")
        echo $file $result
    fi
    done < <(find "$folder_path" -name "web_summary.html" -print0)

    # create a temporary directory to store the renamed files
    temp_dir=$(mktemp -d)

    # loop through the file paths and rename them with unique names in the temporary directory
    for ((i=0; i<${#file_paths[@]}; i++)); do
    # generate a unique name for the file
    unique_name=${sample_names[$i]}_web_summary.html
    echo $unique_name
    # copy the file to the temporary directory with the unique name
    cp "${file_paths[$i]}" "$temp_dir/$unique_name"
    # update the file path in the array
    file_paths[$i]="$unique_name"
    done

    # create a tarball with the renamed files in the temporary directory
    tar_filename="web_summaries.tar"
    tar cf "$tar_filename" -C "$temp_dir" "${file_paths[@]}"

    # extract the tarball to the current directory, removing the prefixed folder path
    tar xf "$tar_filename" --strip-components=1

    # remove the temporary directory
    rm -rf "$temp_dir"
    '''
    stub:
    """
    echo "Pack web summaries"
    """
}
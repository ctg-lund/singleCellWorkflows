project=${PWD##*/}
att=$(find . -name *_multiqc_report.html)
att2=$(find . -name *webtar*)

echo """ProjectID,${project}
email-bnf,jacob.karlstrom@med.lu.se
PipelineName,sc-mkfastq
software,
software-version,
pipesteps,
output,
name,
attachment,${att}
attachment,${att2}
""" > ctg-delivery.info.csv
bash /projects/fs1/shared/shared-scripts/delivery/delivery.sh -d .
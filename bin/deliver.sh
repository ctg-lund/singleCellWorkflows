project=${PWD##*/}
att=$(find . -name *_multiqc_report.html)
att2=$(find . -name *web_summaries*)
att3=$(find . -name manifest.html)

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
attachment,${att3}
""" > ctg-delivery.info.csv
bash /projects/fs1/shared/shared-scripts/delivery/delivery.sh -d .
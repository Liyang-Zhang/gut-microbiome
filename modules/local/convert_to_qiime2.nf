// Convert to Qiime-compatible format
process VSEARCH_COMPATIBLE4QIIME2 {
    input:
    tuple path("all.otus.fasta"), path("all.otutab.txt")

    output:
    tuple path("all.otus.ready.fasta"), path("all.otutab.json.biom")

    """
    biom convert -i all.otutab.txt \
        -o all.otutab.json.biom \
        --table-type="OTU table" \
        --to-json

    awk '/^>/ {print(\$0)}; /^[^>]/ {print(toupper(\$0))}' all.otus.fasta | \
      awk -F";" '/^>/ {print \$1}; /^[^>]/ {print \$0}' > all.otus.ready.fasta
    """
}

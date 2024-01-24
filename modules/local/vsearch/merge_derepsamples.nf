process MERGE_DEREPSAMPLES {
    input:
    path dereplication_files

    output:
    path "all.merged.fasta"

    """
    zcat ${dereplication_files.join(' ')} > all.merged.fasta
    """
}

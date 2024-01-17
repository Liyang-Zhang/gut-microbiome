process VSEARCH_MERGER1R2 {
    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("*merged.fastq")

    """
    vsearch --fastq_mergepairs ${reads[0]} \
    --threads ${params.threads} \
    --reverse ${reads[1]} \
    --fastq_minovlen ${params.minimum_overlap} \
    --fastq_maxdiffs 0 \
    --fastqout ${sample}.merged.fastq \
    --fastq_eeout
    """
}

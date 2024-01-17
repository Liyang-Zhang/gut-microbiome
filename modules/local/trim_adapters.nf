// Truncate adapter
process TRIM_ADAPTER {

    debug true

    input:
    tuple val(sample), path(fq1), path(fq2)

    output:
    tuple val(sample), path("*trimmed.fastq.gz")

    """
    cutadapt -g ${params.r1_primer} -o ${sample}_1.trimmed.fastq.gz ${fq1}
    cutadapt -g ${params.r2_primer} -o ${sample}_2.trimmed.fastq.gz ${fq2}
    """
}

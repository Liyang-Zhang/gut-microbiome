process QUALITYFILTER {

    conda "${moduleDir}/environment.yml"

    input:
    tuple val(sample), path(read)

    output:
    tuple val(sample), path("*qc.pass.fasta.gz")

    """
    prinseq-lite.pl \
    -ns_max_n 0 \
    -min_qual_mean 20 \
    -custom_params "A 9;T 9;C 9;G 9" \
    -fastq ${read} \
    -out_format 1 \
    -out_good ${sample}.qc.pass \
    -out_bad ${sample}.qc.fail

    gzip -f ${sample}.qc.pass.fasta
    gzip -f ${sample}.qc.fail.fasta
    """
}

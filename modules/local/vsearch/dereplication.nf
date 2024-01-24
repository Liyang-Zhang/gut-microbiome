// Dereplication
process VSEARCH_DEREPLICATION {

    conda "${moduleDir}/environment.yml"

    input:
    tuple val(sample), path(read)

    output:
    path "*derep.fasta.gz"

    """
    vsearch --derep_fulllength ${read} \
    --sizeout \
    --minuniquesize 2 \
    --uc ${sample}.derep.uc \
    --relabel ${sample}. \
    --output ${sample}.derep.fasta

    gzip -f ${sample}.derep.fasta
    """
}

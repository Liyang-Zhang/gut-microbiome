process VSEARCH_OTUS {
    input:
    path "all.merged.fasta"

    output:
    tuple path("all.otus.fasta"), path("all.otutab.txt")

    """
    vsearch --derep_fulllength all.merged.fasta \
      --minuniquesize 2 \
      --sizein \
      --sizeout \
      --fasta_width 0 \
      --uc all.derep.uc \
      --output all.derep.fasta

    vsearch --cluster_size all.derep.fasta \
        --threads ${params.threads} \
        --id 0.97 \
        --sizein \
        --sizeout \
        --fasta_width 0 \
        --uc all.preclustered.uc \
        --centroids all.preclustered.fasta

    vsearch --uchime_ref all.preclustered.fasta \
        --threads ${params.threads} \
        --db ${params.gold_ref} \
        --sizein \
        --sizeout \
        --fasta_width 0 \
        --nonchimeras all.ref.nonchimeras.fasta

    perl ${params.map} all.derep.fasta all.preclustered.uc all.ref.nonchimeras.fasta > all.nonchimeras.derep.fasta

    perl ${params.map} all.merged.fasta all.derep.uc all.nonchimeras.derep.fasta > all.nonchimeras.fasta

    vsearch --cluster_size all.nonchimeras.fasta \
        --threads ${params.threads} \
        --id 0.97 \
        --strand plus \
        --sizein \
        --sizeout \
        --fasta_width 0 \
        --uc all.clustered.uc \
        --relabel OTU_ \
        --centroids all.otus.fasta \
        --otutabout all.otutab.txt

    """
}

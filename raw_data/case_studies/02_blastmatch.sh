
makeblastdb -in o_margaretae_aa.fasta -dbtype 'prot'

blastp -db o_margaretae_aa.fasta -query uniprot-organism_odorrana+keyword__Antimicrobial+\[KW-0929\]_.fasta -outfmt 6 -max_target_seqs 5 -evalue=0.00001 > o_margaretae_uniprot.blastp

# for case studies

TransDecoder.LongOrfs -t o_margaretae_na.fasta -m 50


makeblastdb -in uniprot-organism_odorrana+keyword__Antimicrobial+\[KW-0929\]_.fasta -dbtype 'prot'

blastp -db uniprot-organism_odorrana+keyword__Antimicrobial+\[KW-0929\]_.fasta\
	 -query o_margaretae_na.fasta.transdecoder_dir/longest_orfs.pep \
	  -outfmt 6 -max_target_seqs 1 -evalue=0.00001 > uniprot_amps.blastp


TransDecoder.Predict -t o_margaretae_na.fasta  --retain_blastp_hits uniprot_amps.blastp

cat o_margaretae_na.fasta.transdecoder.pep | sed 's/*//' > o_margaretae_aa.fasta
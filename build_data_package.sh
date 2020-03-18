
# AMP databases

echo raw_data/APD_032020.xlsx > data_list
echo raw_data/DRAMP_general_amps.xlsx >> data_list
echo raw_data/dramp_nat_tidy.fasta >> data_list
echo raw_data/dbAMPv1.4.xlsx >> data_list
echo raw_data/uniprot-keyword__Antimicrobial+\[KW-0929\]_+OR+_antimicrobial+peptide%--.tab >> data_list

# combined AMP dataset
echo cache/positive032020.fasta >> data_list

# cd-hit results
echo cache/positive032020_98.fasta >> data_list
echo raw_data/swissprot_all_MAY98.fasta >> data_list

# ampir v0.1.0 model related data

echo ampir_0.1.0_data/svm_Radial98_final.rds >> data_list
echo ampir_0.1.0_data/bg_tg98.rds >> data_list
echo ampir_0.1.0_data/features98.rds >> data_list
echo ampir_0.1.0_data/features98TrainNov19.rds >> data_list
echo ampir_0.1.0_data/features98TestNov19.rds >> data_list
echo ampir_0.1.0_data/1000_test_sqns98_new.fasta >> data_list

# benchmark data

echo raw_data/amp_scannerresultsNov19.csv >> data_list
echo raw_data/iamppredresults.csv >> data_list
echo raw_data/iamp2LMarch2020.txt >> data_list
echo raw_data/ampepresultsNov19.csv >> data_list
echo ampir_0.1.0_data/ampir_prob_data.rds >> data_list

tar -zcvf data.tgz -T data_list

rm data_list

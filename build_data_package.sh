# ampir v0.1.0 model related data

echo ampir_0.1.0_data/svm_Radial98_final.rds >> data_list
echo ampir_0.1.0_data/bg_tg98.rds >> data_list
echo ampir_0.1.0_data/features98.rds >> data_list
echo ampir_0.1.0_data/features98TrainNov19.rds >> data_list
echo ampir_0.1.0_data/features98TestNov19.rds >> data_list
echo ampir_0.1.0_data/1000_test_sqns98_new.fasta >> data_list

# ampir v0.2.0 related data
# AMP databases

echo raw_data/amp_databases/APD_032020.xlsx > data_list
echo raw_data/amp_databases/dramp_nat_tidy.fasta >> data_list
echo raw_data/amp_databases/dbAMPv1.4.xlsx >> data_list
echo raw_data/amp_databases/uniprot-keyword__Antimicrobial+[KW-0929]_.xlsx >> data_list

# combined AMP dataset
echo cache/positive032020.fasta >> data_list
echo cache/positive032020_98.fasta >> data_list
echo raw_data/amp_databases/ampir_positive070420.fasta >> data_list
echo raw_data/amp_databases/ampir_db.tsv >> data_list

# negative dataset

echo raw_data/swissprot_all_MAY98.fasta >> data_list
echo raw_data/amp_databases/uniprot-filtered-reviewed_yes_50.fasta
echo raw_data/amp_databases/ampir_negative070420_50.fasta >> data_list

# feature analysis and datasets

echo cache/rfe.rds >> data_list
echo cache/rfe_1.rds >> data_list
echo cache/features_1.rds >> data_list
echo cache/featuresTrain_1.rds >> data_list
echo cache/featuresTest_1.rds >> data_list

# model results
echo cache/tuned.rds >> data_list

# benchmark data

echo raw_data/amp_scannerresultsNov19.csv >> data_list
echo raw_data/iamppredresults.csv >> data_list
echo raw_data/iamp2LMarch2020.txt >> data_list
echo raw_data/ampepresultsNov19.csv >> data_list
echo ampir_0.1.0_data/ampir_prob_data.rds >> data_list
echo cache/models_roc.rds >> data_list 
echo cache/positive070420_test_50.fasta >> data_list

tar -zcvf data.tgz -T data_list

rm data_list

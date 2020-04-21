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
<<<<<<< HEAD
echo raw_data/amp_databases/uniprot-keyword__Antimicrobial+[KW-0929]_.fasta >> data_list

# ampir positive datasets
echo raw_data/amp_databases/ampir_positive.fasta >> data_list
echo raw_data/amp_databases/ampir_positive90.fasta >> data_list
echo raw_data/amp_databases/ampir_mature_positive.fasta >> data_list
echo raw_data/amp_databases/ampir_mature_positive90.fasta >> data_list
echo raw_data/amp_databases/ampir_db.tsv >> data_list

# ampir negative data
echo raw_data/amp_databases/ampir_negative90.fasta >> data_list

# Precalculated training and test feature sets
echo cache/featuresTest_mature.rds >> data_list
echo cache/featuresTest_precursor.rds >> data_list
echo cache/featuresTest_precursor_imbal.rds >> data_list
echo cache/featuresTest_precursor_nobench.rds >> data_list
echo cache/featuresTrain_mature.rds >> data_list
echo cache/featuresTrain_precursor.rds >> data_list
echo cache/featuresTrain_precursor_imbal.rds >> data_list
echo cache/featuresTrain_precursor_nobench.rds >> data_list
echo cache/features_mature.rds >> data_list
echo cache/features_precursor.rds >> data_list
echo cache/features_precursor_imbal.rds >> data_list
echo cache/features_precursor_nobench.rds >> data_list


# RFE and tuned model results
echo cache/tuned_mature.rds >> data_list
echo cache/tuned_precursor.rds >> data_list
echo cache/tuned_precursor_nobench.rds >> data_list

echo cache/rfe_precursor.rds >> data_list

=======

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
echo cache/tuned_1.rds >> data_list
echo cache/ampir_default_model.rds >> data_list
>>>>>>> upstream/master

# benchmark data
#
echo raw_data/benchmarking/datasets/arath/uniprot-proteome_up000006548.xlsx >> data_list
echo raw_data/benchmarking/datasets/human/uniprot-proteome_UP000005640.xlsx >> data_list
echo raw_data/benchmarking/datasets/iamp2l/iamp2l_bench.fasta >> data_list

# benchmark results
echo raw_data/benchmarking/results/ampep/ampep_iamp2l_bench.txt >> data_list
echo raw_data/benchmarking/results/ampep/arath_ampep.txt >> data_list
echo raw_data/benchmarking/results/ampep/human_ampep.txt >> data_list

echo raw_data/benchmarking/results/ampscanv2/arath/1585718632256_Prediction_Summary.csv >> data_list
echo raw_data/benchmarking/results/ampscanv2/arath/1585718071814_Prediction_Summary.csv >> data_list
echo raw_data/benchmarking/results/ampscanv2/human/1585707195821_Prediction_Summary.csv >> data_list
echo raw_data/benchmarking/results/ampscanv2/human/1585707368321_Prediction_Summary.csv >> data_list
echo raw_data/benchmarking/results/ampscanv2/iamp2l/1585811335833_Prediction_Summary.csv >> data_list

<<<<<<< HEAD
echo raw_data/benchmarking/results/iamppred/iamp2l_bench.csv >> data_list
echo raw_data/benchmarking/results/dbamp/20200403_060324.anti_finish.txt >> data_list

=======
echo raw_data/amp_scannerresultsNov19.csv >> data_list
echo raw_data/iamppredresults.csv >> data_list
echo raw_data/iamp2LMarch2020.txt >> data_list
echo raw_data/ampepresultsNov19.csv >> data_list
echo ampir_0.1.0_data/ampir_prob_data.rds >> data_list
echo cache/models_roc.rds >> data_list 
echo cache/positive070420_test_50.fasta >> data_list
>>>>>>> upstream/master

tar -zcvf data_amp_pub.tgz -T data_list

rm data_list

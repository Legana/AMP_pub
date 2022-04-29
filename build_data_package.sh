# ampir v0.1.0 model related data (old)

echo ampir_0.1.0_data/svm_Radial98_final.rds >> data_list
echo ampir_0.1.0_data/bg_tg98.rds >> data_list
echo ampir_0.1.0_data/features98.rds >> data_list
echo ampir_0.1.0_data/features98TrainNov19.rds >> data_list
echo ampir_0.1.0_data/features98TestNov19.rds >> data_list
echo ampir_0.1.0_data/1000_test_sqns98_new.fasta >> data_list

# ampir v1.0.0 related data
# AMP databases

echo raw_data/amp_databases/APD_032020.xlsx > data_list
echo raw_data/amp_databases/dramp_nat_tidy.fasta >> data_list
echo raw_data/amp_databases/dbAMPv1.4.xlsx >> data_list
echo raw_data/amp_databases/uniprot-keyword__Antimicrobial+[KW-0929]_.xlsx >> data_list
echo raw_data/amp_databases/uniprot-keyword__Antimicrobial+[KW-0929]_.fasta >> data_list

# updated AMP databases (April 2021)

echo raw_data/amp_databases/dramp_nat_tidy042021.fasta >> data_list
echo raw_data/amp_databases/APD_07042021.xlsx >> data_list
echo raw_data/amp_databases/uniprot-keyword Antimicrobial+[KW-0929]_042021.tab >> data_list


echo raw_data/amp_databases/trian_ne_set9894_for_ampep_sever.fasta >> data_list
echo raw_data/amp_databases/trian_po_set3298_for_ampep_sever.fasta >> data_list

echo raw_data/amp_databases/AMP_Scan2_OrigPaper_Dataset/AMP.tr.fa >> data_list
echo raw_data/amp_databases/AMP_Scan2_OrigPaper_Dataset/DECOY.tr.fa >> data_list

# ampir positive datasets
echo raw_data/amp_databases/ampir_positive.fasta >> data_list
echo raw_data/amp_databases/ampir_positive90.fasta >> data_list
echo raw_data/amp_databases/ampir_mature_positive.fasta >> data_list
echo raw_data/amp_databases/ampir_mature_positive90.fasta >> data_list
echo raw_data/amp_databases/ampir_db.tsv >> data_list
echo raw_data/amp_databases/ampir_mature_negative90.fasta >> data_list

# ampir negative data
echo raw_data/amp_databases/ampir_negative90.fasta >> data_list
echo raw_data/amp_databases/uniprot-length_[0+TO+60]+NOT+keyword__Antimicrobial+[KW-0929]_+A--.xlsx >> data_list
echo raw_data/amp_databases/ampir_mature_negative90.fasta >> data_list

# Precalculated training and test feature sets
echo raw_data/ampir_train_test/featuresTest_mature.rds >> data_list
echo raw_data/ampir_train_test/featuresTrain_mature.rds >> data_list
echo raw_data/ampir_train_test/featuresTest_precursor_imbal.rds >> data_list
echo raw_data/ampir_train_test/featuresTrain_precursor_imbal.rds >> data_list         



# RFE and tuned model results
echo raw_data/ampir_models/tuned_mature.rds >> data_list
echo raw_data/ampir_models/tuned_mature_final.rds >> data_list
echo raw_data/ampir_models/tuned_precursor_imbal.rds >> data_list
echo raw_data/ampir_models/tuned_precursor_imbal_nobench.rds >> data_list

echo raw_data/ampir_train_test/rfe_precursor.rds >> data_list


# benchmark data
#
echo raw_data/benchmarking/datasets/human/uniprot-proteome_UP000005640.tab >> data_list
echo raw_data/benchmarking/datasets/arath/uniprot-proteome_UP000006548.tab >> data_list
echo raw_data/benchmarking/datasets/human/uniprot-proteome_UP000005640.xlsx >> data_list
echo raw_data/benchmarking/datasets/arath/uniprot-proteome_UP000006548.xlsx >> data_list

echo raw_data/benchmarking/datasets/iamp2l/iamp2l_bench.fasta >> data_list
echo raw_data/benchmarking/datasets/ampir/mature_eval.fasta >> data_list
echo raw_data/benchmarking/datasets/ampir/precursor_eval.fasta >> data_list
echo raw_data/benchmarking/datasets/ampir/mature_train.fasta >> data_list
echo raw_data/benchmarking/datasets/ampir/precursor_train.fasta >> data_list

# benchmark results
echo raw_data/benchmarking/results/ampep/ampep_iamp2l_bench.txt >> data_list
echo raw_data/benchmarking/results/ampep/arath_ampep.txt >> data_list
echo raw_data/benchmarking/results/ampep/human_ampep.txt >> data_list
echo raw_data/benchmarking/results/ampep/mature_eval_ampep.txt >> data_list
echo raw_data/benchmarking/results/ampep/precursor_eval_ampep.txt >> data_list
echo raw_data/benchmarking/results/ampep/mature_train_ampep.txt >> data_list
echo raw_data/benchmarking/results/ampep/precursor_train_ampep.txt >> data_list


echo raw_data/benchmarking/results/ampscanv2/arath/1585718632256_Prediction_Summary.csv >> data_list
echo raw_data/benchmarking/results/ampscanv2/arath/1585718071814_Prediction_Summary.csv >> data_list
echo raw_data/benchmarking/results/ampscanv2/human/1585707195821_Prediction_Summary.csv >> data_list
echo raw_data/benchmarking/results/ampscanv2/human/1585707368321_Prediction_Summary.csv >> data_list
echo raw_data/benchmarking/results/ampscanv2/iamp2l/1585811335833_Prediction_Summary.csv >> data_list
#Test
echo raw_data/benchmarking/results/ampscanv2/ampir/1588756293516_Prediction_Summary.csv >> data_list 
echo raw_data/benchmarking/results/ampscanv2/ampir_prec/1588756490979_Prediction_Summary.csv >> data_list
#Train
echo raw_data/benchmarking/results/ampscanv2/ampir/1592431117418_Prediction_Summary.csv >> data_list
echo raw_data/benchmarking/results/ampscanv2/ampir_prec/1592432311616_Prediction_Summary.csv >> data_list


echo raw_data/benchmarking/results/iamppred/iamp2l_bench.csv >> data_list
echo raw_data/benchmarking/results/iamppred/ampir_precursor.csv >> data_list
echo raw_data/benchmarking/results/dbamp/20200403_060324.anti_finish.txt >> data_list
echo raw_data/benchmarking/results/iamppred/ampir_mature.csv >> data_list

echo raw_data/case_studies/centipede.xlsx >> data_list
echo raw_data/case_studies/o_margaretae_uniprot.blastp >> data_list
echo raw_data/case_studies/o_margaretae_aa.fasta >> data_list
echo raw_data/case_studies/uniprot-organism_odorrana+keyword__Antimicrobial+\[KW-0929\]_.fasta >> data_list
echo raw_data/case_studies/o_margaretae_na.fasta >> data_list


# Cache files to speed things up
echo cache/ref_predictions_ampir.rds >> data_list
echo cache/ampir_genome_roc.rds >> data_list

#ampir v1.1.0 data (model updated 9 April 2021)

echo ampir_v1.1.0_data/v1.1_featuresTest_mature.rds >> data_list
echo ampir_v1.1.0_data/v1.1_featuresTest_precursor_imbal.rds >> data_list
echo ampir_v1.1.0_data/v1.1_featuresTrain_mature.rds >> data_list
echo ampir_v1.1.0_data/v1.1_featuresTrain_precursor_imbal.rds >> data_list
echo ampir_v1.1.0_data/v1.1_features_mature.rds >> data_list
echo ampir_v1.1.0_data/v1.1_features_precursor_imbal.rds >> data_list
echo ampir_v1.1.0_data/v1.1_features_precursor_imbal_nobench.rds >> data_list
echo ampir_v1.1.0_data/v1.1_imbal_pos_neg_seqs.rds >> data_list
echo ampir_v1.1.0_data/v1.1_mature_pos_neg_seqs.rds >> data_list
echo ampir_v1.1.0_data/tuned_mature_full.rds >> data_list
echo ampir_v1.1.0_data/tuned_mature.rds >> data_list
echo ampir_v1.1.0_data/tuned_precursor_imbal_full.rds >> data_list
echo ampir_v1.1.0_data/tuned_precursor_imbal_nobench.rds >> data_list
echo ampir_v1.1.0_data/tuned_precursor_imbal.rds >> data_list

tar -zcvf data_amp_pub.tgz -T data_list

rm data_list

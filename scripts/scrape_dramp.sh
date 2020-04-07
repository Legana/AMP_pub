for i in $(seq -s ' ' 1 220);do

curl "http://dramp.cpu-bioinfor.org/browse/NaturalData.php?&end=5&begin=1&pageNow=${i}" -o p${i}.html
amp_ids=$(cat p${i}.html | grep -oE '(DRAMP[0-9]+)' | sort -u | tr '\n' ' ' | sed 's/ /%20/g')
curl "http://dramp.cpu-bioinfor.org/down_load/download.php?load_id=${amp_ids}&format=fasta" -o p${i}.fasta

done

# Scraping code above results in a html file for each webpage plus a FASTA file containing the sequences in FASTA format for each page.
# The FASTA files were concatenated into a single FASTA file and tidied up to remove blank lines in the files. 

cat *.fasta >> dramp_nat.fasta
sed '/^$/d' dramp_nat.fasta > dramp_nat_tidy.fasta

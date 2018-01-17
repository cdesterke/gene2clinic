#!/usr/bin/bash
## Annotation of human genes:   1st column of text file needs to contain human gene symbol list
## Author: Christophe Desterke
## Version 1.0.1
## Date: April 23th, 2017
## Usage: sh gene2clinic.sh humangene.txt

variable=${1}
if [ -z "${variable}" ]
then 
	echo "TEXTTAB file not passed as parameter"
	exit 1
fi

log_file="log_file.log" 

nom_fichier=$(echo $1 | sed -re 's/(.*).txt/\1/')

echo "analyse du ficher = $nom_fichier" >> $log_file

date >> $log_file



echo "-------------------------------------">> $log_file
echo "-------------------------------------">> $log_file

echo "CLINVAR human gene annotation" >> $log_file

echo "-------------------------------------">> $log_file

cat $1 | awk -v OFS="\t" '{print $1}' > input

awk -v OFS="\t" 'NR==FNR {h[$1] = $1; next} {print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9,h[$1]}' input DATABASES_GENES/clinvar.txt  > clinvar

sort -k2 clinvar > clinvar_sorted

awk '!arr[$10]++' clinvar_sorted > clinvar_uniq.txt
tail -n +2 clinvar_uniq.txt | sponge clinvar_uniq.txt
awk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9}' clinvar_uniq.txt > clinvar_annotation.txt

echo "Number of Clinvar reported genes in the list: " >> $log_file
wc -l clinvar_annotation.txt >> $log_file

echo  "Symbol GeneID Total_submissions Total_alleles Submissions_reporting_this_gene Alleles_reported_Pathogenic_Likely_pathogenic Gene_MIM_number Number_uncertain Number_with_conflicts" > headers_clinvar.tsv
cat headers_clinvar.tsv clinvar_annotation.txt >> result_clinvar.txt
echo "-------------------------------------">> $log_file
sed 's/ /\t/g' result_clinvar.txt > clinvar_results.csv
cat clinvar_results.csv >> $log_file
echo "-------------------------------------">> $log_file
echo "-------------------------------------">> $log_file

cat log_file.log

mkdir RESULTS
mv log_file.log clinvar_results.csv RESULTS
cd RESULTS


mv clinvar_results.csv $(echo clinvar_results.csv | sed "s/\./".$nom_fichier"\./")
mv log_file.log $(echo log_file.log | sed "s/\./".$nom_fichier"\./")

cd ..
mv RESULTS RESULTS_$nom_fichier

rm input 

rm clinvar_sorted
rm clinvar
rm clinvar_annotation.txt
rm clinvar_uniq.txt
rm result_clinvar.txt
rm headers_clinvar.tsv


exit 0

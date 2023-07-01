#!/bin/bash
dir=$PWD
mkdir $dir/tmp-motif-matrix
cd $dir/tmp-motif-matrix
awk '{OFS="\t";print $5,$4,length($3),$3}'  ../changename-MotifTarget.bed | grep "^mo"> tmp1
cut -f 1-3 tmp1|sort  |uniq > matrix.txt
cat matrix.txt | while read id;
do
num=`awk '{print $1}' <<< "$id"`
motif=`awk '{print $2}' <<< "$id"`
len=`awk '{print $3}' <<< "$id"`
grep "$motif" -A$len ../all_motif_rmdup > ${num}.motif
done

cd ../
cat list | while read li
do
fasdir=$dir/$li
cd $fasdir
for i in `ls result1-*.fa`
do
file=$(basename $i )
lin=-in_alignment-${li}.fas.fa
sample=${file/"$lin"/}
echo $sample
motifname1=`echo $sample | grep -Eo "motifnum[0-9]+"`
motifname=${motifname1/_/}
echo $motifname
out_name=result2-${sample##result1-}

cat $i | while read id
do
if [[ "$id" =~ ">" ]];then
	echo "$id" >> ${out_name}.motif_score+++.txt
	echo "$id" >> ${out_name}.motif_score---.txt
else
	seq=$id
	len1=${#seq}
	num=1
	len=`expr $len1 + $num`
	output=${out_name}.motif_score+++.txt
	output1=${out_name}.motif_score---.txt
	target_motif=$dir/tmp-motif-matrix/${motifname}.motif
    perl ../sub02.cal-motif-score.pl $target_motif $seq $output

	perl ../sub03.cal-motif-score-reverse-strand.pl $target_motif $seq $output1
fi
done
done

done

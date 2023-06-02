#!/bin/bash
cut -f 4 MotifTarget_mm10.bed | grep -v "Motif Name" | sort | uniq > allmotif
awk '{print $0"\tmotifnum"FNR}' allmotif > allmotif1
perl sub2.changename.pl MotifTarget_mm10.bed changename-MotifTarget.bed
cat list | while read li
do
aimdir=$dir/$li
mkdir $aimdir
cd $aimdir
grep "$li" ../changename-MotifTarget.bed > homer-${li}.fas.tsv
cp ../alignment-${li}.fas .
peakfas=alignment-${li}.fas
awk '{OFS="	";print $5,$4,$2,$2+length($3)-1,length($3),$6,$7,$3}' homer*.tsv > about_mouse-motif.txt
cat about_mouse-motif.txt | while read i
do
grep ">mm10" -A1 $peakfas > test.fa
grep -v ">" test.fa > test1.fa
six=`awk '{print $6}' <<< "$i"`
str3=`cat test1.fa`
if [[ $six =~ "-" ]];then	
	str3_find=`awk '{print $8}' <<< "$i"`
	eight=`echo $str3_find |tr a-z A-Z |tr ATCG TAGC |rev`
	loc=`echo $str3 | awk -v param=$eight '{ printf( "%d\n", match( $0, param )) }'`
	len=`awk '{print $5}' <<< "$i"`
	n=`expr $loc + $len`
	motif_name=`awk '{print $2}' <<< "$i"`
	one=`awk '{print $1}' <<< "$i"`
	seven=`awk '{print $7}' <<< "$i"`
	echo $one $motif_name $loc $n $len $six $seven $eight $str3_find>> about_motif-zhengli.txt
else
	str3_find=`awk '{print $8}' <<< "$i"`
	loc=`echo $str3 | awk -v param=$str3_find '{ printf( "%d\n", match( $0, param )) }'`
	len=`awk '{print $5}' <<< "$i"`
	n=`expr $loc + $len`
	motif_name=`awk '{print $2}' <<< "$i"`
	one=`awk '{print $1}' <<< "$i"`
	seven=`awk '{print $7}' <<< "$i"`
	echo $one $motif_name $loc $n $len $six $seven $str3_find>> about_motif-zhengli.txt
fi
done
#+- 
awk '{if($3 != "0") print $0}' about_motif-zhengli.txt > about_motif-final.txt2
sort about_motif-final.txt2 | uniq > about_motif-final.txt
cat about_motif-final.txt | while read i
do
m=`awk '{print $3-1}' <<< "$i"`
n=`awk '{print $4-1}' <<< "$i"`
motif_name=`awk '{print $1}' <<< "$i"`
seq=`awk '{print $8}' <<< "$i"`
cat $peakfas| while read id
do

if [[ $id =~ ">" ]];then
	echo $id >> result1-${motif_name}_${seq}-in_${peakfas}.fa
else
        echo ${id:$m:($n-$m)} >> result1-${motif_name}_${seq}-in_${peakfas}.fa
fi
done
done

done
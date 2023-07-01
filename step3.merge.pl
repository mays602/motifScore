dir=$PWD
cat list | while read li
do
fasdir=$dir/$li
cd $fasdir

for i in `ls result2-*.motif_score*.txt`
do

file=$(basename $i )

cat $i | while read id
do
if [[ $id =~ ">" ]];then
	one=$id
#	echo $id >> result3-${i##result2-}
else
	two=`awk '{print $2}' <<< "$id"`
	three=`awk '{print $3}' <<< "$id"`
	if [[ $three != "" ]];then
		echo $one $two >> result3-${i##result2-}
	fi
fi
done

done

touch 0.txt
cat about_motif-final.txt| while read id
do
add=`awk '{print $8}' <<< "$id"`
mname=`awk '{print $1}' <<< "$id"`
name=$mname"_"$add
paste result3-${name}.motif_score+++.txt result3-${name}.motif_score---.txt > result4-paste-${name}.motif_score.txt
awk '{if($2 < $4) {print $1,$4} else {print $1,$2}}' result4-paste-${name}.motif_score.txt > result5-final-paste-${name}.motif_score.txt
sed -i '1i\'$name' '$name'' result5-final-paste-${name}.motif_score.txt

echo $name $name > result6-linshi-${name}.txt
grep ">" alignment-${li}.fas > spec.list
sed -i 's/>//' spec.list
cat spec.list | while read spec;do
	pi=`grep -w $spec result5-final-paste-${name}.motif_score.txt`
	if [[ "$pi" = "" ]];then
		echo ">"$spec NA >> result6-linshi-${name}.txt
	else
		echo $pi >> result6-linshi-${name}.txt
	fi
	done
awk '{print $1,$2}' result6-linshi-${name}.txt > result6-linshi-${name}.txt1
paste 0.txt result6-linshi-${name}.txt1 > result6-${name}.txt
mv result6-${name}.txt 0.txt
sed 's/ /\t/g' 0.txt > result7-merge.txt

done

done

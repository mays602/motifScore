#!/usr/bin/perl
use Math::Complex;
#printf "log2($a/0.25) = %lf\n", logn($a/0.25, 2);
open ON, "<$ARGV[0]";
open OUT,">>$ARGV[2]";
my $var = $ARGV[1];
my $i = 0;
undef %hash_a;
undef %hash_c;
undef %hash_g;
undef %hash_t;
readline ON; #skip the first line
while (<ON>) {
  chomp();
  $i = $i + 1;
  @id=split(/\t/,$_);
  if($id[0] < 1e-12 ){
        $id[0]=1e-12;}
  if($id[1] < 1e-12 ){
        $id[1]=1e-12;}
  if($id[2] < 1e-12 ){
        $id[2]=1e-12;}
  if($id[3] < 1e-12 ){
        $id[3]=1e-12;}
  $hash_a{$i}=logn($id[0]/0.25, 2);
  $hash_c{$i}=logn($id[1]/0.25, 2);
  $hash_g{$i}=logn($id[2]/0.25, 2);
  $hash_t{$i}=logn($id[3]/0.25, 2);
   }
close ON;
$var = uc ($var);
$req_seq =  rev_and_com($var);
my @array=split(//,$req_seq);
my $n = 0;
my $len = length($var);
my $score="";
undef %hashscore;

sub rev_and_com {
	my $s ="";
	my $a ="";
	$s = shift;
	$a = $s;
	$a =~ tr/atcgATCG/tagcTAGC/;
	return reverse($a);
}

foreach my $num (0..$#array){
 $n = $n + 1;
# print OUT"$array[$num]\n"
 if($array[$num] eq "A"){
	$score=$hash_a{$n}+$score;
#	print OUT"A $array[$num] $hash_a{$n}\n";
	next;	}
 if($array[$num] eq "C"){
        $score=$hash_c{$n}+$score;
#	print OUT"C $array[$num] $hash_c{$n}\n";
	next;	}
 if($array[$num] eq "G"){
        $score=$hash_g{$n}+$score;
#	print OUT"G $array[$num] $hash_g{$n}\n";
	next;}
 if($array[$num] eq "T"){
        $score=$hash_t{$n}+$score;
#	print OUT"T $array[$num] $hash_t{$n}\n";
	next;}
 next;
}
 $hashscore{$req_seq}=$score."\t".$n;
 while(($k,$v)=each %hashscore){
        print OUT"$k\t$v\n";
	}
 close OUT;

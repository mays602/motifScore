#!/usr/bin/perl
open(IN,"$ARGV[0]") or die $!;
open OUT, ">$ARGV[1]";

open ON, "<allmotif1";

undef %hash;

while(<ON>){
	chomp();
	@name=split(/\t/,$_);
	$hash{$name[0]}=$name[1];
}
close ON;

undef %hash1;
while (<IN>) {
	@id=split(/\t/,$_);
	chomp();
#CNE7-chr18_61447798_61448209    278     TCAAGGGCAG      Esrrb(NR)/mES-Esrrb-ChIP-Seq(GSE11431)/Homer    -       7.760381
	$motif="$id[0]"."\t"."$id[1]"."\t"."$id[2]"."\t"."$id[3]";
	 $hash1{$motif}="$hash{$id[3]}"."\t"."$id[4]"."\t"."$id[5]";
#		}
	}

while (($k,$v)=each %hash1) {
   print OUT "$k\t$v\n";
   }

close IN;
close OUT;

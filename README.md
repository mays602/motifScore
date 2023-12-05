# motifScore

A sequence is scored by the motifs PWM matrix to assess whether the sequence is a potential motif.


Software requirements:

This package is supported for macOS and Linux. The package has been tested on the following systems:
Linux: Red Hat Enterprise Linux Server release 7.5 (Maipo)


Install from Github:

wget https://github.com/mayuanshuo/motifScore/archive/refs/heads/master.zip
unzip master.zip


Prepare the files before running:

MotifTarget_mm10.bed:
findMotifsGenome.pl $bed mm10 ./. -size given -find all_motif_rmdup -preparsedDir $dir/ > MotifTarget_mm10.bed

fasta file: eg. alignment-chr7-99249119-99249904.fas

all_motif_rmdup: This file is derived from PECA2.(Duren, Zhana, et al. "Time course regulatory analysis based on paired expression and chromatin accessibility data." Genome research 30.4 (2020): 622-634.)

Run:

cd motifScore/test
sh step1.prepare_motif_fasta.sh
sh step2.cal-score.sh
sh step3.merge.pl

Results: result7-merge.txt

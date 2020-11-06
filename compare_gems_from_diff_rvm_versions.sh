#!/bin/bash --login
# comparing two versions of ruby in rvm to ensure
# that their gem list is the same

# TODO: add 2 cli parameters to get vers_1 and vers_2 with error checking

vers_1=2.7.1
vers_2=2.7.2
outf=gems_diff.txt

# TODO: add cli option to choose between rvm and rbenv

rvm use $vers_1
gem list | cut -d' ' -f1 | sort -u > gems_${vers_1}.srt

rvm use $vers_2
gem list | cut -d' ' -f1 | sort -u > gems_${vers_2}.srt

echo "Gems in $vers_1 not in $vers_2" > $outf
join -v 1 -j 1 gems_${vers_1}.srt gems_${vers_2}.srt >> $outf

echo "--" >> $outf

echo "Gems in $vers_2 not in $vers_1" >> $outf
join -v 2 -j 1 gems_${vers_1}.srt gems_${vers_2}.srt >> $outf

cat $outf


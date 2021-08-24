#!/bin/bash --login
# comparing two versions of ruby in rvm to ensure
# that their gem list is the same

if [ "" == $1 ]; then
  echo "Need two gem versions as parameters"
  exit 1
fi

if [ "" == $2 ]; then
  echo "Need two gem versions as parameters"
  exit 1
fi




vers_1=$1
vers_2=$2
outf=gems_diff.txt

rbenv local $vers_1
gem list | cut -d' ' -f1 | sort -u > gems_${vers_1}.srt

rbenv local $vers_2
gem list | cut -d' ' -f1 | sort -u > gems_${vers_2}.srt

echo "Gems in $vers_1 not in $vers_2" > $outf
join -v 1 -j 1 gems_${vers_1}.srt gems_${vers_2}.srt >> $outf

echo "--" >> $outf

echo "Gems in $vers_2 not in $vers_1" >> $outf
join -v 2 -j 1 gems_${vers_1}.srt gems_${vers_2}.srt >> $outf

cat $outf

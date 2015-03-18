#!/usr/bin/env bash 

# __author__ = "Gregory Ditzler"
# __copyright__ = "Copyright 2014, EESI Laboratory (Drexel University)"
# __credits__ = ["Gregory Ditzler"]
# __license__ = "GPL"
# __version__ = "0.1.0"
# __maintainer__ = "Gregory Ditzler"
# __email__ = "gregory.ditzler@gmail.com"

f=SEX
ft=AmericanGut-Gut-Diet-OV
ft=caporaso-gut
map=data/$ft.txt
data=data/$ft.biom
tdir=tmzout/

echo "Calling RF"
{ time supervised_learning.py -i $data -m $map -c $f -o $tdir/qiime-dir/ -f ; } 2> $tdir/qiime-rf.time &
 
 
for selects in `seq 100 100 900`; do 
  echo "Running $selects"
   { time fizzy -i $data -m $map -l $f -o $tdir/mim-$selects.txt -n $selects -f MIM ; } 2> $tdir/mim-$selects.time &
   { time fizzy -i $data -m $map -l $f -o $tdir/mrmr-$selects.txt -n $selects -f mRMR ; } 2> $tdir/mrmr-$selects.time &
   { time fizzy -i $data -m $map -l $f -o $tdir/jmi-$selects.txt -n $selects -f JMI ; } 2> $tdir/jmi-$selects.time &
  wait 
done

echo "Running NPFS"
{ time npfs -l $f -f MIM -i $data -m $map -o $tdir/npfs.txt -n 25 -b 100 -c 60; } 2> $tdir/npfs.time

echo "Running Lasso"
{ time lasso -l $f -i $data -m $map -q $tdir/lasso-weights.txt -o $tdir/lasso-out.txt -r $tdir/lasso.biom -c lasso_config.txt ; } 2> $tdir/lasso.time

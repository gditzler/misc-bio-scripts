#!/usr/bin/env bash 


./lefse/format_input.py data/agp-diet-lefse.txt tmzout/lefse.in -c 1 -u 2 -o 1000000
./lefse/run_lefse.py tmzout/lefse.in tmzout/lefse.res -w 0.01 -a -0.01
./lefse/plot_res.py tmzout/lefse.res tmzout/lefse-agp.png
./lefse/plot_cladogram.py tmzout/lefse.res tmzout/lefse-agp-clad.png --format png
mkdir tmzout/biomarkers_raw_images/
./lefse/plot_features.py tmzout/lefse.in tmzout/lefse.res tmzout/biomarkers_raw_images/



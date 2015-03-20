# cleaning up the time files for plotting 

```bash
ls tmzout/jmi-*.time | xargs cat | grep CPU | sed -e "s/^\([0-9]*\).\([0-9]*\)user .*/\1.\2/g" > tmzout/all-jmi.time
ls tmzout/mim-*.time | xargs cat | grep CPU | sed -e "s/^\([0-9]*\).\([0-9]*\)user .*/\1.\2/g" > tmzout/all-mim.time
ls tmzout/mrmr-*.time | xargs cat | grep CPU | sed -e "s/^\([0-9]*\).\([0-9]*\)user .*/\1.\2/g" > tmzout/all-mrmr.time


cat -n AmericanGut-Gut-Diet-OV-Results-Fizzy-JMI.txt | tr -d ' ' | awk -F '\t' '{d=$4-$7; if (d >= 0) {print $1-1,$2,sprintf("%.9f", d),"p";}else{print $1-1,$2,sprintf("%.9f", -d),"n";} }'  | tail -n +2 | sort -k3 -nr | head -15


{ time ./lefse.sh > tmzout/lefse-output.txt ; } 2> tmzout/lefse.time
```

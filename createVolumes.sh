#!/bin/bash
# Create cfradial volumes using RadxConvert

for file in swp.*0.9*  #assumes all volumes have a 0.9 file
do
    vol=`echo $file | cut -d '_' -f 3`
    RadxConvert -ag_all -f swp.*$vol -outdir $1
done

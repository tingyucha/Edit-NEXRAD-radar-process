#!/bin/bash
for file in cfrad*.nc
do 
Radx2Grid -f $file -params Radx2Grid.example.flat.param.txt
done



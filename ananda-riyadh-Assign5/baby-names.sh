#!/bin/bash
#Riyadh Ananda
#Assign 5
#11-1-2022

#Print initial message
echo "Common boy baby names between 2006 and 2016 are..."
#Extract column 2(boy names) from the 2006 file, remove header lines, then place in temp file we will later join
cut -f 2 -d " " CSCI4305-assign5/2006-baby-names.txt | tail -n +2 > 2006babies.txt 

#Extract column 2(boy names) from the 2016 file, remove header lines, then place in temp file we will later join
cut -f 2 -d " " CSCI4305-assign5/2016-baby-names.txt | tail -n +2 > 2016babies.txt

#Use comm to remove duplicates
comm -12 <(sort 2006babies.txt) <(sort 2016babies.txt) 
#asdf


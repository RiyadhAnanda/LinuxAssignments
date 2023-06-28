#!/bin/bash
#Riyadh Ananda
#Assign 5
#11-1-2022

#Extract permission, file size, and path (columns 1,5, 9) and sort by file size descending order
cut -f 1,5,9 -d ' ' ls_output.txt | sort -f -k  5 -r 


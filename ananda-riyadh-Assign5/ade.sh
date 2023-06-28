#!/bin/bash
#Riyadh Ananda
#Assignment 5
#11-1-2022

#Display message saying "Creating ADE school file"
echo "Creating ADE school file"
#Using tail command, this will basically copy the contents of ade-district and paste it into ade-school
tail -n +2 CSCI4305-assign5/ade-district.csv > ade-schools.csv
#Display message saying "Creating ADE enrollment file"
echo "Creating ADE enrollment file"
#Using the cut command we will extract or select columns 2 3 & 6 (Name, District, Enrollment) that are delimited by a comma and place into ade-enroll
cut -f 2,3,6 -d ',' CSCI4305-assign5/ade-district.csv > ade-enroll.csv
#Display message saying "Creating ADE output file"
echo "Creating ADE output file"
#Using pipleine, we remove the header of ade-district with -n +2 and then sort on the 3rd key-district- and then output to ade-output
tail -n +2 CSCI4305-assign5/ade-district.csv | sort -f -k 3 -t ','  > ade-output.csv
#Display message saying "Finished! Thank you
echo "Finished! Thank you"


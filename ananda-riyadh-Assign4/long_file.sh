#Riyadh Ananda
#Assignment 4

#!/bin/bash
#Argument Validation

#No Argument given
if [ $# -eq 0 ]
	then
	echo "You must supply at least one argument"
	exit 1
fi
#Succesfully inputted a directory name
if [ -d "$1" ]
then
echo "Directory: $1 "
#Did not input a directory
else
echo "First parameter must be a directory (dir)"
fi

for i in $(ls) 
do
 if [ -d "$i" ]
 	then
	echo "$(ls)"
fi
done

#!/bin/bash
# Name: Riyadh Ananda
# Date: 11/28/22
# Project: Guided Semester Project

#***************************************************
# Script Purpose
# This script importss a file, uncompresses the file, preporcess
# the data (clean the data), sumes the contributions donated for
# only Juniors and Senoirs to figure out who donated the most
#****************************************************

# Run: ./etl.sh remote_srv/DemoData* fname lname # 3args

# Err Handling
set -o errexit	# exit if an error occurs
set -o pipefail #exit if error occurs during pipes

# Check parameters are correct
if (( $# != 3 )); then
	echo "Usage: $0 file fname lname" ; exit 1
fi
if [[ ! -f "$1" ]]; then
	echo "First parameter must be a normal file (\$1)($1)"; exit 1
fi

#Declare Variables
src_file_path="$1"
src_file_compressed="$(basename $src_file_path)"
src_file_extracted="" # Leave Blank - Will be overwritten
fname="$2"
lname="$3"
coder="Riyadh Ananda"	# Enter your First and Last Name

function rm_temps () {
	read -p "Delete Temporary Files? (Y/n): "
	if [[ $REPLY = [Yy] ]]; then
		rm -f *.tmp
		rm -f Demo*
		echo "Temporary Files Deleted"
		exit 0
	fi
}

	# 1) Import file from remote_srv folder - mimic for download of file from server
	cp $src_file_path .
	printf "1) Importing testfile: $src_file_compressed -- complete\n"

	# 2) Extract contents of downloaded file
	gunzip $src_file_compressed # src_file = DemoData*.csv.gz
	src_file_extracted="${src_file_compressed%.*}" # main_file = DemoData*.csv
	printf "2) Unzip file $src_file_extracted -- complete\n"

	# 3) Remove the header from the file
	tail -n +2 "$src_file_extracted" > "01_rm_header.tmp"
	printf "3) Removed header from file -- complete\n"

	# 4) Convert all text to lower case
	tr '[:upper:]' '[:lower:]' < "01_rm_header.tmp" > "02_conv_lower.tmp"
	printf "4) Converted all text to lowercase -- complete\n"

	# 5) Convert gradelvl to Junior/Senior
	## KEY - 3 = junior, 4 = senior
	awk 'BEGIN {FS = ","; OFS = ","} {
		if ($9 ~ /3/) {$9 = "junior"; print}
		else if ($9 ~ /4/) {$9 = "senior"; print}
		else {print}
	}' < "02_conv_lower.tmp" > "03_conv_gradelvl.tmp"
	printf "5) Converted gradelvl column to junior/senior standard -- complete\n"

	# 5b) Convert gradelvl to Junor/Senior - External Script
	printf "5b) Converted gradelvl column to junior/senior standard -- complete\n"
	gawk -F "," -f "scripts/_conv_gradelvl.awk" "02_conv_lower.tmp" > "03_conv_gradelvl_gawk.tmp"

	# 6) Filter out all records that do not contain junior/senior from the Gradelvl columns
	printf "6) Filter out all records not containing junior/senior -- complete\n"
	gawk -f "scripts/_filter_gradelvl.awk" "03_conv_gradelvl.tmp" > "04_filter_bad_data.tmp"
	
	# 7) Generate a new file Accumulating the total donation amount by gradelvl for junior and senior
	printf "7) Transaction report -- complete\m"
	awk -v _fname=$fname -v _lname=$lname -v _coder="$coder" 'BEGIN {FS=",";OFS=","} {
		arr_gradelvl[$9]+=$11
	}
	END {
		printf "%s\n", "Transactions Report"
		printf "%s %s\n", "Coded by:", _coder
		printf "%s %s %s\n\n", "Report by:", _fname, _lname
		printf "%-10s %s\n", "Grade-lvl", "Transaction-Sum"
		for (id in arr_gradelvl)
			{printf "%-10s %s\n", id, arr_gradelvl[id]}
	}' < "04_filter_bad_data.tmp" > "transaction-rpt"

	# 8) Clean up all temp files
	rm_temps
	exit 0

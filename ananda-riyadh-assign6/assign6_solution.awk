#!/bin/bash/awk

BEGIN {
	FS = " /t " #Input delimited

	#declare variables
	highDen = 0; lowden = 9999999999999; #arbitrary high number
	maxPctWater = 0; minPctWater = 99999999999;


	#Variables formating
	underline = "------------"
	format_header = "%-20s %15s %15s\n"
	format_body = "%-20s %15.6f %15.6f\n"
	format_footer = "%s %s %s %3.6f\n"
	format_footer_pct = "%s %s %s %3.6f\n"
	
	#Header Display
	printf format_header, "County", "Pop/Sq mile ","% Water"
	printf format_header, underline,underline,underline
#body
{
	#Formulas calculated for each record
	recDensity= $2/$4;
	recPctWater = ($3/($3+$4)) * 100;

	


	if (recDensity < lowDen) {lowDen=recDensity; lowDenCounty=$1}
		else if (recDensity > highDen) {highDen=recDensity; highDenCounty=$1}
	if (recPctWater < minPctWater) {minPctWater=recPctWater; minPctWaterCounty=$1}
		else if (recPctWater > maxPctWater) {maxPctWater=recPctWater; maxPctWaterCounty=$1}
}

END {
	print format_footer, "\nHighest Population density" , highDenCounty, "=" , recDensity
	print format_footer, "\nHighest Population density", lowDenCounty, "=", lowDen
	print format_footer_pct, 
	print format_footer_pct,
}	

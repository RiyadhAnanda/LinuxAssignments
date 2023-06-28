#Riyadh Ananda
#Assign 6
#11-06-2022

#!usr/bin/gawk -f
BEGIN {
	#Print Header	
	print "County			Pop/Sq Mile		% Water"
	print "------------		------------		------------"
	#Variable Declarations for highest population, lowest population, highest perc. water, and lowest perc. water
	highpop = 0
	lowpop = 0
	highwat = 0
	lowwat - 0

}
{
	#Using variable popdens to represent the Population Density we will divide population ($3) by landarea ($5) and place into variable popdens
	popdens = $3/$5
	#Using variable perwat to represent the Percent of Water will multiply percent of county thats water by 100 to have it in percent form (ie. 24.5 instead of .245) and then divide it by the sum of water area + land area
	perwat = $4*100/($4 + $5)
}
{
	#Format the Results where we have a 10 symbol limit for county name, 6 places in front as well as behind the decimal for both population density and percent of water
	printf "%-10s  %s	%6.6f		%6.6f\n", $1,$2,popdens,perwat

	if (popdens > highpop)
		{
			highpopname = $1
			highpop = $3/$5
		}
	if ( popdens < lowpop)
		{
			lowpopname = $1
			lowpop = $3/$5
		}
	if (perwat > highwat)
		{
			highwatname = $1
			highwat = perwat
		}
	if (perwat < lowat)
		{
			lowwatname = $1
			lowwat = perwat
		}
}
END {
	print "Highest population density", highpopname, "=",highpop
	print "Lowest population density", lowpopname, "=", lowpop
	print "Highest percentage water", highwatname, "=", highwat
	print "Lowest percentage water", lowwatname, "=", lowwat
}


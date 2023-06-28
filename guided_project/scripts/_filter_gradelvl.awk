#!/user/bin/gawk

BEGIN {
	FS = ","
	OFS = ","
}

{
if ($9 ~ /junior/ || $9 ~ /senior/) {print}
}

# convert gradelvl to Junior/Senior
BEGIN {
	OFS = ","
}

{
if ($9 ~ /3/) {$9 = "junior"; print}
	else if ($9 ~ /4/) {$9 = "senior";print}
		else {print}
}

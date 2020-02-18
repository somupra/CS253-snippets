BEGIN {
	
}

NR != 1 {
	if ($9 in cnt) {
		cnt[$9] = cnt[$9] + 1;
		avg[$9] = $2 + avg[$9];
	} else {
		cnt[$9] = 1;
		avg[$9] = $2;
	}
}
END {
	for (key in cnt) {
		print key
		var = avg[key]/cnt[key];
		print ":"var
	}
}


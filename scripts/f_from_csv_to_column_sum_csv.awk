#!/usr/bin/awk -f

BEGIN {
    FS=","; # Set field separator as comma for CSV input
    OFS=", "; # Set output field separator as comma followed by space
}

{
    for (i = 1; i <= NF; i++) { # Loop through all fields in the row
        sum[i] += $i; # Add current field value to corresponding column sum
    }
    if (NF > maxFields) maxFields = NF; # Update maxFields if current row has more fields
}

END {
    for (i = 1; i <= maxFields; i++) { # Loop through sums and print them
        printf "%s%s", sum[i], (i < maxFields ? OFS : ORS); # Print sum, use OFS or ORS as appropriate
    }
}

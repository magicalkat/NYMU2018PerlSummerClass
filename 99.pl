#!/user/bin/env perl

for($i=1;$i<10;$i++){
    for($j=1;$j<10;$j++){
        printf "%3d X %3d = %6d",$i,$j,$i*$j;
        print "\t";
    }
    print "\n";
}





#!/user/bin/env perl
my @test1=qw(
@HWI-ST491:153:D0B6LACXX:3:1101:1209:2220_1:N:0:
TTGCTATCCTCCTGGGCTgggTTG1GGACCAGCCGGCAGTTGTCTGG
+
CCFFFFFFHHHHFGIJJJJJJCCJJCJCJJJJCJJJJJJJJJJJCJH
);

#Question 1
$seq= $test1[1];
print("The length of the sequence is ",length($seq),"\n");

@seq=split //,$test1[1];
print "The length of the sequence is ",scalar(@seq),"\n";

#Question 2

#@ATGC=("A","C","G","T");
@numATGC=(0,0,0,0);
$num_nonATGC=0;

foreach my $i(0..int(length($seq))-1){
    if($seq[$i] eq "A") {$numATGC[0]+=1;}
    elsif($seq[$i] eq "C") {$numATGC[1]+=1;}
    elsif($seq[$i] eq "G") {$numATGC[2]+=1;}
    elsif($seq[$i] eq "T") {$numATGC[3]+=1;}
    else{
        $num_nonATGC+=1;
    }
}
print "A=",$numATGC[0],"\t","C=",$numATGC[1],"\t";
print "G=",$numATGC[2],"\t","T=",$numATGC[3],"\t","nonATGC=",$num_nonATGC,"\n";

#Qeustion 3
$total=0;
@bases = split //,$test1[3];
foreach my $i(0..int(length($test1[3]))-1){
    $bases[$i]=ord($bases[$i])-64;
    $total+=$bases[$i];
}

#mean
$mean=$total/length($test1[3]);
print "mean=",$mean,"\n";

#max
@sortedBases=sort{$a<=>$b}@bases;
print "Max=",$sortedBases[-1],"\n";
#min
print "Min=",$sortedBases[0],"\n";
#dev
$dev=0;
if(length(@bases) eq 1){return 0;}
else{
    foreach my $i(0..length(@bases)){
        $dev+=($mean-$bases[$i])**2;
    }
    $dev=($dev/(length(@bases)-1))**0.5;
}
print "dev=",$dev;


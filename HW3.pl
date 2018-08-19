#!/user/bin/env perl
my @test1=qw(
@HWI-ST491:153:D0B6LACXX:3:1101:1209:2220_1:N:0:
TTGCTATCCTCCTGGGCTgggTTG1GGACCAGCCGGCAGTTGTCTGG
+
CCFFFFFFHHHHFGIJJJJJJCCJJCJCJJJJCJJJJJJJJJJJCJH
);

@base=split //,$test1[1];
@score=split //,$test1[3];

#Find Minimum value
$min=$score[0];
foreach my $i(@score){
    if ($i lt $min){$min=$i;}
}

#Find Minimum Score Position & Base
my @minP=(),@minB=();
for($i=0;$i<scalar(@score);$i++){
    if($score[$i] eq $min){
        push(@minP,$i);
        push(@minB,$base[$i])
    }
}
print join("\t",@minB),"\n";
print join("\t",@minP);





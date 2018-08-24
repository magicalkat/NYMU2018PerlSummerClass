#!/user/bin/env perl
my @test1=qw(
@HWI-ST491:153:D0B6LACXX:3:1101:1209:2220_1:N:0:
TTGCTATCCTCCTGGGCTgggTTG1GGACCAGCCGGCAGTTGTCTGG
+
CCFFFFFFHHHHFGIJJJJJJCCJJCJCJJJJCJJJJJJJJJJJCJH
);

#Count Base
my %baseCount=();
my @seq=split //,$test1[1];
foreach my $base(@seq){
    $baseCount{$base}++;
}

#Sort by Value
foreach my $k(sort{$baseCount{$a}<=>$baseCount{$b}} keys(%baseCount)){
    print "$k:$baseCount{$k}\n";
}


#!/user/bin/env perl
use strict;
#load and read file
open(FILE,"/home/ensembl/Desktop/3.4.transcripts.txt");
my @raw=();
my @a=();
my %genePosPair=();
my %chr_char=qw/X 23 Y 24 Un 99/;

while(my $row=<FILE>){
    chomp $row;
    @a=split /\s+/,$row;
    $genePosPair{$a[3]}=$a[2];
}
close(FILE);

#create position array
my @position=keys %genePosPair;

#sub function for sorting
sub sortChr{
    my ($chr1,$pos1_1,$pos1_2);
    my ($chr2,$pos2_1,$pos2_2);
    if ($a=~/(\S+):(\d+)-(\d+)$/){
        $chr1=$1; $pos1_1=$2; $pos1_2=$3;
    }
    if ($b=~/(\S+):(\d+)-(\d+)$/){
        $chr2=$1; $pos2_1=$2; $pos2_2=$3;
    }
    if (exists $chr_char{$chr1}){
        $chr1=$chr_char{$chr1};
    }
    if (exists $chr_char{$chr2}){
        $chr2=$chr_char{$chr2};
    }
    return($chr1 <=> $chr2||$pos1_1 <=> $pos2_1||$pos1_2 <=> $pos2_2);
}

my @sorted_pos=sort sortChr @position;
for (my $i=0;$i<scalar(@sorted_pos);$i++){
    print $genePosPair{$sorted_pos[$i]},"\t",$sorted_pos[$i],"\n";
}

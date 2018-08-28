#!/user/bin/env perl

open(FILE,"/home/ensembl/Desktop/4.eif4g2.6.seq.gb");
my $sequence_count=0;
my @sequence_lengths;
my $flag_seq=0,
my $flag_acc=0;
my @publication_dates;
my (@AN,@sequence);
my @authors;


while(my $row=<FILE>){
    chomp $row;
    if ($row=~/LOCUS/){
        $sequence_count++;
        $flag_seq=0;
        if($row=~/(\d+\-\w+\-\d+)$/){push @publication_dates,$1;}
    }
    if ($row=~/source\s+\d+..(\d+)/){push @sequence_lengths,$1;}
    if ($row=~/ACCESSION\s+(NM_\d+)/){
        push @AN,$1;
    }
    if($row=~/AUTHORS\s+([\w\W]+)/){
        $flag_acc=1;
        $authors[$sequence_count-1].=$1;
    }
    if($flag_acc==1){$authors[$sequence_count-1].=$row;}
    if($row=~/TITLE/){$flag_acc=0;}
    
    if($flag_seq==1){
        $sequence[$sequence_count-1].=$row."\n";
    }
    if($row=~/ORIGIN/){$flag_seq=1;}
}
close(FILE);

#Question 1
print "There are $sequence_count sequence in this file.\n\n";

#Question 2
open OUTPUT,">lengths.res";
print OUTPUT join("\n",@sequence_lengths);
close OUTPUT;

#Question 3
my %fasta;
for($i=0;$i<scalar(@sequence);$i++){
    $fasta{$sequence[$i]}=$publication_dates[$i];
}
my %months=qw(
January 1
February 2
March 3
April 4
May 5
June 6
July 7
August 8
September 9
October 10
November 11
December 12
);
sub sort_date{
    my($year1,$month1,$day1);
    my($year2,$month2,$day2);
    if($a=~/(\d+)\-(\w+)\-(\d+)/){
        $year1=$3; $month1=$2; $day1=$1;
    }
    if($b=~/(\d+)\-(\w+)\-(\d+)/){
        $year2=$3; $month2=$2; $day2=$1;
    } 
    foreach my $i(grep(/${month1}+/i,keys %months)){
        $month1=$months{$i};
    }
    foreach my $i(grep(/${month2}+/i,keys %months)){
        $month2=$months{$i};
    }
    return ($year1<=>$year2||$month1<=>$month2||$day1<=>$day2);
}

my %r_fasta=reverse %fasta;
my @v=sort sort_date values %fasta;

open OUTPUT,">sequences.fasta";
foreach $i(@v){
    print OUTPUT $i,"\n",$r_fasta{$i};
}
close OUTPUT;

#Question 4
open OUTPUT,">authors.list";
for($i=0;$i<scalar(@AN);$i++){
    print OUTPUT $AN[$i],"\n",$authors[$i],"\n\n";
}
close OUTPUT;


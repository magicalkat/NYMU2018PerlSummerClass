#!/usr/bin/env perl
use strict;
my @locus=();
my @source=();
my @journal=();
my @journal_sub=();
my %virus_journal_pair;
my @TaiwanVirus=();
my $count=0; 
#Read file
open(FILE,"/home/ensembl/Desktop/4.KT388711.1.gb");
while(my $row=<FILE>){
    chomp $row;
    if ($row=~/SOURCE/){
        push @source,$row;
        $count=1;
    }
    if ($row=~/JOURNAL/){
        push @journal,$row;
        if($row=~/JOURNAL\s+Sub/){
            push @journal_sub,$row;
            
        }
        if ($count==1){
            $virus_journal_pair{$source[-1]}=$row;
            $count=0;
        }
    }
}

close(FILE);

#Read Date in Line "Journal Submitted" and filter the year 1990-1998
my @date=();
foreach my $i(@journal_sub){
    if ($i=~/\((\d+)\-(\D+)\-(\d+)\)/){
        if ($3>=1990&&$3<=1998){
            push @date,"$1-$2-$3";
        };
    }
}

#Hash for month and number exchange
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

#Function of sorting date
sub sort_date{
    my($year1,$month1,$day1);
    my($year2,$month2,$day2);
    if($a=~/(\d+)\-(\D+)\-(\d+)$/){
        $day1=$1; $year1=$3; $month1=$2; 
    }
    if($b=~/(\d+)\-(\D+)\-(\d+)$/){
        $day2=$1; $year2=$3; $month2=$2; 
    } 
    foreach my $i(grep(/${month1}+/i,keys %months)){
        $month1=$months{$i};
    }
    foreach my $i(grep(/${month2}+/i,keys %months)){
        $month2=$months{$i};
    }
    return ($year1<=>$year2||$month1<=>$month2||$day1<=>$day2);
}

#Question 1
my @date_sort=sort sort_date @date;
print "First discover date:",$date_sort[0],"\n";

#Find Virus Discover in Taiwan
foreach my $i(@source){
    if($i=~/Taiwan/i){push @TaiwanVirus,$i;}
}
foreach my $i(@TaiwanVirus){
    print $i,"\n",$virus_journal_pair{$i},"\n";
}


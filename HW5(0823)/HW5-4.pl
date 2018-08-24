#!/usr/bin/env perl
use strict;

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

my @date=qw/
2011-Dec-20
2011-Jan-21
2011-Aug-15
2011-Feb-01
2011-Jul-10
2010-Nov-05
2009-Jan-12
2008-Sept-25
2009-Sep-30
/;

sub sort_date{
    my($year1,$month1,$day1);
    my($year2,$month2,$day2);
    if($a=~/(\d+)\-(\w+)\-(\d+)$/){
        $year1=$1; $month1=$2; $day1=$3;
    }
    if($b=~/(\d+)\-(\w+)\-(\d+)$/){
        $year2=$1; $month2=$2; $day2=$3;
    } 
    foreach my $i(grep(/${month1}+/,keys %months)){
        $month1=$months{$i};
    }
    foreach my $i(grep(/${month2}+/,keys %months)){
        $month2=$months{$i};
    }
    return ($year1<=>$year2||$month1<=>$month2||$day1<=>$day2);
}

print join("\n",sort sort_date @date);

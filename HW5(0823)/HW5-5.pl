#!/usr/bin/env perl

my %test=( 
'3', 'zz1xx', 
'1', 'yyyyyy2xxx',
'2', 'xxaaakk3xxxxxxx', 
'0', 'wwkkk4xxx' ); 

my @value=values %test;
sub sort_by_num{
    my ($num1,$num2);
    if($a=~/(\D+)(\d+)(\D+)/){
        $num1=$2;
    }
    if($b=~/(\D+)(\d+)(\D+)/){
        $num2=$2;
    }
    return $num1<=>$num2;
}
my @value_sort=sort sort_by_num @value;
my %test_r=reverse %test;
foreach my $i(@value_sort){
    print "$test_r{$i} => $i\n"
}

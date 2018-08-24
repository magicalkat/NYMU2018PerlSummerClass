#!/usr/bin/env perl

#Add each line to string 
my $test1="first second, third ,fourth";
my $test2="first, second, third, fourth ";
my $test3="first, second, third, fourth ";
my $test4="first second, third ,fourth ";

#Seperate result from sring 1
my @result1= split(/[,\s]+/,$test1);
print "Seperate result from sring 1 is\n";
print join("\n",@result1);

print"\n\n";

#Seperate result from sring 2
print "Seperate result from sring 2 is\n";
my @result2= split(/[,\s]+/,$test2);
print join("\n",@result2);

print"\n\n";

#Seperate result from sring 3
print "Seperate result from sring 3 is\n";
my @result3= split(/[,\s]+/,$test3);
print join("\n",@result3);

print"\n\n";

#Seperate result from sring 4
print "Seperate result from sring 4 is\n";
my @result4= split(/[,\s]+/,$test4);
print join("\n",@result4);

#So the regular expression of this case is /[,\s]+/
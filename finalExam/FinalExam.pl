#!/user/bin/env perl

open(FILE,"/home/ensembl/Desktop/5.final_exam.txt");
my (@sep_5,@exp_5);
my (@sep_4,@exp_4);
my (@sep_3,@exp_3);
my (@sep_2,@exp_2);
my @all;
my %HN;
my $total=0;


while(my $row=<FILE>){
    if($row=~/virus\s+(.+)/){push @all,$1};
    if($row=~/.+\((.+)\)/){$HN{$1}++};
    $total++;
}
close(FILE);
#print join("\n",@all),"\n";
my $test;
for(my $i=0;$i<scalar @all;$i++){
    if($all[$i]=~/[^\)]$/){$all[$i]=$all[$i]."(unknown)";}
    if($all[$i]=~/\/(\d{2})\s?\(/){$test=$1;$all[$i]=~s/\/.+\(/\/19${test}\(/;}
    if($all[$i]=~/\/(\d{4}).+\(/){$test=$1;$all[$i]=~s/\/.+\(/\/${test}\(/;}
    if(scalar split(/\//,$all[$i])==5){push @sep_5,$all[$i]};
    if(scalar split(/\//,$all[$i])==4){push @sep_4,$all[$i]};
    if(scalar split(/\//,$all[$i])==3){push @sep_3,$all[$i]};
    if(scalar split(/\//,$all[$i])==2){push @sep_2,$all[$i]};    
}
my @ready_Data;
my $y;
for my $i(@sep_5){
    if ($i=~/^(.)\/([a-z]+)\/([A-Z]\w+[-\s]?\w+)\/(\w+)\/(\d{4})\s?\((.+)\)$/){
        push @ready_Data,join "\t",$1,$2,$3,$4,$5,$6;     
        $HN{$6}++;
    }
    elsif($i=~/^(.)\/(.+)\/(\d+)\/(\d+)\/(\d{4})\((.+)\)$/){
        push @ready_Data,join "\t",$1,"human",$2,$3."/".$4,$5,$6;
    }
    else{push @exp_5,$i;}
}

#print join "\n",@exp_5;


for my $i(@sep_2){
    if($i=~/^(.)\/(.+)\((.+)\)$/){
        $HN{$3}++;
        push @ready_Data,join "\t",$1,"unknown","unknown",$2,"1900",$3;
    }else{push @exp_2,$i;}
}

for my $i(@sep_3){
    if($i=~/^(.)\/([A-Z]{3})\/(\d+)\((.+)\)$/){
        push @ready_Data,join "\t",$1,"unknown","unknown",$2,$3,$4;
    }
    elsif($i=~/^(.)\/([a-z]+)\/(\d+)\((.+)\)$/){
        push @ready_Data,join "\t",$1,$2,"unknown","unknown",$3,$4;
    }
    elsif($i=~/^(.)\/([a-z]+)\/(\w+)\((.+)\)$/){
        push @ready_Data,join "\t",$1,$2,$3,"unknown","1900",$4;
    }
    elsif($i=~/^(.)\/(.+)\/(\d+)\((.+)\)$/){
        push @ready_Data,join "\t",$1,"unknown",$2,"unknown",$3,$4;
    }else{push @exp_3,$i;}
}

for my $i(@sep_4){
    if($i=~/^(.)\/([A-Z].+)\/(.+)\/(\d{4})\((.+)\)/){
        push @ready_Data,join "\t",$1,"human",$2,$3,$4,$5;
    }
    elsif($i=~/^(.)\/([a-z]+)\/([A-Z]{3})\/([A-Z].+)\((.+)\)/){
        push @ready_Data,join "\t",$1,$2,$4,$3,"1900",$5;
    }
    elsif($i=~/^(.)\/([a-z]+)\/([A-Z].+)\/(\d{4}\s?)\((.+)\)/){
        push @ready_Data,join "\t",$1,$2,$3,"unknown",$4,$5;
    }
    elsif($i=~/^(.)\/([a-z]+)\/(.+)\/(\d{4}\s?)\((.+)\)/){
        push @ready_Data,join "\t",$1,$2,"unknown",$3,$4,$5;
    }
    else{push @exp_4,$i;}
}

sub sort_year{
    my ($type1,$species1,$place1,$strain1,$year1,$HN1);
    my ($type2,$species2,$place2,$strain2,$year2,$HN2);
    if($a=~/(.)\t(.+)\t(.+)\t(.+)\t(\d{4})\t(.+)/){
        $type1=$1;$species1=$2;$place1=$3;$strain1=$4;$year1=$5;$HN1=$6;
    }
    if($b=~/(.)\t(.+)\t(.+)\t(.+)\t(\d{4})\t(.+)/){
        $type2=$1;$species2=$2;$place2=$3;$strain2=$4;$year2=$5;$HN2=$6;
    }
    return $year1<=>$year2;
}
@ready_Data=sort sort_year @ready_Data;
print join "\n", @ready_Data;

my (%HN_year,%HN_place);
for my $i(reverse @ready_Data){
    if($i=~/\t.+\t(.+)\t.+\t(\d+)\t(H\dN\d)$/){
        $HN_year{$3}=$2;
        $HN_place{$3}=$1;
    }
}

print "\n\nBonus:The list of earlist discover virus sub-type\n";
@HN_key=keys %HN_year;
for $i(@HN_key){
    print $i,"\t",$HN_year{$i},"\t",$HN_place{$i},"\n";
}

#Utility program to find the ranges
#Author : Nitin Bertie Eusebius
#Status : Open Source

#!/usr/bin/perl
use warnings;
use strict;

# For parsing
use XML::Simple;
# For downloading
use LWP::Simple;
# For debug output
use Data::Dumper;
# Turn off output buffering
$|=1;

#This defines the ranges for your calculations. You can add/update as you need
my %ranges = (
    	"0To10"  => 0,
        "10To20"   => 0,
        "30To40" => 0,
	"40To50" => 0,
	"50To60" => 0,
	"60To70" => 0,
	"70To80" => 0,
	"80To90" => 0,
	"90To100" => 0,
	"100To200" => 0,
	"200To300" => 0,
	"300To400" => 0,
	"400To500" => 0,
	"500To600" => 0,
	"600To700" => 0,
	"700To800" => 0,
	"800To900" => 0,
	"900To1000" => 0,
	"1000To2000" => 0,
	"2000To3000" => 0,
	"3000To4000" => 0,
	"4000To5000" => 0,
	"5000To6000" => 0,
	"6000To7000" => 0,
	"7000To8000" => 0,
	"8000To9000" => 0,
	"9000To10000" => 0,
	"10000To11000" => 0,
	"11000To12000" => 0,
	"12000To13000" => 0,
	"13000To14000" => 0,
	"14000To15000" => 0,
	"15000To16000" => 0,
	"16000To17000" => 0,
	"17000To18000" => 0,
	"18000To19000" => 0,
	"19000To20000" => 0,
    );

#This array holds the values of the metrics for your debugging purpose and also main array which will be iterated for calculating the ranges
my @check_value;

#This variable will hold the actual values as it is read from XML node
my $node_value =0;

#These are just temp variables aiding in calculations
my $min;
my $max;

print "nDownloading ....\n";
#You can use the get function below if you want to read directly from url or if you have a local copy just point to that. This example is dealing with local copy
#my $data = get('http://www.costumes4less.com/admin/SearchAndPromoteFeedFiles/CostumeProducts.xml');
my $data = 'C:\Users\neuseb\Dropbox\LingerieProducts.xml';

my $parser = new XML::Simple;
print "nParsing ...\n";

my $records = $parser->XMLin($data);

#This will read the root node for each records
print "Enter the root node of the xml\n";
my $root_node = <>;
chomp($root_node);

#This will help to point to the node whose value you want to read
print "**How many levels deep is your data? Example if under root node \"record\" there are nodeS metrics-->revenue, then enter 2 and enter metrics and then revenue. It will read the value of revenue node**\n";
my $deep_level = <>;
chomp($deep_level);

#This will hold an array of names of nodes that you entered above
my @node_names;

#Based on the level you choose, it will store the node names in order inside the array
for (my $i=1;$i<=$deep_level;$i++){
	
	print "Enter the name of the node\n";
	my $node_name = <>;
	chomp($node_name);
	
	push(@node_names,$node_name);
	
}

#Just for debugging purpose to print
for(my $j=$#node_names;$j>=0;$j--){
	
	print $node_names[$j];
	print "\n";

}


#This is the part which iterates each records and based on the deep level will read the appropiate values
#The deep level values are hard coded knowingly due to some limitations
#Upto 5 levels is supported as any xmls should not go beyond this
#if else ladder will later be upgraded to switch case or given when clause
foreach my $record (@{$records->{$root_node}}) {
		
		if($deep_level == 1)
		{
			$node_value =  $record->{$node_names[0]};
		}
		elsif($deep_level == 2)
		{
			$node_value =  $record->{$node_names[0]}->{$node_names[1]};
		}
		elsif($deep_level == 3)
		{
			$node_value =  $record->{$node_names[0]}->{$node_names[1]}->{$node_names[2]};
		}
		elsif($deep_level == 4)
		{
			$node_value =  $record->{$node_names[0]}->{$node_names[1]}->{$node_names[2]}->{$node_names[3]};
		}
		elsif($deep_level == 5)
		{
			$node_value =  $record->{$node_names[0]}->{$node_names[1]}->{$node_names[2]}->{$node_names[3]}->{$node_names[4]};
		}
	
	#each value is pushed in an array	
	push (@check_value,$node_value);
}

#@check_value = sort @check_value;

#This will sort the array
@check_value = sort {$a <=> $b} @check_value;
#$min = min @check_value;
#$max = max @check_value;

#print "Minimum is $min\n";
#print "Maximum is $max\n";

my $low = 0;
my $high = 0;

#reads each values from the array and then compare from keys of ranges and updates the hash against that range
for my $value (@check_value) {
        
	for(keys %ranges){
		#print("Value of $_ is $ranges{$_}\n");
		$_ =~ m/^(\d+)To(\d+)$/;
		#print "The backreference 1 is $1\n";
		#print "The backreference 1 is $2\n";
		$low = $1;
		$high = $2;
			if($value>=$low && $value<=$high){
	
				$ranges{$_}++;
			}
	}
}

#for my $value (@check_value) {
        #print $value . "\n";
    #}

#for(keys %ranges){
    #print("Value of $_ is $ranges{$_}\n");
#}

#This will print the sorted hash based on the highest to the lowest values
my @sorted = sort { $ranges{$b} <=> $ranges{$a} } keys %ranges;

foreach my $range (@sorted) {
  print "$range => $ranges{$range}\n";
}
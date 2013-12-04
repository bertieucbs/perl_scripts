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

#use Switch;


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
my @check_value;
my $revenue =0;
my $min;
my $max;
print "nDownloading ....\n";
#my $data = get('http://www.costumes4less.com/admin/SearchAndPromoteFeedFiles/CostumeProducts.xml');
#my $data = '/Users/nitineusebius/Dropbox/WeddingSuppliesProducts.xml';
my $data = '/Users/nitineusebius/Dropbox/LingerieProducts.xml';
my $parser = new XML::Simple;

print "nParsing ...\n";
my $records = $parser->XMLin($data);

print "Enter the root node of the xml\n";
my $root_node = <>;
chomp($root_node);

print "How many levels deep is your data?\n";
my $deep_level = <>;
chomp($deep_level);

my @node_values;

for (my $i=1;$i<=$deep_level;$i++){
	
	print "Enter the name of the node\n";
	my $node_name = <>;
	chomp($node_name);
	
	push(@node_values,$node_name);
	
}

for(my $j=$#node_values;$j>=0;$j--){
	
	print $node_values[$j];
	print "\n";

}

foreach my $record (@{$records->{$root_node}}) {
        #$revenue =  $record->{metrics}->{revenue} . "\n";
		#$revenue =  $record->{metrics}->{revenue};
		
		if($deep_level == 1)
		{
			$revenue =  $record->{$node_values[0]};
		}
		elsif($deep_level == 2)
		{
			$revenue =  $record->{$node_values[0]}->{$node_values[1]};
		}
		elsif($deep_level == 3)
		{
			$revenue =  $record->{$node_values[0]}->{$node_values[1]}->{$node_values[2]};
		}
		elsif($deep_level == 4)
		{
			$revenue =  $record->{$node_values[0]}->{$node_values[1]}->{$node_values[2]}->{$node_values[3]};
		}
		elsif($deep_level == 5)
		{
			$revenue =  $record->{$node_values[0]}->{$node_values[1]}->{$node_values[2]}->{$node_values[3]}->{$node_values[4]};
		}
		
	push (@check_value,$revenue);
}

#@check_value = sort @check_value;
@check_value = sort {$a <=> $b} @check_value;
#$min = min @check_value;
#$max = max @check_value;

#print "Minimum is $min\n";
#print "Maximum is $max\n";

my $low = 0;
my $high = 0;

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

 for my $value (@check_value) {
        print $value . "\n";
    }

#for(keys %ranges){
    #print("Value of $_ is $ranges{$_}\n");
#}

my @sorted = sort { $ranges{$b} <=> $ranges{$a} } keys %ranges;

foreach my $range (@sorted) {
  print "$range => $ranges{$range}\n";
}

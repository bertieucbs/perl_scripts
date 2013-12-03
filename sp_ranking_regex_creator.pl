#Utility program to create the regex for search and promote
#Author : Nitin Bertie Eusebius
#Status : Open Source

#main menu call to kick start the programm
main_menu();

#controls the main execution of the programm
sub main_menu{
	
	#asks the users for a choice
	print "How do you want to create the regex?\n";
	print "For legacy way press L or new way press N\n";
	$choice = <>;
	
	#removes the new line
	chomp($choice);
	#lower case the choice for ease
	$choice = lc($choice);

	if($choice eq "l"){
		
		createLegacyRegex();
		start_over_option();
	
	}elsif($choice eq "n"){
		
		createNewRegex();
		start_over_option();
	
	}else{
		
		print "Wrong choice..I am aborting myself\n";
		exit();
	}
}

sub start_over_option{

	print "Do you want to start over? Y/N\n";
	$choice = <>;
	chomp($choice);
	$choice = lc($choice);
	
	if($choice eq "y"){
		
		main_menu();
	
	}elsif($choice eq "n"){
		
		print "Thanks for using this utility program...Good Bye...\n";
	
	}else{
		
		print "Wrong choice..I am aborting myself\n";
		exit();
	}
}


#legacy regex will not consider the decimal values
sub createLegacyRegex{
	
	print "How many max digit you want to create?";
	my $max_digit = <>;
	my $regex_for_digit = "";

	my $temp;
	my @ranking_regex_array;

	for ($i=1;$i<=$max_digit;$i++){

		#special consideration for max digit of 1
		if ($i==1) {
			$temp = "regexp "."[[:digit:]]";
        	print "Enter ranking value for ".$temp." ";
			my $ranking_value = <>;
			if($ranking_value == ""){
				$ranking_value = "0\n";
			}
            push(@ranking_regex_array,$temp." ".$ranking_value);
		}
		else{
			#create the [[:digit:]] for the total digits to be created
			for($j=1;$j<$i;$j++){
				$regex_for_digit = $regex_for_digit."[[:digit:]]";
		}
	
		#now run the programm for 0-9 against the regex string created above
		for($k=1;$k<=9;$k++){
			$temp = "regexp "."$k".$regex_for_digit;
			print "Enter ranking value for ".$temp." ";
        	my $ranking_value = <>;
			
				if($ranking_value == ""){
					
					$ranking_value = "0\n";
				
				}
        		
				push(@ranking_regex_array,$temp." ".$ranking_value);
			}
	}
	
	#reset this value so that correct number of digits can be calculated
	$regex_for_digit = "";
}

print "***Printing the final values of regexes***\n";
print "***You can copy paste this to s&p***\n";
	
	for($i=$#ranking_regex_array;$i>=0;$i--){
		
		print $ranking_regex_array[$i];
	
	}
}


sub createNewRegex{
	
	print "How many max digit you want to create?";
	my $max_digit = <>;
	my $regex_for_digit = "";

	my $temp;
	my @ranking_regex_array;

	for ($i=1;$i<=$max_digit;$i++){

		if ($i==1) {
			$temp = "regexp ^("."[[:digit:]]"."([\\.][[:digit:]]*)*)\$";
        	print "Enter ranking value for ".$temp." ";
			my $ranking_value = <>;
			if($ranking_value == ""){
					
				$ranking_value = "0\n";
			}
            
			push(@ranking_regex_array,$temp." ".$ranking_value);
		}
		else{
		
			for($j=1;$j<$i;$j++){
				$regex_for_digit = $regex_for_digit."[[:digit:]]";
		}

	
		for($k=1;$k<=9;$k++){
			$temp = "regexp ^("."$k".$regex_for_digit."([\\.][[:digit:]]*)*)\$";
			print "Enter ranking value for ".$temp." ";
        	my $ranking_value = <>;
			
			if($ranking_value == ""){
				$ranking_value = "0\n";
			}
        
			push(@ranking_regex_array,$temp." ".$ranking_value);
		}
	}
	$regex_for_digit = "";
}

print "***Printing the final values of regexes***\n";
print "***You can copy paste this to s&p***\n";

for($i=$#ranking_regex_array;$i>=0;$i--){
	print $ranking_regex_array[$i];

}

}


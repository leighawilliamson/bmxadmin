#!/bin/bash
# requires the Bluemix CLI which can be downloaded from http://clis.ng.bluemix.net/ui/home.html
# first argument is Bluemix "endpoint" - the URL for Bluemix

endpoint="https://api.ng.bluemix.net"
org="leighw@us.ibm.com"
defaultspace="dev"
apiKeyFile="apiKey-1.json"
log_file="bmxadmin.log"

inputfile=$1

echo " " > $log_file # initialize & clear the log file
echo "Starting script" 2>&1 | tee -a $log_file
echo " " 2>&1 | tee -a $log_file

if [[ -n "$inputfile" ]]; then
	# a filename was passed in as the argument to the script; use the passed in filename
	echo "inputfile is: " $inputfile 2>&1 | tee -a $log_file
	echo " " 2>&1 | tee -a $log_file
else
	# no filename was passed in; use the default input filename
	inputfile="bmxadmin.csv"
    echo "using default input file: " $inputfile 2>&1 | tee -a $log_file
	echo " " 2>&1 | tee -a $log_file
fi

echo "Setting CLI endpoint..." $endpoint
bx api $endpoint  >> $log_file
echo "  "  2>&1 | tee -a $log_file

echo "Logging in using: " $apiKeyFile 2>&1 | tee -a $log_file
bx login --apikey @$apiKeyFile -s $defaultspace  >> $log_file
echo "  "  2>&1 | tee -a $log_file

echo "List existing users for organization: " $org >> $log_file
bx iam org-users $org >> $log_file
echo "  "  >> $log_file

echo "Reading input file " $inputfile "..." 2>&1 | tee -a $log_file
echo "  "  2>&1 | tee -a $log_file
IFS=","
while read name space role eol
do
		if [ "$name" != "username" ] # skip the csv file header line
		then 
		 	echo "Processing username: $name; space: $space; role: $role" 2>&1 | tee -a $log_file
			echo "executing: bx iam org-user-add $name $org" >> $log_file
			bx iam org-user-add $name $org  >> $log_file

			echo "executing: bx iam space-role-set $name $org $space $role" >> $log_file
			bx iam space-role-set $name $org $space $role >> $log_file
		else
			echo " " >> $log_file
			echo "Skipping cvs file header line" >> $log_file
			echo " " >> $log_file
		fi
done < $inputfile

echo "  "  2>&1 | tee -a $log_file
echo "Resulting list of users for organization: " $org >> $log_file
bx iam org-users $org >> $log_file
echo " " >> $log_file
echo "Script complete!" 2>&1 | tee -a $log_file
echo "Look in $log_file file for details of script execution."
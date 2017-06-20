#!/bin/bash
# requires the Bluemix CLI which can be downloaded from http://clis.ng.bluemix.net/ui/home.html
# first argument is Bluemix "endpoint" - the URL for Bluemix

endpoint="https://api.ng.bluemix.net"
org="leighw@us.ibm.com"
space="dev"
apiKeyFile="apiKey-1.json"
log_file="bmxadmin.log"

inputfile=$1

if [[ -n "$inputfile" ]]; then
	# a filename was passed in as the argument to the script; use the passed in filename
	echo "inputfile is: " $inputfile
else
	# no filename was passed in; use the default input filename
	inputfile="bmxadmin.csv"
    echo "using default input file: " $inputfile
fi

echo "executing: bx api " $endpoint
bx api $endpoint

echo "executing: bx login --apikey " $apiKeyFile
bx login --apikey @$apiKeyFile -s $space

echo "executing: list existing users"
bx iam space-users $org $space

IFS=","
while read f1 f2 f3
do
        echo "username is: $f1"
        echo "space  is  : $f2"
        echo "role   is  : $f3"
		if [ "$f1" != "username" ] # skip the csv file header line
		then 
			echo "executing: bx iam org-user-add $f1 $org"
			bx iam org-user-add $f1 $org
		else
			echo "Skipping cvs file header line"
		fi
done < $inputfile

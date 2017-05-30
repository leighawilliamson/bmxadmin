#!/bin/bash
# requires the Bluemix CLI which can be downloaded from http://clis.ng.bluemix.net/ui/home.html
# first argument is Bluemix "endpoint" - the URL for Bluemix

endpoint="https://api.ng.bluemix.net/"
username="leighw@us.ibm.com"
password="vgy78uhb"
account="e97a8c01ac694e308ef3ad7795bcf65a"
org="leighw@us.ibm.com"
space="dev"
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
#bx api $endpoint

echo "executing: bx login " $username
#bx login -u $username -p $password -o $org -s $space
#bluemix login --apikey @apiKey.json -o $org -s $space


#echo "executing bx target " $org $space
#bx target -o $org -s $space

echo "executing: list existing users"
#bx iam space-users $org $space

IFS=","
while read f1 f2 f3
do
        echo "username is: $f1"
        echo "space  is  : $f2"
        echo "role   is  : $f3"
		if [ "$f1" != "username" ] # skip the csv file header line
		then 
			echo "executing: bx iam org-user-add $f1 $org"
		fi
done < $inputfile

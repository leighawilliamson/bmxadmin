## bmxadmin script

A bash script for batch administration of the Bluemix Cloud Platform.
This script reads in a file containing a list of users and the Bluemix 
space & role desired for each user. This input file needs to be "csv" 
(comma separated value) format, for instance as exported from a spreadsheet.
The script processes each row in the file and ensures that the user is 
added to the organization in Bluemix and is assigned the desired role in the 
designated Bluemix space.

## Dependencies

The script some dependencies that you have to setup before using it:
* the [Bluemix CLI](http://clis.ng.bluemix.net/ui/home.html) must be installed on the system where it runs
* an [APIKey file](https://console.bluemix.net/iam/?env_id=ibm:yp:us-south#/apikeys) is required for the identity under which the script will log in to Bluemix and perform the tasks

## Using the script

The script has some default values baked in, but you will probably want to use 
different values for the name of the csv file, the Bluemix organization targeted, 
the filename of the APIKey file, and so on. All of the default values used by the script 
can be overridden using option flags on the command line:
* -o : override the default Bluemix organization
* -f : override the default input csv filename
* -e : override the default Bluemix API endpoint
* -l : override the default log file name used by this script
* -a : override the default filename for the APIKey file used to login to Bluemix
* -s : override the default Bluemix space where the script initially logs in

## Examples

Run the script specifying an input csv file named "test.csv" and a log output file named "testlog.log"
```
./bmxadmin.sh -l testlog.log -f test.csv
```
Run the script specifying an APIKey file named "myAPIKey.json" and a login space of "dev"
```
./bmxadmin.sh -a myAPIKey.json -s dev
```
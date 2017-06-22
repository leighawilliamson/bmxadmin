# bmxadmin
Bash script for batch administration of the Bluemix Cloud Platform.
This script reads in a file containing a list of users and the space & role desired for each user. The file needs to be "csv" (comma separated value) format, such as exported from a spreadsheet.
The script processes each row in the file and ensures that the user is added to the organization in Bluemix and is assigned the desired role in the designated Bluemix space.

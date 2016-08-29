#!/bin/bash
cd /Users/jean/Documents/Tools/CLI

while read KEY; do 
	echo "Adding $KEY to the project role"
    ./jira.sh --action addProjectRoleActors --project "$KEY" --role "Administrator" --group "Portfolio Group"
    echo "$KEY was added to the project role!"
done < /Users/jean/Documents/Tools/CLI/projectkeys.txt


#for PROJECT in /Users/jean/Documents/Tools/CLI/projectkeys.txt
#do
#	./jira.sh --action addProjectRoleActors --project "$KEY" --role "Administrator" --group "Portfolio Group"
#echo "Seu projeto é : $PROJECT"
#done
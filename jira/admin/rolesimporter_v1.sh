#!/bin/bash
#Navigating into Jira CLI folder
CLI="/Users/jean/Documents/Tools/CLI/"
cd $CLI

while read KEY; do 
	echo "Adding $KEY to the project role"
    ./jira.sh --action addProjectRoleActors --project "$KEY" --role "Administrator" --group "Portfolio Group"
    echo "$KEY was added to the project role!"
done < /Users/jean/Documents/Tools/CLI/projectkeys.txt

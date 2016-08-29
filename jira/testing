#!/bin/bash
read -p "Please type your username: " USERNAME
read -p "Password: " PASSWORD
read -p "Please type the project name: " PROJECT
read -p "Please type the project key: " KEY
read -p "Please type the project description: " DESCRITION
read -p "Please type the project lead users ID: " LEAD

curl -u ${USERNAME}:${PASSWORD} -H "Content-Type: application/json" -X POST -vx -d '{
    \"key\:": \"$KEY\"
    \"name\": \"$PROJECT\"
    \"projectTypeKey\": \"Software\"
    \"projectTemplateKey\": \"com.pyxis.greenhopper.jira:gh-scrum-template\"
    \"description\": \"$DESCRITION\"
    \"lead\": \"$LEAD\"
    \"assigneeType\": \"$PROJECT_LEAD\"
}' "https://jira.wip.gapinc.com/rest/api/2/project"
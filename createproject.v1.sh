#!/bin/bash

#Jira CLI folder path
CLI="/Users/jean/Documents/Tools/CLI/"

#Getting required information to create the project
read -p "Please type the project name: " PROJECT
read -p "Please type the project key: " KEY
read -p "Please type the project description: " DESCRITION
read -p "Please type the project lead users ID: " LEAD

#Navigating into Jira CLI folder
cd $CLI

#Executing Jira CLI command to create project through REST
echo -e "Creating project..."
./jira.sh --action createProject --project "$KEY" --name "$PROJECT" --description "$DESCRITION" --lead "$LEAD" --template "Basic software development" --workflowScheme "GapTech_AgileWorkflowScheme_092015" --issueTypeScheme "GapTech Issue Type Scheme 092015" --issueTypeScreenScheme "GapTech Issue Type Screen Scheme 102015" --permissionScheme "GapTech Permission Scheme 062016" --fieldConfigurationScheme "GapTech Field Configuration Scheme V0" --notificationScheme "Default Notification Scheme (DO NOT CHANGE)"
echo -e "Project created."

#Asking user to select the board setup
PS3="Please select a setup for your project board:  "
select setup in "Scrum Board" "Kanban Board"
do
    case $setup in
        "Scrum Board") 
            ./jira.sh --action createBoard --name "${PROJECT} Scrum" --type "scrum" --project "$KEY"
            break;;

        "Kanban Board")
            ./jira.sh --action createBoard --name "${PROJECT} Kanban" --type "kanban" --project "$KEY"
            break;;
        *)
            echo -e "Invalid option";;
     esac
done

#Cleaning automatic schemes created by REST. This is a known bug and at this point there is no way to create a project without create these schemes.
echo -e "Cleaning project custom schemes..."
{
./jira.sh --action runFromWorkflowSchemeList --regex ".*$KEY.*" --common '-a deleteWorkflowScheme --name "@workflowScheme@"'
./jira.sh --action runFromWorkflowList --regex ".*$KEY.*" --common '-a deleteWorkflow --name "@workflow@"'
./jira.sh --action runFromIssuetypeSchemeList --regex "$KEY:.*" --common '-a deleteIssueTypeScheme --id @schemeId@'
./jira.sh --action runFromIssuetypeScreenSchemeList --regex "$KEY:.*" --common '-a deleteIssueTypeScreenScheme --id @schemeId@' 
./jira.sh --action runFromScreenSchemeList --regex "$KEY:.*" --common '-a deleteScreenScheme --id @schemeId@' 
./jira.sh --action runFromScreenList --regex "$KEY:.*" --common '-a deleteScreen --id @screenId@'
} &> /tmp/project.log
echo -e "\x1B[01;96m Your project is ready to use! \x1B[0m"

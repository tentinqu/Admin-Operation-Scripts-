#!/bin/bash

#This script creates an account om the local system.
#You will be prompted for the account name and the password. 

#Ask for the user's name. 
read -p 'Enter the username to create: ' USER_NAME

#Ask for the real name. 
read -p 'Enter the name of the person who this account is for: ' COMMENT

#Ask for the password.
read -p 'Enter password for this account: ' PASSWORD

#Create the user. 
useradd -c "${COMMENT}" -m ${USER_NAME}

#Set the password for the user. 
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
#Force password chang on first login. 
asswd -e ${USER_NAME}

#!/bin/bash
#This script will create a new user on the local system. 
#You will be prompted to enter the username(login)
#The username, password and host for the account will be displayed. 

#Make sure the script is being executed with superuser privileges. 
if [["${UID}" -ne 0]]
then 
	echo 'Please run with sudo or as root.' 
	exit 1
fi

#Get the username (login) 
read -p 'Enter the username to create: ' USER_NAME

#Get the real name (contents for description field)

read -p 'Enter the name of the person or app that will be using this account: ' COMMENT

#Get the password

read -p 'Enter the password for this account: ' PASSWORD 

#Create the account. 

useradd -c "${COMMENT}" -m ${USER_NAME}

#Check to see if the useradd command succeeded. 
#We don't want to tell the user that the account was created when it wasn't. 

if [[ "${?}" -ne 0 ]]
then 
	echo 'The account has not been created.'
	exit 1
fi

#Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

if [[ "q${?}" -ne 0 ]]
then 
	echo 'The password could not be set.'
exit 1
fi
#Force password change on first login. 
passwd -e ${USER_NAME}

#Display username, password, and the host where the user was created. 
echo

echo 'username: ' 
echo "${USER_NAME}"

echo 
echo 'password: ' 
echo "${PASSWORD}"

echo
echo 'host: ' 
echo "${HOSTNAME}"
exit 0

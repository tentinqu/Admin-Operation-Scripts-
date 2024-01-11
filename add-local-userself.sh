#!/bin/bash 

#Make sure the script is being executed with superuser privileges. 

if [[ "${UID}" -ne 0 ]] 
then 
	echo 'Please execute this script with root privileges.'
	exit 1
fi 

#Get the username 
read -p 'Enter the username: ' USER_NAME 

#Get the real name 
read -p 'Real name for this account''s holder: ' COMMENT   

#Get the password. 

read -p 'Password for this account: ' PASSWORD

useradd -c "${COMMENT}" -m ${USER_NAME}

if [[ ${?} -ne 0 ]]
then 
	echo 'Useradd command did not succeed.'
	exit 1 
fi

#Set the password. 

echo ${PASSWORD} | passwd --stdin ${USER_NAME}

if [[ ${?} -ne 0 ]] 
then 
	echo 'Password command did not succeed. '
	exit 1
fi 

passwd -e ${USER_NAME}

echo 

echo 'username: '
echo ${USER_NAME}

echo 

echo 'password: '
echo ${PASSWORD}

echo 

echo 'hostname: ' 
echo ${HOSTNAME}
exit 0 	

#!/bin/bash

#This script creates an account on the local system.
#You will be prompted for the accout name and password.

#Ask for the username. 
read -p 'Enter the username to create: ' USERNAME


#Ask for the real name. 
read -p 'Enter real name of the person who this account is for: ' REALNAME 

#Ask for the password. 
read -p 'Enter the password to use for the account : ' PASSWORD

#Create the user.
useradd -c "${REALNAME}" -m ${USERNAME}


#Set password for the user. 
echo ${PASSSWORD} | passwd --stdin ${USERNAME}


#Force password reset on the first login. 
passwd -e ${USERNAME}


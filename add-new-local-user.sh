#!/bin/bash
#Make sure the script is being executed with superuser privilege.

if [[ ${UID} -ne 0 ]] 
then 
	echo 'Script not executed with superuser privilege.' 
	exit 1
fi

#If the user doesn't supply at least one argument, then give them help. 

NUMBER_OF_PARAMETERS="${#}"
if [[ NUMBER_OF_PARAMETERS -eq 0 ]] 
then 
	echo 'Please supply atleast one argument' 
	exit 1
fi

#The first parameter is the username, the rest are account comments.  
USER_NAME=${0}
for COMMENTS in "${@}"
do 
	useradd -c "${COMMENTS}" -m ${USER_NAME}
	exit 0
done
 
#Check to see if the useradd command suceeded. 
if [[ ${?} -eq 0 ]] 
then 
	echo 'Command not succeeded. ' 
else
	echo 'Command did not succeed. '
fi

#Generate the password
PASSWORD=$(date +%s%N | sha256sum | head -c48)

#Set the password. 
echo "${USERNAME}:${PASSWORD}"

#Check to see if password command succeeded. 
if [[ ${?} -eq 0 ]] 
then 
	echo 'Command succeeded. ' 
else
	echo 'Command did not suceed. '
fi

#Force password change on the first login. 
passwd -e ${USER_NAME} 


#Display the username, password, and the host where the user was created. 
echo 'username: '
echo "${USER_NAME}"
echo 

echo 'password: ' 
echo "${PASSWORD}"
echo

echo 'host: ' 
echo "${HOST}"
exit 0







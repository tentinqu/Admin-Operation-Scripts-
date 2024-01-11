#!/bin/bash
#This script displays various information to the screen.  
#Display 'Hello'.
echo 'Hello'  
#Assign a value to a variable. 
WORD='script'
#Display the value of the varible.
echo "$WORD"
echo 'edited'
echo '$WORD'
#Single quotes will not allow string to expand. '$WORD' will not work like you expect it to.
#Now combine it with hard-coded text. 
echo "This is a shell $WORD"
#Display the contents of the variable using a different syntax. 
echo "This is a shell ${WORD}"
#For appending text to a variable, the above syntax MUST to be used. 
echo "${WORD}ing is Fun!"
#Create a new variable. 
ENDING='ed'
echo "This is ${WORD}${ENDING}."

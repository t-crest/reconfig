#!/bin/bash          

#
# This bash script extracts the viviado tcl scripts, you need the password to do this.
# Author: Luca Pezzarossa (lpez@dtu.dk)
#

RECONFIG="/home/lpez/t-crest/reconfig"

PROJECT_NAME=$1
BUILD_PATH=$2
PASSWORD=$3
ERROR=0

echo

# Checking arguments sintax
if [[ -z $PROJECT_NAME ]]; then
	echo "'PROJECT_NAME' not set."
	ERROR=1
fi
if [[ $PROJECT_NAME == *['!'@#\$%^\&*()_+'\ ']* ]]; then
	echo "'PROJECT_NAME' contains spaces or a forbidden carachter (!@#\$%^\&*()_+)."
	ERROR=1
fi
if [[ -z $BUILD_PATH ]]; then
	echo "'BUILD_PATH' not set."
	ERROR=1
fi
if [[ ! -d $BUILD_PATH ]]; then
	echo "'BUILD_PATH' is not a valid directory."
	ERROR=1
fi
if [[ -z $PASSWORD ]]; then
	echo "'PASSWORD' not set."
	ERROR=1
fi
if [[ $ERROR = 1 ]]; then
	echo "Usage: $ ./extract_vivado_tcl.sh PROJECT_NAME BUILD_PATH PASSWORD"
	echo
	exit 1 
fi

#Everythig is fine... proceed.
echo "Extracting tcl scipts for the PR project '$PROJECT_NAME'."

#openssl aes-256-cbc -salt -k password -in vivado.tar.gz -out vivado.tar.gz.enc
openssl aes-256-cbc -d -salt -k $PASSWORD -in $RECONFIG/scripts/tcl/vivado.tar.gz.enc -out $BUILD_PATH/$PROJECT_NAME/tcl/vivado.tar.gz 

#tar -czvf vivado.tar.gz vivado
tar -xzf $BUILD_PATH/$PROJECT_NAME/tcl/vivado.tar.gz -C $BUILD_PATH/$PROJECT_NAME/tcl

mv $BUILD_PATH/$PROJECT_NAME/tcl/vivado/* $BUILD_PATH/$PROJECT_NAME/tcl
rm -drf $BUILD_PATH/$PROJECT_NAME/tcl/vivado
rm $BUILD_PATH/$PROJECT_NAME/tcl/vivado.tar.gz

echo

exit 0 






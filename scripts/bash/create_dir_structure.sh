#!/bin/bash          

#
# This bash script generates the folder structure for a reconfig project.
# Author: Luca Pezzarossa (lpez@dtu.dk)
#

PROJECT_NAME=$1
BUILD_PATH=$2
ERROR=0

# This is the list of dirs to be generated.
DIRECTORIES="bitstreams sources checkpoint synth implement tcl"

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
if [[ $ERROR = 1 ]]; then
	echo "Usage: $ ./create_dir_structure.sh PROJECT_NAME BUILD_PATH"
	echo
	exit 1 
fi

#Everythig is fine... proceed.
echo "Directory structure for the PR project '$PROJECT_NAME' into '$BUILD_PATH' generated."

for i in $DIRECTORIES; do
	mkdir -p $BUILD_PATH/$PROJECT_NAME/$i
done

echo

exit 0 






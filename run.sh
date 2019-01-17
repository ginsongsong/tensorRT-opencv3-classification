#!/bin/bash
file="./oxford102.caffemodel"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "$file not found."
	wget https://s3.amazonaws.com/jgoode/oxford102.caffemodel
fi
make
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Model/cv3/lib 
#/bin/trtexec --deploy=deploy_out.prototxt --model=oxford102_new.caffemodel  --test=list.txt --output=accuracy --verbose
/bin/trtexec --deploy=deploy.prototxt --model=oxford102.caffemodel  --test=list.txt --output=prob --label=label.txt # --verbose 


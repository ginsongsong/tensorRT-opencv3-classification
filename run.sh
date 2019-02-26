#!/bin/bash
echo "Catch up the oxford flower classification caffe model"
file="data/oxford102/oxford102.caffemodel"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "$file not found."
	echo "Dowloading oxford model ..."
	wget https://s3.amazonaws.com/jgoode/oxford102.caffemodel data/oxford102/oxford102.caffemodel
fi
make



file="./102flowers.tgz"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "$file not found."
	echo "Downloading flower images ..."
	wget http://www.robots.ox.ac.uk/~vgg/data/flowers/102/102flowers.tgz
	tar  -xvf 102flowers.tgz 
	mv jpg/ flowers/
fi

echo "Creating batches from legacy caffe..."
export PATH=$PATH:/workspace/tensorrt/bin/
mkdir batches
export TENSORRT_INT8_BATCH_DIRECTORY=batches
ln -s $PWD/batches $PWD/oxford102/batches
caffe test  -iterations 1000 -model data/oxford102/test.prototxt -weights data/oxford102/oxford102.caffemodel


export PATH=$PATH:/Model/caffe/build/tools/
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Model/cv3/lib 
#/bin/trtexec --deploy=deploy_out.prototxt --model=oxford102_new.caffemodel  --test=list.txt --output=accuracy --verbose
/bin/trtexec --deploy=data/oxford102/deploy.prototxt --model=data/oxford102/oxford102.caffemodel  --test=listForTest.txt --output=prob --label=label.txt  --int8  --calib=CalibrationTableoxford102 # --verbose 



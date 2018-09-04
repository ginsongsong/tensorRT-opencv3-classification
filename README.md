# TensorRT-image-Classification-using-caffemodel
TensorRT4.0 image classification using caffemodel

Use TensorRT to Calculate the ROC or confusion matrix for diff precision INT8/FP16/FP32 classification.

Preinstall the NVIDIA driver and docker-ce and nvdocker2 in ubuntu16.04

Disable nouveau and update kernel
```
sudo echo "blacklist nouveau" >> /etc/modprob.d/nv-disable-nouveau.conf
sudo echo "options nouveau" >> /etc/modprob.d/nv-disable-nouveau.conf
sudo update-initramfs -u
sudo bash cuda-x.x.run --no-opengl-libs
```
If you are using the CUDA toolkit
```
sudo echo "PATH=$PATH:/usr/local/cuda/bin" >> /etc/bash.bashrc
sudo echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/bin" >> /etc/bash.bashrc
source /etc/bash.bashrc
```
Install the docker-ce version of 17.12.1 in sys
```
sudo bash preinstall.sh
```


Pull the image from nvidia ngc site:
```
docker login nvcr.io
Username: $oauthtoken
Password: <Your Key generating from NGC>
docker pull nvcr.io/nvidia/tensorrt:18.08-py3
``
Login to you container
```
nvidia-docker run -it  -v /home/ginsongsong/Shared/:/Model nvcr.io/nvidia/tensorrt:18.08-py3

```

How to install
```
cd /Model
wget https://github.com/opencv/opencv/archive/3.4.0.zip
CMAKE_INSTALL_PREFIX=/Model/cv3
make -j$(nproc) && make install
#put the source code in /Model dir
cd /Model/trtexec
make
```

You can simply add the test list to giexec.
```
giexec --deploy=deploy.prototxt --model=xx.caffemodel --label=label.txt --test=test.txt

model: IcepV3.caffemodel
deploy: deploy.prototxt
output: loss3/prob
fp16
test: T.txt
Input "data": 1x256x256
Output "loss3/prob": 2x1x1
File:T.txt
Success to decode image
Dim0: 1 Dim1:1024 Dim2:1024
name=data, bindingIndex=0, buffers.size()=2
Memory Read...Image Ok
Average over 1 runs is 8.40288 ms (percentile time is 8.40288).
name=loss3/prob, bindingIndex=1, buffers.size()=2
Result [Normal] is : 0.95331853628158569335937500000000
Result [Abnormal] is : 0.04668147489428520202636718750000

```

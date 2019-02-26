# TensorRT for image classification using OpenCV3
TensorRT4.0 image classification using caffemodel


Updated the dockerfile for proj.

On going: Build Calibration table for Dockerfile..


You can simply add the test list to giexec.
```
root@0e378a07b9d7:/Model/TensorRT-image-Classification-using-caffemodel# bash run.sh
./oxford102.caffemodel found.
Compiling: trtexec.cpp
Linking: /bin/trtexec_debug
Compiling: trtexec.cpp
Linking: /bin/trtexec
# Copy every EXTRA_FILE of this sample to bin dir
cp -f giexec ""/bin/giexec;
deploy: deploy.prototxt
model: oxford102.caffemodel
test: list.txt
output: prob
label: label.txt
Input "data": 3x227x227
Output "prob": 102x1x1
Success to decode image
name=data, bindingIndex=0, buffers.size()=2
Memory Read...Image Ok
name=prob, bindingIndex=1, buffers.size()=2
name=prob, bindingIndex=1, buffers.size()=2
****Starting inference for new img***
Output(barbeton daisy): 0.822625
Output(oxeye daisy): 0.145203
Output(carnation): 0.0164326
Output(sunflower): 0.0081754
Output(sweet william): 0.0019141
*************************************
Success to decode image
name=data, bindingIndex=0, buffers.size()=2
Memory Read...Image Ok
name=prob, bindingIndex=1, buffers.size()=2
name=prob, bindingIndex=1, buffers.size()=2
****Starting inference for new img***
Output(ruby-lipped cattleya): 0.811186
Output(daffodil): 0.0691549
Output(windflower): 0.0266267
Output(azalea): 0.0206504
Output(sweet pea): 0.0115796
*************************************
Success to decode image
name=data, bindingIndex=0, buffers.size()=2
Memory Read...Image Ok
name=prob, bindingIndex=1, buffers.size()=2
name=prob, bindingIndex=1, buffers.size()=2
****Starting inference for new img***
Output(rose): 0.993001
Output(carnation): 0.00335519
Output(passion flower): 0.000826413
Output(foxglove): 0.00056921
Output(moon orchid): 0.000453752
*************************************


```




Pull the image from nvidia ngc site:
```
docker login nvcr.io
Username: $oauthtoken
Password: <Your Key generating from NGC>
docker pull nvcr.io/nvidia/tensorrt:18.08-py3
```
Login to you container
```
git clone https://github.com/ginsongsong/tensorRT-opencv3-classification.git
cd tensorRT-opencv3-classification
docker build -t "ginsongsong/trt_cv3" .
docker run --runtime=nvidia -it --rm -v /root/shared:/Model/shared ginsongsong/trt_cv3
```


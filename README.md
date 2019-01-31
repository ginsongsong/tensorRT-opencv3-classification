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




Install the cuda driver and docker-ce version of 18.09.0.ce in CentOS/RHel
```
#CUDA Driver & toolkit(optional)
echo "blacklist nouveau" >> /etc/modprobe.d/nouveau.conf
echo "options nouveau modeset=0" >> /etc/modprobe.d/nouveau.conf &&dracut -f && reboot
systemctl isolate multi-user.target
wget http://tw.download.nvidia.com/tesla/410.79/NVIDIA-Linux-x86_64-410.79.run -o cuda10_driver.run
bash cuda10_driver.run  --accept-license --no-questions --no-opengl-files --no-drm
#Docker installation
sudo yum-config-manager --add-repo  https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce-18.09.0.ce-1.el7.centos
# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.repo | \
  sudo tee /etc/yum.repos.d/nvidia-container-runtime.repo
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | \
  sudo tee /etc/yum.repos.d/nvidia-docker.repo
# Install nvidia-docker2 and reload the Docker daemon configuration
sudo yum install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
systemctl enable docker  
systemctl start docker
```
Install the cuda driver and the docker-ce version of 18.09.0.ce in ubuntu
```
#Cuda driver and Toolkit(optional)
echo "blacklist nouveau" >> /etc/modprobe.d/nouveau.conf
echo "options nouveau modeset=0" >> /etc/modprobe.d/nouveau.conf && update-initramfs -u &&reboot
/etc/init.d/lightdm stop
wget http://tw.download.nvidia.com/tesla/410.79/NVIDIA-Linux-x86_64-410.79.run -o cuda10_driver.run
bash cuda10_driver.run  --accept-license --no-questions --no-opengl-files --no-drm
#Docker installation
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
sudo apt-get install docker-ce=5:18.09.1~3-0~ubuntu-xenial -y --allow-unauthenticated
# Install nvidia-docker2 and reload the Docker daemon configuration
sudo apt-get install -y nvidia-docker2

sudo mkdir -p /etc/systemd/system/docker.service.d
sudo tee /etc/systemd/system/docker.service.d/override.conf <<EOF
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --host=fd:// --add-runtime=nvidia=/usr/bin/nvidia-container-runtime
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
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
git clone https://ginsongsong/tensorRT-opencv3-classification.git
cd tensorRT-opencv3-classification
docker build -t "ginsongsong/trt_cv3" .
docker run --runtime=nvidia -it --rm -v /root/shared:/Model/shared ginsongsong/trt_cv3
```


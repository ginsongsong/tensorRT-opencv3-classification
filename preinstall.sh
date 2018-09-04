curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-cache policy docker-ce
apt-get install docker-ce=17.12.1~ce-0~ubuntu
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd


#     18.06.1~ce~3-0~ubuntu 
#     18.06.0~ce~3-0~ubuntu    
#     18.03.1~ce-0~ubuntu 
#     18.03.0~ce-0~ubuntu 
#     17.12.1~ce-0~ubuntu 
#     17.12.0~ce-0~ubuntu 
#     17.09.1~ce-0~ubuntu 
#     17.09.0~ce-0~ubuntu 
#     17.06.2~ce-0~ubuntu
#     17.06.1~ce-0~ubuntu  
#     17.06.0~ce-0~ubuntu 
#     17.03.3~ce-0~ubuntu-xenial 
#     17.03.2~ce-0~ubuntu-xenial 
#     17.03.1~ce-0~ubuntu-xenial 
#     17.03.0~ce-0~ubuntu-xenial 
 

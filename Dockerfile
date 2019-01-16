FROM nvcr.io/nvidia/tensorrt:18.12-py3
MAINTAINER ginsongsong <ginsongsong@honghutech.com>

#Build the Calibration for opencv3.
WORKDIR /Model
RUN apt-get update&&apt-get install cmake  -y 
RUN rm -rf pencv-3.4.0 &&  wget https://github.com/opencv/opencv/archive/3.4.0.zip && unzip 3.4.0.zip && \
	cd opencv-3.4.0 && mkdir build && cd build && \
	cmake -DCMAKE_INSTALL_PREFIX=/Model/cv3 -D WITH_CUDA=OFF .. && \
	make -j$(nproc) && make install
RUN cp /workspace/tensorrt/samples/trtexec/giexec ./

#caffe packages
RUN  apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev  \
         libhdf5-serial-dev protobuf-compiler  libgflags-dev libgoogle-glog-dev liblmdb-dev libatlas-base-dev -y && \
     apt-get install --no-install-recommends libboost-all-dev -y &&\
	rm -rf /var/lib/apt/lists/*
	
#Build the Calibration for inference.
WORKDIR /Model
#RUN mkdir cv3
RUN git clone https://github.com/BVLC/caffe.git && cd caffe && \
	git checkout 473f143f9422e7fc66e9590da6b2a1bb88e50b2f && \
	patch -p1 < /workspace/tensorrt/samples/sampleINT8/int8_caffe.patch && \
	mkdir build && cd build && cmake -DCPU_ONLY=ON -DBUILD_python=OFF -DUSE_OPENCV=FALSE -DUSE_CUDNN=OFF .. && \
	make -j$(nproc)  
	
	

CMD ["/bin/bash"]

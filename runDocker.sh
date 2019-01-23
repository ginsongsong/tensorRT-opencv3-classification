PWD=`pwd`
docker run --runtime=nvidia -v $PWD/trt:/Model --rm gin/trt /bin/bash

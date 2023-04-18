#!/usr/bin/env bash

# download the nutstore client
echo "Downloading nutstore client..."
wget https://www.jianguoyun.com/static/exe/installer/nutstore_linux_dist_x64.tar.gz -O ./nutstore_bin.tar.gz
echo "Done."

# unzip the source
echo "Unpacking nutstore client..."
mkdir -p ~/.nutstore/dist && tar zxf ./nutstore_bin.tar.gz -C ~/.nutstore/dist
rm ./nutstore_bin.tar.gz
cp ~/.nutstore/dist/bin/install_core.sh ~/.nutstore/start.sh
echo "Done."

# build the docker image
echo "Building docker image..."
docker build -t nixos-nutstore-env .
echo "Done."

# run the docker image
echo "Running docker image..."
docker run -it \
    --net=host \
	--name nutstore \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /etc/localtime:/etc/localtime:ro \
	-u $(id -u):$(id -g) \
    -v /home/$(whoami)/:/home/nutstore \
    nixos-nutstore-env \
    /home/nutstore/.nutstore/start.sh
echo "Done."

# replace the start.sh
echo "Replacing start.sh..."
docker stop nutstore
echo "#!/bin/bash" > ~/.nutstore/start.sh
echo "sh -c 'exec ~/.nutstore/dist/bin/nutstore-pydaemon.py'" >> ~/.nutstore/start.sh
docker start nutstore
echo "Finished."
	

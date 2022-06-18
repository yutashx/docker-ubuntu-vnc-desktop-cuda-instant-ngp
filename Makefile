PASSWORD=password
user=${USER}

# Out of Container
.PHONY: build_image
build_image:
	echo ${USER}
	bash -c 'cd docker-ubuntu-vnc-desktop; ARCH=amd64 IMAGE=nvidia/cuda:11.1.1-cudnn8-devel-ubuntu20.04 REPO=$${USER}_ubuntu_desktop_vnc_instant_ngp make build'

.PHONY: run_image
run_image:
	docker run --rm --gpus all -p 6080:80 --shm-size=512m \
	-e HTTP_PASSWORD=${PASSWORD} \
	-e USER=${USER} \
	-e PASSWORD=${PASSWORD} \
	-v $(shell pwd):/home/${USER}/workspace \
	-v $(shell pwd)/.bashrc:/home/${USER}/.bashrc \
	${USER}_ubuntu_desktop_vnc_instant_ngp:latest

# Inside of Contianer
.PHONY: install_deps
install_deps:
	sudo apt-get update && sudo apt-get upgrade -y
	sudo apt-get install -y build-essential git vim python3-dev python3-pip libopenexr-dev libxi-dev \
			     libglfw3-dev libglew-dev libomp-dev libxinerama-dev libxcursor-dev
	pip install -U pip
	pip install cmake
	pip install -r ./instant-ngp/requirements.txt 

.PHONY: build_ngp
build_ngp:
	bash -c 'cd instant-ngp; \
		 cmake . -B build; \
		 cmake --build build --config RelWithDebInfo -j $(shell nproc);'

.PHONY: ngp_fox
ngp_fox:
	bash -c 'cd ./instant-ngp; \
	sudo ./build/testbed --scene ./data/nerf/fox;'

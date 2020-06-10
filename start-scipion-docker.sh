#!/bin/bash

NAME="scipion"
HOSTNAME="scipion"

function run_scipion_docker {
    docker run --name $NAME --hostname=$HOSTNAME -e DISPLAY=host.docker.internal:0 -d -p 8080:80 \
    -v `pwd`/extra:/extra \
    -t andrewklau/centos-lamp
}

## start the docker
tput setaf 2; echo "    Creating a docker named: " $NAME; tput sgr0;
run_scipion_docker
tput setaf 2; echo "    Done "; tput sgr0;
## clone the scipion repository inside the docker
tput setaf 2; echo "    Cloning scipion from GIT ..."; tput sgr0;
docker exec -it $NAME git clone https://github.com/I2PC/scipion.git
tput setaf 2; echo "    Done "; tput sgr0;
## install scipion-required packages inside the docker
tput setaf 2; echo "    Installiing missing packages..."; tput sgr0;
docker exec -it $NAME extra/extra-packages.sh
tput setaf 2; echo "    Done"; tput sgr0;
## not needed: already python 2.7,.5
## docker exec -it $NAMe scl enable python27 bash
## copy the "good" scipion config file, run the config, compile it
tput setaf 2; echo "    Running and compiling scipion..."; tput sgr0;
echo ""
tput setaf 1; echo "    WARNING: compilation may take some time "; tput sgr0;
echo ""
tput setaf 2; 
echo "      FIRST config run "
echo "      Creating default config files "; 
tput sgr0;
echo ""
docker exec -it $NAME ./scipion/scipion config
echo ""
tput setaf 2; 
echo ""
echo "      SECOND config run"
echo "      Default config files replaced by docker ones "; 
tput sgr0;
echo ""
docker exec -it $NAME cp extra/scipion.conf /scipion/config/scipion.conf
docker exec -it $NAME ./scipion/scipion config
tput setaf 2; 
echo ""
echo "      STARTING the compilation"
echo ""; 
tput sgr0;
echo ""
docker exec -it $NAME ./scipion/scipion install -j 5
echo "  "
tput setaf 2; echo "    Docker installation complete "; tput sgr0;
echo "   "
tput setaf 1; echo "    Please export docker graphics NOW"; tput sgr0;
echo "  "
echo "  Run ./start-X11-forwarding.sh, then"
echo "  "
echo "  docker exec -t scipion scipion/scipion"
echo "  "
# SCIPION on a OSX docker
WHAT IS THIS : 
A script to install a CentOS 7 docker with scipion. Including:

- CentOS 7 Docker Container , Apache 2.4 (w/ SSL), MariaDB 10.1
- PHP **5.6**, EXIM, ssh, phpMyAdmin, Git, Drush, NodeJS
- Amira license server
- Amira 5.5.0

We start with a clean OSX 10.15.3 (Catalina). 
To download docker for mac, follow the instructions (https://docs.docker.com/docker-for-mac/install/)

## Donwload and start
- Choose a folder where the docker will lay  
- Download the docker: ``git clone https://github.com/jucastil/scipion-mac.git``  
- Go into the newly created folder **scipion-mac**, start the leginon docker.  
``./start-scpion-docker.sh``.    
The dockername is hardcoded and it will always be **scpion**.  
- Follow the messages on the screen. At one point you will be asked:  
Press <enter> if you don't mind to send USAGE data, otherwise press any key followed by <enter>  
Please do not send telemetry :-)
- Onnce everything is done (hopefully without errors) you should get this message:  

 ```javascript
    Docker installation complete 

    Please export docker graphics NOW

    Run ./start-X11-forwarding.sh, then
  
    docker exec -t scipion scipion/scipion
```
- Do as suggested, run the script (you can answer N to the Xeyes).  
You should see the scipion window popping up.

## IMPORTANT remarks

- There is **no data share** mapped inside the container.   
If you want to do that, simply edit **start-scipion-docker.sh** and map the corresponding folder.
- Ther is **no user defined** inside the container. Everything runs as root.
If you don't want to run as root, please add yourself as an user via command line.
NOTE that this docker visible only in the same subnet. 
NOTE that not all the options were tested.

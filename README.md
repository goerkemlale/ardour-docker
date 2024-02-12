# ardour-docker
Docker installation of Ardour build files

This repo is used to create a Docker image for installing the Ardour DAW at https://github.com/Ardour/ardour using

**This Ardour Version: 8.2**

* Docker as a disposable environment
* Debian Sid as a base
* apt-fast as a download hastener

# Installation
* Simply run in Docker
*  **Or** simply run in Docker Compose
* **Or** You can clone this repo + build and edit Dockerfile yourself

## Using Docker
```
docker run goerkemlale/ardour
```

## Using Docker Compose
```
docker compose up
```

## Cloning Repo
```
git clone https://github.com/goerkemlale/ardour-docker.git
$EDITOR ./ardour-docker/Dockerfile
```

# Use
* Run this code to install Ardour in your ***host*** system
```
/opt/docker/ardour/waf install
```
* Run this code to achieve real time priorty
```
echo "@audio   -  rtprio     95" \
echo "@audio   -  memlock    unlimited" \
>> /etc/security/limits.d/audio.conf

sudo groupadd audio
sudo usermod -a -G audio yourUserID
```

# TODO

* Add How To Use 3: Deploying in VM
* Create install script achieving RTP
* Auto update whenever Nightly List website updated

# Structure
## Dockerfile
The dockerfile has 4 stages:
1. **sidaptfast:** Base image for downloading resources fast
2. **ardour-compiler:** Download all compiler related packages as specified in https://nightly.ardour.org/list.php#build_deps with Debian Sid package management
3. **ardour-install:** Download Ardour from Git
4. **ardour-compiled:** Compiled binaries of Ardour

## Docker Compose
Simply added volume information

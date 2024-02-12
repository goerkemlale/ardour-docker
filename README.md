# ardour-docker
**This Ardour Version: 8.2**\
Docker installation of Ardour build files

This repo is used to create a Docker image for installing the Ardour DAW at https://github.com/Ardour/ardour using

* [Docker](https://www.docker.com/) as a compile disposable environment
* [Debian Sid](https://hub.docker.com/layers/library/debian/sid/images/sha256-f3ddf8d7f880d9a41177fc523121fa0be540614f9937e46f0d72ac3e49294d54?context=explore) as a base
* [apt-fast](https://github.com/ilikenwf/apt-fast) as a download hastener
* And many compile suits described in [Ardour: Build Dependencies](https://nightly.ardour.org/list.php#build_deps)

# Installation
* Simply run in Docker with shared volume
* **Or** You can clone this repo + build and edit Dockerfile yourself

## Using Docker
```
docker run goerkemlale/ardour -v /opt/docker/ardour /usr/src/app/ardour
```

## Cloning Repo
```
git clone https://github.com/goerkemlale/ardour-docker.git
$EDITOR ./ardour-docker/Dockerfile
```

# Use
* Run this code anywhere to install Ardour in your ***host*** system
```
sh /opt/docker/ardour/ardour-install.sh
```

# Structure
## Dockerfile
The dockerfile has 4 stages:
1. **sidaptfast:** Base image for downloading resources fast
2. **ardour-compiler:** Download all compiler related packages as specified in https://nightly.ardour.org/list.php#build_deps with Debian Sid package management
3. **ardour-download:** Download Ardour from Git

# TODO

* Add How To Use 3: Deploying in VM
* Create install script achieving RTP
* Auto update script whenever [Nightly List](https://nightly.ardour.org/list.php#build_deps) page updated

#When this Dockerfile could be changed? Examples:
#Change of Debian Repos: depreceated repo: python2
#Change of Debian Repos: updates repo: libglibmm-2.4-dev -> libglibmm-2.5-dev
#Thus Change of ENV lines
#Ardour uses GTK2, therefore "mm" packages are version 2.4. When they upgrade, these packages must be also updated
#If Debian changed to Alpine, Arch, Fedora etc. -> change all repo specific names
#Upgrade of Ardour: Example 8.2 to 8.3

## Base Image
FROM debian:sid AS sidaptfast

ENV DEBIAN_FRONTEND=noninteractive
ENV ARDOURVERSION=8.2
RUN apt update && apt install -y curl aria2 wget git python3
RUN /bin/bash -c "$(curl -sL https://git.io/vokNn)"
RUN rm -rf /var/lib/apt/lists/*

## Build Set
FROM sidaptfast AS ardour-compiler
WORKDIR /usr/src/app/

#Install - Specific versioned packages are on the top
RUN apt-fast update && apt-fast install -y \
libglib2.0-dev \
libglibmm-2.4-dev \
libglibmm-2.68-dev \
libpango1.0-dev \
libpangomm-1.4-dev \
libsigc++-2.0-dev \
libusb-1.0-0-dev \
libcairomm-1.0-dev \
libpixman-1-dev \
autoconf \
automake \
cmake \
curl \
flex \
gettext \
gnome-common \
gobject-introspection \
intltool \
itstool \
libarchive-dev \
libaubio-dev \
libbison-dev \
libboost-dev \
libcairo2-dev \
libcppunit-dev \
libexpat1-dev \
libffi-dev \
libfftw3-dev \
libflac-dev \
libfontconfig1-dev \
libfreetype-dev \
libfribidi-dev \
libharfbuzz-dev \
libiconv-hook-dev \
libjpeg-dev \
liblilv-dev \
liblo-dev \
liblrdf0-dev \
libnss3-dev \
libogg-dev \
libopus-dev \
libpcre3-dev \
libpng-dev \
libraptor2-dev \
librasqal3-dev \
libreadline-dev \
librubberband-dev \
libsamplerate0-dev \
libsdl2-dev \
libsndfile1-dev \
libsord-dev \
libsratom-dev \
libtag1-dev \
libtag1-dev \
libtiff-dev \
libtool \
libvorbis-dev \
libwebsockets-dev \
libxml2-dev \
libxslt1-dev \
lv2-dev \
m4 \
make \
pkg-config \
python3-rdflib \
redland-utils \
serdi \
tar \
util-linux \
vamp-plugin-sdk \
xz-utils \
zlib1g \
&& rm -rf /var/lib/apt/lists/*

## Install latest Ardour files
FROM ardour-compiler AS ardour-download

#Download Git lib 
RUN git clone https://github.com/ardour/ardour.git
WORKDIR /usr/src/app/ardour
RUN git checkout $ARDOURVERSION

## Compile Ardour
RUN ln -s /usr/bin/python3 /usr/bin/python
FROM ardour-download AS ardour-compiled
#COPY ./etc/security/limits.d/audio.conf /etc/security/limits.d/audio.conf
RUN ./waf configure && ./waf
COPY .ardour-install.sh /usr/src/app/ardour/ardour-install.sh

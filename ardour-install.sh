sudo echo "@audio   -  rtprio     95\n"\
"@audio   -  memlock    unlimited"\
>> /etc/security/limits.d/audio.conf

sudo groupadd audio
sudo usermod -a -G audio $(whoami)

/opt/docker/ardour/waf install

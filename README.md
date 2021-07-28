sudo rm /etc/apt/sources.list && sudo cp sources.list /etc/apt/sources.list && sudo chmod +rwx /etc/apt/sources.list && apt-get update && apt-get upgrade && apt dist-upgrade &&
apt-get install linux-headers-4.19.0-17-amd64 build-essential git ghex gcc g++ golang-go wine -y &&
git clone https://github.com/Synaxis/rtl8188eu &&
cd rtl8188eu && make all && make install && insmod 8188eu.ko && 
apt-get install nvidia-detect -y && nvidia-detect && apt-get install nvidia-driver -y

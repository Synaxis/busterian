gtf 1920 1080 60
sudo su
apt-get update && apt-get upgrade -y
apt-get install linux-headers-$(uname -r) build-essential git ghex gcc g++ golang-go wine -y
git clone https://github.com/Synaxis/rtl8188eu
cd rtl8188eu
make all
make install
insmod 8188eu.ko

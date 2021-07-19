sudo su
apt-get update && apt-get upgrade -y
apt-get install linux-headers-$(uname -r) build-essential git ghex -y
git clone https://github.com/Synaxis/rtl8188eu
cd rtl8188eu
make all
sudo make install
sudo insmod 8188eu.ko

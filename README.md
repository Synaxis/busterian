gtf 1920 1080 60
sudo su
apt-get update && apt-get upgrade -y
sudo rm /etc/apt/sources.list && sudo touch /etc/apt/sources.list && sudo chmod +rwx /etc/apt/sources.list && sudo printf "deb http://deb.debian.org/debian buster main contrib non-free
deb-src http://deb.debian.org/debian buster main contrib non-free
deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free
deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free
deb http://deb.debian.org/debian buster-updates main contrib non-free
deb-src http://deb.debian.org/debian buster-updates main contrib non-free" | sudo tee -a /etc/apt/sources.list
apt-get install linux-headers-$(uname -r) build-essential git ghex gcc g++ golang-go wine -y
git clone https://github.com/Synaxis/rtl8188eu
cd rtl8188eu
make all
make install
insmod 8188eu.ko

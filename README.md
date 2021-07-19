gtf 1920 1080 60
sudo su
apt-get update && apt-get upgrade -y
sudo rm /etc/apt/sources.list && sudo touch /etc/apt/sources.list && sudo printf "deb http://ftp.br.debian.org/debian/stable main contrib non-free\ndeb-src http://ftp.br.debian.org/debian/stable main contrib non-free\ndeb http://ftp.br.debian.org/debian/stable-updates main contrib non-free\ndeb-src http://ftp.br.debian.org/debian/stable-updates main contrib non-free\ndeb http://security.debian.org/stable/updates main\ndeb-src http://security.debian.org/stable/updates main\0" | sudo tee -a /etc/apt/sources.list
apt-get install linux-headers-$(uname -r) build-essential git ghex gcc g++ golang-go wine -y
git clone https://github.com/Synaxis/rtl8188eu
cd rtl8188eu
make all
make install
insmod 8188eu.ko

# Installation Script

This script will update the package list, install necessary packages, set Nvidia Prime, add the BellSoft repository, install Java 11, configure bash aliases and functions, adjust the swap file if the system memory is greater than 16GB, and install Python pip and Blueman for Bluetooth management.

## Installation Steps

1. Update and install packages
2. Set Nvidia Prime
3. Add BellSoft repository and install Java
4. Add aliases and functions to bash configuration
5. Adjust swap file if memory is greater than 16GB
6. Install additional Python and Blueman packages

## Script

Copy and paste the following script into your terminal:

```sudo apt-get update && \
sudo apt-get install dkms wireshark node-latest-version git cpu-x simplescreenrecorder psensor golang-go calibre ghex g++ synaptic tlp handbrake pslist gnome-shell-extension-manager gnome-shell-extensions gnome-tweaks libfuse2 apt-transport-https ca-certificates wget dirmngr -y && \
sudo prime-select nvidia && \
wget -qO - https://repos.bell-sw.com/KEY.gpg | sudo apt-key add - && \
echo "deb [arch=amd64] https://repos.bell-sw.com/deb stable main" | sudo tee /etc/apt/sources.list.d/bellsoft.list && \
sudo apt-get update && sudo apt-get install bellsoft-java11-full -y && \
echo -e "alias python='python3'\nalias py='python3'\nfunction remove_venv() { rm -rf venv; }\napt() { if [[ \$1 == 'autoremove' ]]; then echo 'This command is disabled'; else command apt \"\$@\"; fi; }" >> ~/.bashrc && \
source ~/.bashrc && \
sudo sh -c "echo -e \"alias python='python3'\nalias py='python3'\nfunction remove_venv() { rm -rf venv; }\napt() { if [[ \\$1 == 'autoremove' ]]; then echo 'This command is disabled'; else command apt \\\"\\$@\\\"; fi; }\" >> /root/.bashrc && source /root/.bashrc" && \
if [ $(free -g | awk '/^Mem:/{print $2}') -gt 16 ]; then sudo swapoff -a && sudo dd if=/dev/zero of=/swapfile bs=1M count=16384 && sudo mkswap /swapfile && sudo swapon /swapfile && sudo sh -c 'echo \"/swapfile none swap sw 0 0\" >> /etc/fstab'; fi && \
sudo apt install python3-pip -y && \
echo "alias py='python3'" >> ~/.bashrc && \
echo "alias python='python3'" >> ~/.bashrc && \
source ~/.bashrc && \
mkdir -p ~/.config/pip && \
echo -e "[global]\nbreak-system-packages = true" > ~/.config/pip/pip.conf && \
sudo apt install -y blueman blueman-manager```

### Note:
1. Ensure you copy the entire script block.
2. Replace `\```bash` with ```bash (remove the backslashes) for proper markdown formatting in your `README.md`.

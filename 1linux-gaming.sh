#!/bin/bash

# Function to install specific package
install_package() {
    echo "Installing $1..."
    if ! sudo apt-get install -y "$1"; then
        echo "Failed to install $1. Exiting..."
        exit 1
    fi
    echo "$1 installation completed successfully."
}

# Function to run winetricks with specific DLL
install_dll() {
    echo "Installing $1..."
    if ! winetricks "$1"; then
        echo "Failed to install $1. Exiting..."
        exit 1
    fi
    echo "$1 installation completed successfully."
}

# Function to set CPU frequency governor
set_cpu_performance() {
    echo "Setting CPU frequency governor to performance mode..."
    for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
        echo performance | sudo tee $cpu/cpufreq/scaling_governor
    done
    echo "CPU frequency governor set to performance mode!"
}

# Loop menu
while true; do
    echo "1- Install wine and all versions of msvcp"
    echo "2- Run winecfg"
    echo "3- Advanced wine configurations"
    echo "4- Enable wine 32 and wine gecko 32 bit"
    echo "5- Install specific version of msvcp"
    echo "6- Dump current Wine and Lutris configurations"
    echo "7- Set nvidia default gpu"
    echo "8- Run GNOME Mouse Settings script"
    echo "9- Set CPU frequency governor to performance"
    echo "0- Exit"
    echo -n "Choose an option: "
    
    # Read user input
    read -r option

    case $option in
        1)
            install_package wine 
            install_package winetricks
            for version in 60 80 90 100 110 120 140; do
                install_dll "msvcp$version"
            done
        ;;
        2)
            echo "Running winecfg..."
            winecfg
        ;;
        3)
            echo "Running winetricks for advanced wine configurations..."
            winetricks
        ;;
        4)
            echo "Enabling wine 32 bit and wine gecko 32 bit..."
            WINEARCH=win32 WINEPREFIX=~/.wine32 winetricks -q gecko
            echo "Enabled successfully!"
        ;;
        5)
            echo -n "Enter the msvcp version you want to install (ex: 60, 80, 90, etc.): "
            read -r version
            install_dll "msvcp$version"
        ;;
        6)
            echo "Dumping current Wine and Lutris configurations..."
            echo "Wine Configuration:"
            wine regedit /E wine_config.reg
            echo "Wine configuration exported to wine_config.reg."

            echo "Lutris Configuration:"
            lutris -d > lutris_config.log
            echo "Lutris configuration output to lutris_config.log."
        ;;
        7)
            echo "Running prime select nvidia"
	    sudo prime-select nvidia
            echo "Done"
        ;;
        8)
            echo "Running GNOME Mouse Settings script..."
            python3 gnome_mouse_settings.py
        ;;
        9)
            set_cpu_performance
        ;;
        0)
            echo "Exiting..."
            break
        ;;
        *)
            echo "Invalid option. Please try again."
        ;;
    esac

    # Wait for 2 seconds before showing the menu again
    sleep 2
    clear
done

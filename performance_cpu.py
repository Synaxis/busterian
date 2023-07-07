import tkinter as tk
from tkinter import messagebox
import subprocess

def run_command(cmd):
    try:
        return subprocess.check_output(cmd, shell=True)
    except subprocess.CalledProcessError as e:
        return str(e.output)

def install_cpupower():
    output = run_command("which cpupower || sudo apt-get install -y linux-tools-common linux-tools-generic linux-tools-`uname -r`")
    run_command("sudo cpupower frequency-set -g userspace")
    run_command("sudo cpupower frequency-set -f 3800MHz")
    messagebox.showinfo("Success", "cpupower has been installed and configured.")

def disable_intel_pstate():
    run_command("sudo cp /etc/default/grub /etc/default/grub.bak")
    run_command('sudo sed -i \'s/GRUB_CMDLINE_LINUX_DEFAULT="\\(.*\\)"/GRUB_CMDLINE_LINUX_DEFAULT="\\1 intel_pstate=disable"/\' /etc/default/grub')
    run_command("sudo update-grub")
    messagebox.showinfo("Success", "Intel P-state has been disabled. Please reboot your computer.")

root = tk.Tk()
frame = tk.Frame(root)
frame.pack()

button1 = tk.Button(frame, text="Install and configure cpupower", command=install_cpupower)
button1.pack(side=tk.LEFT)

button2 = tk.Button(frame, text="Disable Intel P-state", command=disable_intel_pstate)
button2.pack(side=tk.LEFT)

root.mainloop()

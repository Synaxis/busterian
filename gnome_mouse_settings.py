import tkinter as tk
from tkinter import ttk
import subprocess
import signal
import sys

def set_gnome_mouse_speed(value):
    subprocess.run(['gsettings', 'set', 'org.gnome.desktop.peripherals.mouse', 'speed', str(value)])

def set_gnome_mouse_acceleration(value):
    subprocess.run(['gsettings', 'set', 'org.gnome.desktop.peripherals.mouse', 'accel-profile', str(value)])

def reset_gnome_mouse_settings():
    subprocess.run(['gsettings', 'reset', 'org.gnome.desktop.peripherals.mouse', 'accel-profile'])
    subprocess.run(['gsettings', 'reset', 'org.gnome.desktop.peripherals.mouse', 'speed'])

class MouseSettingsApp(tk.Tk):
    def __init__(self):
        super().__init__()

        self.title("GNOME Mouse Settings")

        self.label = ttk.Label(self, text="Select Mouse Acceleration Profile")
        self.label.pack()

        self.combo = ttk.Combobox(self, values=["default", "flat", "adaptive"])
        self.combo.pack()

        self.button = ttk.Button(self, text="Apply", command=self.apply_settings)
        self.button.pack()

        self.label_speed = ttk.Label(self, text="Set Mouse Pointer Speed")
        self.label_speed.pack()

        self.speed_slider = ttk.Scale(self, from_=-1, to=1, length=400, command=lambda value: self.update_speed(value), orient='horizontal')
        self.speed_slider.set(0)
        self.speed_slider.pack()

        self.speed_value = ttk.Label(self, text="Speed: 0")
        self.speed_value.pack()

        self.button_reset = ttk.Button(self, text="Reset", command=self.reset_settings)
        self.button_reset.pack()

    def apply_settings(self):
        set_gnome_mouse_acceleration(self.combo.get())

    def update_speed(self, value):
        set_gnome_mouse_speed(value)
        self.speed_value['text'] = "Speed: " + str(value)

    def reset_settings(self):
        reset_gnome_mouse_settings()
        self.speed_slider.set(0)
        self.speed_value['text'] = "Speed: 0"
        self.combo.set("default")

    def handle_exit(self, sig, frame):
        print('You pressed Ctrl+C!')
        sys.exit(0)

if __name__ == "__main__":
    app = MouseSettingsApp()
    signal.signal(signal.SIGINT, app.handle_exit)
    app.mainloop()

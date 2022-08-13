import ctypes
import subprocess

# version check :3
output = subprocess.check_output('scoop info komorebi', text=True, shell=True)

update_available = 'Update to' in output

if update_available:
    msg = "A new komorebi version is available!"
    title = "annoying box"
    ctypes.windll.user32.MessageBoxW(0, msg, title, 32)

# https://github.com/LGUG2Z/komorebi#running 
subprocess.run('komorebic start --await-configuration', text=True)

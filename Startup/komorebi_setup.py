import ctypes
import requests
import subprocess

# version check :3
url = 'https://github.com/LGUG2Z/komorebi/releases/latest'
r = requests.get(url)
gh_ver = r.url.split('/')[-1].replace('v','')

output = subprocess.run(['komorebic', '--version'],
            stdout=subprocess.PIPE).stdout.decode('utf-8')
cmd_ver = output.split()[-1]

if cmd_ver != gh_ver:
    ctypes.windll.user32.MessageBoxW(
            0, "A new komorebi version is available!", "annoying box", 32)


# https://github.com/LGUG2Z/komorebi#running 
subprocess.call(['komorebic', 'start'])


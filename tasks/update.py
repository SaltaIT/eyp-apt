#!/usr/bin/python

import sys
import json
from pprint import pprint
import subprocess

params = json.load(sys.stdin)

packages = params['package'].split(',')

result={}

for package in packages:
  result[package]={}
  result[package]['initial']=subprocess.check_output("apt-get --just-print upgrade spotify-client=1:1.0.98.78.gb45d2a6b-10 | grep Inst | awk '{print $2,"=",$4 }' | sed 's/ = (/=/g'", shell=True)
  result[package]['requested']=package
  result[package]['update_process']=subprocess.check_output("DEBIAN_FRONTEND=noninteractive apt-get upgrade "+package+" -y", shell=True)
  result[package]['result']=subprocess.check_output("apt-get --just-print upgrade spotify-client=1:1.0.98.78.gb45d2a6b-10 | grep Inst | awk '{print $2,"=",$4 }' | sed 's/ = (/=/g'", shell=True)

print(json.dumps(result))

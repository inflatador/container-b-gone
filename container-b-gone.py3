#!/usr/bin/env python3
#container-b-gone.py3
# installs/configures swiftly
# then creates a screen session per container
# and deletes them using swiftly commands
# copyright 2020 Brian King
# version: 0.0.1a
# license: Apache

import os
import subprocess
import shutil

def read_containers():
    cntr_file_open = open("containers_list", "r")
    cntr_list = cntr_file_open.readlines()

    for cntr in cntr_list:
            cntr_to_delete = cntr.split('\n')[0]
            print("Spawning delete session for {}".format(cntr))
            os.system('screen -LdmS {} bash -c "swiftly -v --conf="/root/.swiftly.conf" --cache-auth --eventlet --concurrency=100 delete {} --until-empty --recursive" >/dev/null'.format(cntr_to_delete, cntr_to_delete))

def main():

    read_containers()

main()

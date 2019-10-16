#!/bin/bash
#adding swap just in case
fallocate -l 2G  /.SWAPFILE
chmod 0600 /.SWAPFILE
mkswap /.SWAPFILE
swapon /.SWAPFILE
printf "%s\n" "/.SWAPFILE swap swap defaults 0 0" >> /etc/fstab

yum -y install python-pip screen
pip install swiftly eventlet

cat > /root/.swiftly.conf << EOF
[swiftly]
auth_user = $rsUsername
auth_key = $rsApiKey
auth_url = https://identity.api.rackspacecloud.com/v2.0
region = $rsRegion
snet = True
EOF


dd if=/dev/urandom of=/root/garbfile00 bs=1 count=1


for ctr in {0..$numContainers}
  do
    export ctr
    swiftly -v --cache-auth --conf="/root/.swiftly.conf" put testcontainer${ctr}
    for obj in {0..$numObjects}
        do
        export obj
        swiftly -v --cache-auth --conf="/root/.swiftly.conf" put -i /root/garbfile00 testcontainer${ctr}/garbfile${obj} &
        done
  done

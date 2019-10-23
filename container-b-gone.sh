#!/bin/bash
#container-b-gone.sh
# installs/configures swiftly
# then creates a screen session per container
# and deletes them using swiftly commands
# copyright 2019 Brian King
# version: 0.0.2a
# license: Apache

#adding swap just in case
fallocate -l 4G  /.SWAPFILE
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

cntrs_to_delete="$containersToDelete"

IFS=","

containers_array=( ${cntrs_to_delete} )

printf "%s\n" "${containers_array[@]}" >> /root/containers_list

for cntr in ${containers_array[@]}; do
  screen -LdmS $cntr bash -c "swiftly -v --conf="/root/.swiftly.conf" --cache-auth --eventlet --concurrency=100 delete $cntr --until-empty --recursive; exec bash"; done

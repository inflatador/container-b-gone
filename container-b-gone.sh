#!/bin/bash
#container-b-gone.sh
# installs/configures swiftly
# then creates a screen session per container
# and deletes them using swiftly commands
# copyright 2019 Brian King
# version: 0.0.1a
# license: Apache

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
#
# cat > /root/container_list << EOF
# $containers
# EOF
    # for vers in ${supported_ubuntu_vers[@]}; do
    # if [ ${os_majorver} == "${vers}" ]
    #     then
    #     supported=true
    #
    # fi; done

cntrs_to_delete="$containers"

IFS=","

containers_array=( ${cntrs_to_delete} )

printf "%s\n" "array slice ${containers_array[1]}" >> /root/containers_list

# for cntr in ${containers_array[@]}; do
#     swiftly -v --cache-auth --eventlet --concurrency=100 delete $cntr --until-empty --recursive; done

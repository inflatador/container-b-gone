#!/bin/bash

dd if=/dev/urandom of=/root/garbfile00 bs=1 count=1

for n in {1..1000}
    do
    (swiftly put garbtest4$n) &
    done

for y in {0..10000}
    do
    export y
    swiftly -v --cache-auth --eventlet --concurrency=100 --conf="/root/.swiftly.conf" put -i garbdir00/garbfile00 garbest04/garbfile0$1
    done

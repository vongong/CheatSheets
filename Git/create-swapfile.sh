#!/bin/bash

if ! swapon --show | grep -q "/"; then
    echo "Swap is not enabled; Creating Swapfile."
    fallocate -l 1G /swapfile
    chmod 600 /swapfile
    ls -lh /swapfile
    mkswap /swapfile
    swapon /swapfile
    swapon --show
    free -h
    cp /etc/fstab /etc/fstab.bak    
    echo "/swapfile none swap sw 0 0" | tee -a /etc/fstab    
    cp /etc/sysctl.conf /etc/sysctl.bak    
    echo "vm.swappiness=10" | tee -a /etc/sysctl.conf    
    echo "vm.vfs_cache_pressure=50" | tee -a /etc/sysctl.conf
else
    echo "Swap is enabled."
fi

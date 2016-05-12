#!/bin/bash
sudo apt-get autoremove --purge
dpkg --list | grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge
sudo apt-get clean

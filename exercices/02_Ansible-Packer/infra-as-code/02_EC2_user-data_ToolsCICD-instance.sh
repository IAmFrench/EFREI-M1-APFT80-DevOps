#!/bin/bash
apt update
apt install software-properties-common --yes
apt-add-repository --update ppa:ansible/ansible --yes
apt install ansible --yes
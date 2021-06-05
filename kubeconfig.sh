#!/bin/bash
set -e
server=$(terraform output server | jq -r)
ssh -i .key/kaas.pem centos@$server "sudo cp -f /etc/kubernetes/admin.conf .; sudo chown $(id -u):$(id -g) admin.conf"
scp -i .key/kaas.pem centos@$server:admin.conf .key/
ssh -i .key/kaas.pem centos@$server rm admin.conf

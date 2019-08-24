#!/bin/bash
echo ip_address = \"$(kubectl get ingress app -o=jsonpath='{.status.loadBalancer.ingress[].ip}')\" > ip_address.auto.tfvars

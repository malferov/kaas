#/bin/bash
kubectl apply -f app.yml
kubectl apply -f service.yml
kubectl apply -f secret.yml
kubectl apply -f ingress.yml

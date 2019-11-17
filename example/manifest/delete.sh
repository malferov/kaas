#/bin/bash
kubectl delete -f ingress.yml
kubectl delete -f secret.yml
kubectl delete -f service.yml
kubectl delete -f app.yml

#/bin/bash
img=malferov/felix:4
docker build -t $img .
docker login
docker push $img

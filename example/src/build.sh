#/bin/bash
img=malferov/vk-felix:4
docker build -t $img .
docker login
docker push $img

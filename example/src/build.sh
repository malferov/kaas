#/bin/bash
img=malferov/vk-felix:3
docker build -t $img .
docker login
docker push $img

#!/bin/bash
DECK=docker-basics
if [ ! "x" == "x`docker ps -a | grep $DECK`" ]; then
  docker rm $DECK
fi

mkdir -p build
PWD=`pwd`
mkdir -p build/md
cp slides.md build/md
docker run -ti -d --name $DECK -v $PWD/images:/opt/presentation/images -v  $PWD/build/md:/opt/presentation/lib/md -v $PWD/build:/build -p 8000:8000 rossbachp/presentation /bin/bash -c "grunt package && mv reveal-js-presentation.zip /build/$DECK.zip"
cd build
mkdir -p $DECK
cd $DECK
#you must have zip installed - apt-get install -y zip
unzip ../$DECK.zip
cd ..
tar czf slidefire.tar.gz $DECK
rm -rf build/$DECK.zip
rm -rf build/$DECK
rm -rf build/md

cat <<EOT >> Dockerfile
FROM rossbachp/slidefire
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>
EOT
docker build -t=rossbachp/$DECK .

docker stop $DECK
docker rm $DECK

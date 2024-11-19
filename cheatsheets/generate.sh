#!/bin/bash

docker run --rm  -it --platform=linux/amd64 --volume $PWD:/tmp --name cheatset jonasbn/cheatset:latest generate keychron.rb
docker run --rm  -it --platform=linux/amd64 --volume $PWD:/tmp --name cheatset jonasbn/cheatset:latest generate shortcuts.rb

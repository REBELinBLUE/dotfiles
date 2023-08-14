#!/bin/bash

docker run --rm  -it --volume $PWD:/tmp --name cheatset jonasbn/cheatset:latest generate keychron.rb

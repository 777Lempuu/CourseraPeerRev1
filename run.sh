#!/bin/bash
make clean && make
mkdir -p output
./main data/textures output/

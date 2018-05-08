---
title: "Install ROOT on Cori"
date: 2018-05-07
permalink: /posts/2018/05/06/
tags:
  - ROOT
  - Cori
  - HPC
---
Version: v6-04-16, with special patches used in ATLAS.
Source files are downloaded from https://gitlab.cern.ch/turra/root/tree/hsg7-v6-04-16
Untar this file to the directory of _src_.
```bash
mkdir v6-04-16_hsg7
module load gcc/4.9.3
module load cmake/3.8.2
cmake -Droofit=ON -D minuit2=ON  -D CMAKE_C_COMPILER=/opt/gcc/4.9.3/bin/gcc -D CMAKE_CXX_COMPILER=/opt/gcc/4.9.3/bin/g++ ../src/
cmake --build . -- -j8
```

#!/bin/bash
if ! [ -e caffe-dilation ];
then
    git clone https://github.com/fyu/caffe-dilation
fi

if ! [ -e dilation ]; 
then
    git clone https://github.com/fyu/dilation
fi

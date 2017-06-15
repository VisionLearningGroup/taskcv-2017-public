#!/bin/bash
CAFFE_DILATION_BUILD="caffe-dilation/build_master"
DILATION='dilation'
DATASETS='/home/jhoffman/data/datasets'

export PYTHONPATH="${CAFFE_DILATION_BUILD}/python"
echo "Dilation = ${DILATION}"

GPU="1"

MODEL_NAME="caffe_nets/dilation10_gta5_frontend"
WEIGHTS="${MODEL_NAME}.caffemodel"
OUT_DIR=${MODEL_NAME}/val
val_img="${DATASETS}/CityScapes/val_image.txt"
val_label="${DATASETS}/CityScapes/val_train.txt"
echo "Running prediction for ${MODEL_NAME} on GPU $GPU"
echo $DILATION

mkdir -p ${OUT_DIR}
python ${DILATION}/test.py frontend \
--work_dir output \
--sub_dir ${OUT_DIR} \
--image_list ${val_img} \
--mean 75.0892959843 85.0149892578 75.2051479044  \
--weights $WEIGHTS \
--classes 19 \
--input_size 1396 \
--feat_layer_name fc7 \
--up \
--gpu ${GPU} 


# Run mIoU Computation
pred_dir=output/results/caffe_nets/dilation10_gta5_frontend/val/frontend_vgg
gt_dir=${DATASETS}/CityScapes/gtFine/val
python eval.py $gt_dir $pred_dir

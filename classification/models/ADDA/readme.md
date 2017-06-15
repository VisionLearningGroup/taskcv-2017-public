# Adversarial Discriminative Domain Adaptation

This code is a fork from this repo: https://github.com/erictzeng/adda/

## Getting started

This code requires Python 3, and is implemented in Tensorflow.

First download data as described in the `classification_track` root. You should also change `ROOT_DIR` to your data paths in `data/vda2017.py`.

Hopefully things should be fairly easy to run out of the box:

    pip install -r requirements.txt
    mkdir data snapshot
    export PYTHONPATH="$PWD:$PYTHONPATH"
    
After that you can run experiments:

	# check that your setup is working
    scripts/svhn-mnist.sh

    # LeNet challenge baseline
	/scripts/synth-coco.sh

    # VGG16 challenge baseline
	/scripts/synth-coco-vgg16.sh


The provided script does the following things:

- Train a base LeNet\VGG16 model on Synthetic data
- Use ADDA to adapt the base model to COCO
- Run an evaluation on COCO using the source-only model
- Run an evaluation on COCO using the ADDA model

## Areas of interest

- Check `/scripts/synth-coco-vgg16.sh` and `/scripts/synth-coco-vgg16.sh` for hyperparameters.
- The LeNet and VGG model definitions is in `adda/models/lenet.py` and `adda/models/vgg16.py`.
- The model is annotated with data preprocessing info, which is used in the `preprocessing` function in `adda/models/model.py`.
- The main ADDA logic happens in `tools/train_adda.py`.
- The adversarial discriminator model definition is in `adda/adversary.py`.

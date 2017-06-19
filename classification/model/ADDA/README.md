# Adversarial Discriminative Domain Adaptation

This code is a fork from this repo: https://github.com/erictzeng/adda/

Note that we did not tune parameters of ADDA adaptation for synthetic-to-real adaptation, so the source model performance is relatively high when one uses VGG16 pre-trained on Imagenet, but adaptation performance might quite low out of the box. You are encouraged to edit hyper parameters and the code to improve adaptation performance.

## Getting started

This code requires Python 3, and is implemented in Tensorflow.

First download data as described in the `classification_track` root. You should also update the `ROOT_DIR` variable in shell scripts below.

Hopefully, things should be fairly easy to run out of the box:

    pip install -r requirements.txt
    mkdir data snapshot
    export PYTHONPATH="$PWD:$PYTHONPATH"
    
After that you can test your setup:

    scripts/svhn-mnist.sh
    
And run actual experiments on our data.
    
    scripts/synth-coco.sh
    scripts/synth-coco-vgg16.sh
    
For any network (`vgg16` in our example) you can use `--weights` option to pass a checkpoint file with imagenet pre-trained weights. There are some other options with comments listed in `scripts/synth-coco-vgg.sh`. We used `VGG16` weights from [`tensorflow/models/slim`](https://github.com/tensorflow/models/tree/master/slim#pre-trained-models).

Each of the provided scripts does the following:

- Trains a base LeNet\VGG16 model on Synthetic data
- Use ADDA to adapt the base model to COCO
- Run an evaluation on COCO using the source-only model
- Run an evaluation on COCO using the ADDA model

## Areas of interest

- Check `scripts/synth-coco[-vgg16].sh` for hyperparameters and general pipeline of the experiment; you can also change updated weights and initialization using `weights_*` and `train_scope` arguments.
- The LeNet and VGG model definitions are in `adda/models/lenet.py` and `adda/models/vgg16.py`.
- The model is annotated with data preprocessing info, which is used in the `preprocessing` function in `adda/models/model.py`.
- The main ADDA logic happens in `tools/train_adda.py`.
- The adversarial discriminator model definition is in `adda/adversary.py`.

## Evaluation

The prediction outputs are written to the `predictions` folder. Please follow [evaluation instructions](/classification#evaluation).

# Introduction
Deep adaptation network is proposed by [Learning Transferable Features with Deep Adaptation Networks](https://arxiv.org/pdf/1502.02791.pdf). Please cite the original paper if you use any material (code, algorithm, etc) provided by the authors. For this baseline model, we only provide code for Caffe version.

# Run the baseline

0. Get the modified Caffe code by cloning the repository: `git clone https://github.com/thuml/transfer-caffe.git`. Let's call the palce where you installed caffe `$CAFFE_ROOT`.
1. **Install DAN** (See [Caffe installation Instructions](http://caffe.berkeleyvision.org/installation.html) for help).
3. **Data Preparation**: To run the model, you should prepare `train.txt`, `test.txt`, 

This is a caffe repository for transfer learning. We fork the repository with version ID `29cdee7` from [Caffe](https://github.com/BVLC/caffe) and make our modifications. The main modifications are listed as follow:

- Add `mmd layer` described in paper "Learning Transferable Features with Deep Adaptation Networks".
- Add `entropy layer` and `outerproduct layer` described in paper "Unsupervised Domain Adaptation with Residual Transfer Networks".
- Copy `grl layer` and `messenger.hpp` from repository [Caffe](https://github.com/ddtm/caffe/tree/grl).
- Emit `SOLVER_ITER_CHANGE` message in `solver.cpp` when `iter_` changes.

Data Preparation
---------------
In `data/office/*.txt`, we give the lists of three domains in [Office](https://cs.stanford.edu/~jhoffman/domainadapt/#datasets_code) dataset.

Training Model
---------------

In `models/DAN/amazon_to_webcam`, we give an example model based on Alexnet to show how to transfer from `amazon` to `webcam`. In this model, we insert mmd layers after fc7 and fc8 individually.

The [bvlc\_reference\_caffenet](http://dl.caffe.berkeleyvision.org/bvlc_reference_caffenet.caffemodel) is used as the pre-trained model. If the Office dataset and pre-trained caffemodel is prepared, the example can be run with the following command:
```
"./build/tools/caffe train -solver models/DAN/amazon_to_webcam/solver.prototxt -weights models/bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel"
```

Parameter Tuning
---------------
In mmd-layer, parameter `loss_weight` can be tuned to give mmd loss different weights.


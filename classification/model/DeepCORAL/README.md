## Introduction
Deep CORAL is proposed by [Deep CORAL: Correlation Alignment for Deep Domain Adaptation](https://arxiv.org/abs/1607.01719). Please cite the original paper if you use any material (code, algorithm, etc) provided by the authors. For this baseline model, we only provide code for Caffe version.

## Run the baseline

1. Get the modified Caffe code by cloning the repository: `git clone https://github.com/baochens/Caffe-Deep_CORAL.git`. 

2. **Install Deep CORAL** (See [Caffe installation Instructions](http://caffe.berkeleyvision.org/installation.html) for help). Let's call the place where you installed caffe `$CAFFE_ROOT`.

3. **Data Preparation**: To run the model, you should prepare `train.txt`, `test.txt`. These files can be generated from `../../data/train/image_list.txt` and `../../data/validation/image_list.txt` by replacing the relative path to absolute path. **Note**: `train.txt` and `test.txt` should be placed to the same directory with `deepcoral_train_val_visda17.prototxt`

4. **Training Model**. We provide `deepcoral_train_val_visda17.prototxt` as the network architecture, you can visualize it with [ethereon](http://ethereon.github.io/netscope/quickstart.html). The [bvlc\_reference\_caffenet.caffemodel](http://dl.caffe.berkeleyvision.org/bvlc_reference_caffenet.caffemodel) is used as the pre-trained model. If the `train.prototxt`, `test.prototxt` and pre-trained caffemodel are prepared, the model can be run with the following command:

```
"$CAFFE_ROOT/build/tools/caffe train -solver solver.prototxt -weights /path/to/your/pre-trained/model/bvlc_reference_caffenet.caffemodel -gpu GPU_ID 2>&1 | tee deepcoral_result.log"
```

5. **Testing**. Modify the `test_file_path`,`deploy_file_path` and `weight_path` in `../../exp_pred.m`, and run `>> exp_pred()`. The function will generate a text file containing all the  in `../../result/` with the most recent timestampe.

6. **Calculate Mean Accuracy**. Run `>> exp_eval()`.

## Baseline Result
 aero|	bicycle|	bus|	car|	hrs|	knf|	mtrcycle|	prsn|	plnt|	sktbd|	trn|	trck|	mean accuracy
  :---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:
76.5	|31.8	|60.2	|35.3	|45.7	|48.4|	55	|28.9	|56.4	|28.2	|60.9	|19.1|	45.53 

## Data

First of all, you probably need some data. You should be able to get it with 
  
  
    cd your-data-location
    wget http://csr.bu.edu/ftp/visda17/clf/train.tar
    tar xvf train.tar
    wget http://csr.bu.edu/ftp/visda17/clf/validation.tar
    tar xvf validation.tar
  

Images are structured in folders as 

- `synth-v3/{category}/{object_id}/{object_id}_{cam_yaw}_{light_yaw}_{cam_pitch}.png` for training synthetic data and
- `valid/{category}/{object_id}.png`

with a single `.txt` file in the root or each dataset that lists all images and corresponding labels. Folder names won't be avaliable on test time :).

## Code

We have several base models with data readers in `/models` folder. 

- "Adversarial Discriminative Domain Adaptation" (ADDA) [`paper`](https://arxiv.org/abs/1702.05464); Python 3 + Tensorflow: [`our code`]() [`original code`](https://github.com/erictzeng/adda/)
- "Learning Transferable Features with Deep Adaptation Networks" (DAN) [`paper`](https://arxiv.org/pdf/1502.02791.pdf) Caffe: [`our code`]()

Please, look at [challange rules]() to make sure you are doing the right thing.

## Evaluation

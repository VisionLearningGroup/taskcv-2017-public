First of all, you probably need some data. You should be able to get it with 
  
  cd your-folder-for-data
  wget http://csr.bu.edu/ftp/visda17/synthetic-v3.tar
  tar xvf synthetic-v3.tar
  wget http://csr.bu.edu/ftp/visda17/validation.tar
  tar xvf synthetic-v3.tar
  
Images are structured in folders with a single file that lists all images and . Just in case, you should not use folder names because they won't be avaliable on test time.
  
We have several base models with data readers in `/models` folder. They are 

- "Adversarial Discriminative Domain Adaptation" (ADDA) [`paper`](https://arxiv.org/abs/1702.05464); Python 3 + Tensorflow: [`our code`]() [`original code`](https://github.com/erictzeng/adda/)
- "Learning Transferable Features with Deep Adaptation Networks" (DAN) [`paper`](https://arxiv.org/pdf/1502.02791.pdf) Caffe: [`our code`]()

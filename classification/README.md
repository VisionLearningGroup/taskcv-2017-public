## Downloading Data

First of all, you probably need some data. You should be able to get it with 
    
    $ cd your-data-location
    
    # ..G
    $ wget http://csr.bu.edu/ftp/visda17/clf/train.tar
    $ tar xvf train.tar
    
    # 2.8G
    $ wget http://csr.bu.edu/ftp/visda17/clf/validation.tar
    $ tar xvf validation.tar  
    
    # if link[s] do not work or download speed is low, you can use the backup google drive
    # ...

Images are structured in folders as 

- `synth-v3/{category}/{object_id}/{object_id}_{cam_yaw}_{light_yaw}_{cam_pitch}.png` for training synthetic data and
- `coco/{category}/{object_id}.png` or valiation

with a single `.txt` file in the root or each dataset that lists all images and corresponding labels. Folder names won't be avaliable upon test time :).

## Code

We have several base models with data readers in [`/models`](models) folder. Each model has a short README on how to run it.

- "Adversarial Discriminative Domain Adaptation" (ADDA) with LeNet and VGG16 in Tensorflow [`arxiv`](https://arxiv.org/abs/1702.05464)
- "Learning Transferable Features with Deep Adaptation Networks" (DAN) with Alexnet in Caffe [`arxiv`](https://arxiv.org/pdf/1502.02791)
- "Deep CORAL: Correlation Alignment for Deep Domain Adaptation" with Alexnet in Caffe [`arxiv`](https://arxiv.org/abs/1607.01719)

Please refer to the [challenge rules]() for specific guidelines your method must follow.

## Evaluation

The models here generate output files. The script used for our evaluation server is shared with you here so that you may evaluate your results locally. However, you are encouraged to upload your results to the evaluation server to compare your performance with that of other participants. 


In both the testing and validation phases, you will be provided with a text file that contains a list of image ID annotations in a random order. Your result should be in the format of two text files: one titled “source_results.txt” and the other “adaptation_results.txt”. The source file should contain your results with no adaptation performed, while the adaptation file contains your results using adaptation methods. Both files must be included for your submission to be scored. The format of both files are identical and each text file should contain corresponding category ID for each image from the provided annotations file. Your reported results should follow the same order as the annotations and each classification should be on a new line. All images must be classified for the submission to be scored. 


Instructions for running local evaluation on validation dataset:

- Generate "source_results.txt" and "adaptation_results.txt".
- Place these files in a directory along with the ground truth labels "ground_truth.txt" and the evaluation script.
- Run evaluation.

Instructions for submitting to the evaluation server:

- Generate "source_results.txt" and "adaptation_results.txt".
- Additionally, generate a file called "method_pretrained.txt" that contains a 0 if your method is not pretrained on ImageNet, and a 1 if it is pretrained on ImageNet. This file must be included in order for your submission to be evaluated.
- Place these files into a zip file named [team_name]_submission
- Submit to CodaLab evaluation server following instructions below.

To submit your zipped result file to the VisDA Classification challenge click on the “Participate” tab. Select the phase (validation or testing). Select “Submit / View Results, fill in the required fields and click “Submit”. A pop-up will prompt you to select the results zip file for upload. After the file is uploaded the evaluation server will begin processing. This might take some time. To view the status of your submission please select “Refresh Status”. If the status of your submission is “Failed” please check your file is named correctly and has the right format. You may refer to the scoring output and error logs for more details.

After you submit your results to the evaluation server, you can control whether your results are publicly posted to the CodaLab leaderboard. To toggle the public visibility of your results please select either “post to leaderboard” or “remove from leaderboard.” 

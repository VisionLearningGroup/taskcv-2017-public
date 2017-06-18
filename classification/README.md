## Downloading Data

First of all, you probably need some data. You should be able to get it with 
    
    cd ./data
    wget http://csr.bu.edu/ftp/visda17/clf/train.tar
    tar xvf train.tar
    
    wget http://csr.bu.edu/ftp/visda17/clf/validation.tar
    tar xvf validation.tar  
    
Images are structured in folders as 

- `train/{category}/{section_id}_{object_id}_{cam_yaw}_{light_yaw}_{cam_pitch}.png` for training synthetic data and
- `validation/{category}/{object_id}.jpg` for valiation data

with a single `image_list.txt` file in the root or each dataset that lists all images and corresponding labels. Folder names won't be avaliable upon test time :).

Alternative way to download the data (Google Shared Driver): [train.tar](https://drive.google.com/file/d/0BwcIeDbwQ0XmdENwQ3R4TUVTMHc/view?usp=sharing), [validation.tar](https://drive.google.com/file/d/0BwcIeDbwQ0XmUEVJRjl4Tkd4bTA/view?usp=sharing)

## Baseline

We have several baseline models with data readers in [`/model`](model) folder. Each model has a short README on how to run it.

- "Adversarial Discriminative Domain Adaptation" (ADDA) with LeNet and VGG16 in Tensorflow [`arxiv`](https://arxiv.org/abs/1702.05464)
- "Learning Transferable Features with Deep Adaptation Networks" (DAN) with Alexnet in Caffe [`arxiv`](https://arxiv.org/pdf/1502.02791)
- "Deep CORAL: Correlation Alignment for Deep Domain Adaptation" with Alexnet in Caffe [`arxiv`](https://arxiv.org/abs/1607.01719)

Please refer to the [challenge rules]() for specific guidelines your method must follow.

## Evaluate your model

To evaluate the performance of your model, you should:
- Train you model with `train` and `validation` set. In the `./baseline/DAN` folder, we have provided a detailed description about how to train your own models with [Caffe](http://caffe.berkeleyvision.org/), 
- Predict labels for images in `validation` set. See  `>> exp_pred()` as an example for Caffe (change path in the file accordingly). The prediction function will generate a text file with timestamp to `./result`. This text file can be used for submission to the evaluation server.
- Calculate the mean accuracy. We have shared the script used for our evaluation server (`exp_eval.py` or `exp_pred.m`) here. However, you are encouraged to upload your results to the evaluation server to compare your performance with that of other participants. 

In the testing phases, you will be provided with a text file that contains a list of image ID annotations in a random order. Your result should be in the format of two text files:

- “source_results.txt”, which contains your results with no adaptation performed 
- “adaptation_results.txt”, which contains your results using adaptation methods

 Both files must be included for your submission to be scored. The format of both files are identical and each text file should contain corresponding category ID for each image from the provided annotations file. Your reported results should follow the same order as the annotations and each classification should be on a new line. All images must be classified for the submission to be scored. 

The category IDs are as follows:
> 0 – airplane  
> 1 – bicycle  
> 2 – bus  
> 3 – car  
> 4 – horse  
> 5 – knife  
> 6 – motorcycle  
> 7 – person  
> 8 – plant  
> 9 – skateboard  
> 10 – train  
> 11 – truck 
 
 
Submissions will be evaluated by calculating the classification accuracy of each category and then the mean accuracy across all categories. The leaderboard on CodaLab will display all of these scores, and the official ranking will be determined by the mean classification accuracy across all categories. 



### Instructions for submitting to the evaluation server:

- Generate "source_results.txt" and "adaptation_results.txt".
- Additionally, generate a file called "method_pretrained.txt" that contains a 0 if your method is not pretrained on ImageNet, and a 1 if it is pretrained on ImageNet. This file must be included in order for your submission to be evaluated
- Place these files into a zip file named [team_name]_submission
- Submit to CodaLab evaluation server following the instructions below

To submit your zipped result file to the [VisDA Classification challenge](https://competitions.codalab.org/competitions/17020?secret_key=cb4cb9f3-3f9e-4179-858b-4ecd6c3b58f1) click on the “Participate” tab. Select the phase (validation or testing). Select “Submit / View Results, fill in the required fields and click “Submit”. A pop-up will prompt you to select the results zip file for upload. After the file is uploaded the evaluation server will begin processing. This might take some time. To view the status of your submission please select “Refresh Status”. If the status of your submission is “Failed” please check your file is named correctly and has the right format. You may refer to the scoring output and error logs for more details.

After you submit your results to the evaluation server, you can control whether your results are publicly posted to the CodaLab leaderboard. To toggle the public visibility of your results please select either “post to leaderboard” or “remove from leaderboard.” 

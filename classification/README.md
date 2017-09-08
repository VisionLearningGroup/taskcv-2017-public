The classification challenge uses synthetic object images rendered from CAD models as the training domain and real object images cropped from the COCO dataset as the validation domain.

## Downloading Data

By downloading these datasets you agree to the following terms:

### Terms of Use
- You will use the data only for non-commercial research and educational purposes.
- You will NOT distribute the images.
- The organizers make no representations or warranties regarding the data, including but not limited to warranties of non-infringement or fitness for a particular purpose.
- You accept full responsibility for your use of the data.

You can download the datasets with 
    
    cd ./data
    wget http://csr.bu.edu/ftp/visda17/clf/train.tar
    tar xvf train.tar
    
    wget http://csr.bu.edu/ftp/visda17/clf/validation.tar
    tar xvf validation.tar  
    
    wget http://csr.bu.edu/ftp/visda17/clf/test.tar
    tar xvf test.tar
    
Images are structured in folders as 

- `train/{category}/{section_id}_{object_id}_{cam_yaw}_{light_yaw}_{cam_pitch}.png` for training synthetic data and
- `validation/{category}/{object_id}.jpg` for validation data
- `test/truck_id/{MD5_hash_code}.jpg` for test data

with a  single `image_list.txt` file in the root or each dataset that lists all images and corresponding labels for train/val subset. For test data, only images are provided. After you have downloaded and unzipped the data, it should have this basic structure:

```
data/
data/train/                 % training data
data/validation/            % validation data
data/test/                  % test data
```

An alternative way to download the data (Google Drive): [train.tar](https://drive.google.com/file/d/0BwcIeDbwQ0XmdENwQ3R4TUVTMHc/view?usp=sharing), [validation.tar](https://drive.google.com/file/d/0BwcIeDbwQ0XmUEVJRjl4Tkd4bTA/view?usp=sharing), [test.tar](https://drive.google.com/file/d/0BwcIeDbwQ0XmdGttZ0k2dmJYQ2c/view?usp=sharing)

### Training Domain Generation

The training domain was custom-generated for the challenge. The `section_id` in the file name indicates the 3D model dataset used to get this image. We used manually chosen subsets of [ShapenetCore](https://www.shapenet.org/), [NTU 3D](http://3d.csie.ntu.edu.tw/~dynamic/database/index.html), [SHREC 2010](http://www.itl.nist.gov/iad/vug/sharp/contest/2010/Generic3DWarehouse/) with some labels retrieved from [TSB](http://www.kde.cs.tut.ac.jp/benchmark/tsb/) and our own collection of 3D CAD models from 3D Warehouse SketchUp.
A technical report detailing the data generation process will be released in the near future. 

## Baselines and Rules

We have several baseline models with data readers in the [`/model`](model) folder. Each model has a short README on how to run it.

- "Adversarial Discriminative Domain Adaptation" (ADDA) with LeNet and VGG16 in Tensorflow [`arxiv`](https://arxiv.org/abs/1702.05464)
- "Learning Transferable Features with Deep Adaptation Networks" (DAN) with Alexnet in Caffe [`arxiv`](https://arxiv.org/pdf/1502.02791)
- "Deep CORAL: Correlation Alignment for Deep Domain Adaptation" with Alexnet in Caffe [`arxiv`](https://arxiv.org/abs/1607.01719)

Please refer to the [challenge rules](http://ai.bu.edu/visda-2017/) for specific guidelines your method must follow.

## Evaluating your Model

To evaluate the performance of your adaptation model, you should:
- Train you model with training data (with labels) and adapt it on the validation data (without labels). See the ./model folder for instructions on running baseline experiments.
- Predict labels for images in the validation set.
- Calculate the mean accuracies for each category and the overall mean of these accuracies. You are encouraged to upload your results to the evaluation server to compare your performance with that of other participants. 

We have shared the evaluation scripts that will be used by our evaluation server (exp_eval.py or exp_pred.m) so you can evaluate offline.

For Caffe, see exp_pred.m for instruction on how to generate a prediction file (change path in the file accordingly). For Tensorflow, predictions are stored in ./predictions folder and written by the eval\_\* scripts. Generated text files can be used for submission to the evaluation server. 

In the testing phase, you will be provided with a text file that contains a list of image ID labels in a random order. Your results should be in the format of two text files: “source_results.txt”, which contains your results with no adaptation performed and “adaptation_results.txt”, which contains your results using adaptation methods.

The category IDs are as follows:
> 0 – aeroplane  
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

### Evaluation Server and Leaderboards
 
We are using CodaLab to evaluate results and host the leaderboards for this challenge. You can find the image classification competition [here](https://competitions.codalab.org/competitions/17052). Please see the "Evaluation" tab in the competition for more details on leaderboard organization. 


### Submitting to the Evaluation Server
 
Once the servers become available, you will be able to submit your results:
- Generate "source_results.txt" and "adaptation_results.txt".
- Place these files into a zip file named [team_name]_submission
- Submit to CodaLab evaluation server following the instructions below

To submit your zipped result file to the appropriate VisDA Classification challenge click on the “Participate” tab. Select the phase (validation or testing). Select “Submit / View Results, fill in the required fields and click “Submit”. A pop-up will prompt you to select the results zip file for upload. After the file is uploaded, the evaluation server will begin processing. This might take some time. To view the status of your submission please select “Refresh Status”. If the status of your submission is “Failed” please check your file is named correctly and has the right format. You may refer to the scoring output and error logs for more details.

After you submit your results to the evaluation server, you can control whether your results are publicly posted to the CodaLab leaderboard. To toggle the public visibility of your results please select either “post to leaderboard” or “remove from leaderboard.” 
 
### Feedback and Help
If you find any bugs please [open an issue](https://github.com/MInner/taskcv-2017-public/issues).


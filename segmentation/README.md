Semantic segmentation challenge uses GTA5 as the source domain and CityScapes as the validation domain.


## Data Acquisition

### GTA5
- Download the dataset directly from the GTA website or by using the provided script.
- https://download.visinf.tu-darmstadt.de/data/from_games/
- The dataset and labels are available in 10 parts (sequences). 
- For convienience, you may also directly download the dataset using the script: ./data/get_gta.sh
    - This script will first download the .zip files for images and annotations and then unzip them
    - Edit the base_gta folder path to download to desired directory


### CityScapes
- Download this dataset directly from the CityScapes website: https://www.cityscapes-dataset.com/
- Create a login account on the CityScapes website
- Once you've logged in you may download the train, val and test annotations and images
  - Annotations: gtFine_trainvaltest.zip (241MB) https://www.cityscapes-dataset.com/file-handling/?packageID=1
  - Images: leftImg8bit_trainvaltest.zip (11GB) https://www.cityscapes-dataset.com/file-handling/?packageID=3


### Test Domain

- Details about the test data will be released at a later date.


## Example Source Model

Caffe FCN Dilated GTA5 Model
-----------------------------
- Eval script: scripts/val_frontend.sh
- Model: dilation10_gta5_frontend.caffemodel
- Caffe dilation code: https://github.com/fyu/caffe-dilation
    - Make with python_layers and make sure to make pycaffe
- Dilation code: https://github.com/fyu/dilation
    - This code contains the test.py script used for evaluating the demo source model.

## Evaluate your model

To run local evaluation on the CityScapes val set you may use the eval.py script. 

Submission of results should be as collections of PNG format indexed image files, one per test image, with pixel indices from 0 to 18. The example baseline codebase includes code for generating results in the required format. Participants may choose to include segmentations for only a subset of the 19 classes in which case they will be evaluated on only the included classes. 
To assess performance, we rely on the standard Jaccard Index, commonly known as the PASCAL VOC intersection-over-union metric. Code is provided to compute IoU score for each class, and the overall average IoU score. Participants are expected to submit a single set of results per method employed. Participants who have investigated several algorithms may submit one result per method. Changes in algorithm parameters do not constitute a different method - all parameter tuning must be conducted using the training and validation data alone.

Participants should upload a single zip archive, where each output png file should have the same name of input image, such as “frankfurt_000001_007973_leftImg8bit.png”. The files should be in the same main folder, where exactly one result file for each test image. Result image size must be equal to the input image size, i.e. 2048 x 1024 pixels.

The segmentation classes are shown as follow:
> 0 – road  
> 1 – sidewalk  
> 2 – building  
> 3 – wall  
> 4 – fence  
> 5 – pole  
> 6 – light  
> 7 – sign  
> 8 – vegetation  
> 9 – terrain  
> 10 – sky  
> 11 – person  
> 12 – rider  
> 13 – car  
> 14 – truck  
> 15 – bus  
> 16 – train  
> 17 – motocycle  
> 18 – bicycle  

### Instructions for submitting to the evaluation server:
Once the evaluation server becomes available, you will be able to submit your results:
- Generate a folder "pred_dir" that contains all of your predictions.
- Additionally, generate a file called "method_pretrained.txt" that contains a 0 if your method is not pretrained on ImageNet, and a 1 if it is pretrained on ImageNet. This file must be included in order for your submission to be evaluated.
- Place these items into a zip file named [team_name]_submission
- Submit to CodaLab evaluation server following the instructions below

To submit your zipped result file to the [VisDA Segmentation challenge]() click on the “Participate” tab. Select the phase (validation or testing). Select “Submit / View Results, fill in the required fields and click “Submit”. A pop-up will prompt you to select the results zip file for upload. After the file is uploaded the evaluation server will begin processing. This might take some time. To view the status of your submission please select “Refresh Status”. If the status of your submission is “Failed” please check your file is named correctly and has the right format. You may refer to the scoring output and error logs for more details.

After you submit your results to the evaluation server, you can control whether your results are publicly posted to the CodaLab leaderboard. To toggle the public visibility of your results please select either “post to leaderboard” or “remove from leaderboard.” 

### Feedback and Help
If you find any bugs please [open an issue](https://github.com/VisionLearningGroup/taskcv-2017-public/issues).


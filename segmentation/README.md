Semantic segmentation challenge uses GTA5 as the source domain and CityScapes as the validation domain.


Data Acquisition
================
GTA5
----
- Download the dataset directly from the GTA website or by using the provided script.
- https://download.visinf.tu-darmstadt.de/data/from_games/
- The dataset and labels are available in 10 parts (sequences). 
- For convienience, you may also directly download the dataset using the script: ./data/get_gta.sh
    - This script will first download the .zip files for images and annotations and then unzip them
    - Edit the base_gta folder path to download to desired directory


CityScapes
----------
- Download this dataset directly from the CityScapes website: https://www.cityscapes-dataset.com/
- Create a login account on the CityScapes website
- Once you've logged in you may download the train, val and test annotations and images
  - Annotations: gtFine_trainvaltest.zip (241MB) https://www.cityscapes-dataset.com/file-handling/?packageID=1
  - Images: leftImg8bit_trainvaltest.zip (11GB) https://www.cityscapes-dataset.com/file-handling/?packageID=3


Test Domain
-----------
- Details about the test data will be released at a later date.

Evaluation
===========
To run local evaluation on the CityScapes val set you may use the eval.py script. 

Example Source Model
====================

Caffe FCN Dilated GTA5 Model
-----------------------------
- Eval script: scripts/val_frontend.sh
- Model: dilation10_gta5_frontend.caffemodel
- Caffe dilation code: https://github.com/fyu/caffe-dilation
    - Make with python_layers and make sure to make pycaffe
- Dilation code: https://github.com/fyu/dilation
    - This code contains the test.py script used for evaluating the demo source model.

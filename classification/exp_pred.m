function result = exp_pred()

% ---------------------------------------------------------
% This file is part of VISDA-17 challenge code. 
% This function is to predict the labels for the testing images. 
% Please modify the following paths accordingly when you
% call this function:
% 1. test_file_path : path to your prediction text file
% 2. deploy_file_path : path to the deploy file
% 3. weight_path: path to the caffemodel
% 4. caffe_root: path to the caffe root dir
% Contact: Xingchao Peng (xpeng@bu.edu)
% ---------------------------------------------------------

% ---------------- User Configuration----------------------
 
test_file_path = '/path/to/your/test.txt';
% e.g. ./model/DAN/test.txt
deploy_file_path = '/path/to/your/deploy.prototxt';
% e.g. ./model/DAN/dan_deploy_visda17.prototxt
weight_path = '/path/to/your/trained/caffemodel';
% e.g. ./model/DAN/dan_visda17_iteration_40000.caffemodel
caffe_root = '/path/to/your/caffe/root_dir'; 
% e.g. /home/workspace/visda17/model/DAN/caffe

% ------------------End of user configuration----------------

addpath([caffe_root './matlab']);
fid_predicton = fopen(['./result/prediciton_' datestr(now, 30) '.txt'],'w');
category = {'aeroplane', 'bicycle', 'bus', 'car', 'horse', 'knife', ...
    'motorcycle' , 'person',  'plant', 'skateboard',  'train', 'truck'};
category_num = 12;
crop_size = 227;
phase = 'test';
img_mean_path = [caffe_root '/matlab/+caffe/imagenet/ilsvrc_2012_mean.mat'];
net = caffe.Net(deploy_file_path, weight_path, phase);

[paths, labels] = textread(test_file_path, '%s %d');

for i = 1:length(paths)
    img = imread(paths{i});
    if ndims(img) < 3
        tmp_im = [];
		tmp_im(:,:,1) = img;
		tmp_im(:,:,2) = img;
		tmp_im(:,:,3) = img;
		img = tmp_im;
    end
    input_data = prepare_image(img, img_mean_path, crop_size);
    f = net.forward({input});
    f = mean(squeeze(f{1}),2)';
    [max_act, pred_label] =max(f);
    fprintf('Predicting %d/%d image as %s.\n', i, length(labels), category{pred_label});
    fprintf(fid_prediction, '%d\n', pred_label -1 );
end
fclose all;

function images = prepare_image(im, img_mean, crop_size)
% ------------------------------------------------------------------------
d = load(img_mean);
IMAGE_MEAN = d.mean_data;
IMAGE_DIM = 256;
CROPPED_DIM = crop_size;

% resize to fixed input size
im = single(im);
im = imresize(im, [IMAGE_DIM IMAGE_DIM], 'bilinear');
% permute from RGB to BGR (IMAGE_MEAN is already BGR)
im = im(:,:,[3 2 1]) - IMAGE_MEAN;

% oversample (4 corners, center, and their x-axis flips)
images = zeros(CROPPED_DIM, CROPPED_DIM, 3, 10, 'single');
indices = [0 IMAGE_DIM-CROPPED_DIM] + 1;
curr = 1;
for i = indices
  for j = indices
    images(:, :, :, curr) = ...
        permute(im(i:i+CROPPED_DIM-1, j:j+CROPPED_DIM-1, :), [2 1 3]);
    images(:, :, :, curr+5) = images(end:-1:1, :, :, curr);
    curr = curr + 1;
  end
end
center = floor(indices(2) / 2)+1;
images(:,:,:,5) = ...
    permute(im(center:center+CROPPED_DIM-1,center:center+CROPPED_DIM-1,:), ...
        [2 1 3]);
images(:,:,:,10) = images(end:-1:1, :, :, curr);
end







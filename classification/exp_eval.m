function result = exp_eval()

% ---------------------------------------------------------
% This file is part of VISDA-17 challenge code. 
% This function is to calculate the mean accuarcy. 
% Please modify the following paths accordingly when you
% call this function:
% 1. pred_file_path : path to your prediction text file
% 2. gt_file_path   : path to the ground truth text file 
% Contact: Xingchao Peng (xpeng@bu.edu)
% ---------------------------------------------------------

% ---------------- User Configuration----------------------
pred_file_path = './result/example_prediction.txt';
gt_path = './result/val_ground_truth.txt';
% ------------------End of configuration--------------------


pred_label = textread(pred_file_path);
gt_label = textread(gt_path);
category_num  = 12;
category = {'aeroplane', 'bicycle', 'bus', 'car', 'horse', 'knife', ...
    'motorcycle' , 'person',  'plant', 'skateboard',  'train', 'truck'};


[Confmat,index] = confusionmat(pred_label, gt_label);
x_sum = sum(Confmat);
Confmat = double(Confmat);
sub_accuracy=zeros(category_num,1);

fprintf('Sub-accuracy:\n');
fprintf('=================\n');
for j =1:category_num
	Confmat(:,j) = Confmat(:,j)/x_sum(j);
	sub_accuracy(j) = Confmat(j,j);
	fprintf(['%10s | %0.1f\n'], category{j} ,sub_accuracy(j)*100);
end

fprintf('\n\n');
fprintf('Mean accuracy: %.2f\n', 100*sum(sub_accuracy)/length(sub_accuracy));

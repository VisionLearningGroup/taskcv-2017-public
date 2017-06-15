
addpath('/home/grad2/xpeng/workspace/caffe/matlab');

img_mean = '/home/grad2/xpeng/workspace/caffe/matlab/+caffe/imagenet/ilsvrc_2012_mean.mat';



conf.weights = {'/home/grad2/xpeng/workspace/ICCV17_challendge/baseline/dan_syn_coco_b/trained_model_iter_40000.caffemodel'};
conf.net_model = { '/home/grad2/xpeng/workspace/ICCV17_challendge/baseline/dan_syn_coco_b/deploy.prototxt'};

%conf.test_file = { '/home/grad2/xpeng/workspace/ICCV17_challendge/coco/img_patch_100/test.txt'};
%conf.weights = {'/home/grad2/xpeng/workspace/ICCV17_challendge/baseline/alexnet_imagenet_imagenet_8/high_iter_40000.caffemodel'};
%conf.net_model = {'/home/grad2/xpeng/workspace/ICCV17_challendge/baseline/dan_syn_imagenet/deploy.prototxt'};
conf.test_file = {'/home/grad2/xpeng/workspace/ICCV17_challendge/baseline/dan_syn_coco_b/test.txt'};


conf.feat_len = [8]
conf.crop_size = [227,227,224,224,224,224];


%local configuration
caffe.set_mode_gpu();
caffe.set_device(1);
phase = 'test';



for i=1:1
	net = caffe.Net(conf.net_model{i}, conf.weights{i}, phase);
	for k = 1:length(conf.test_file)
		[path, class] = textread(conf.test_file{k}, '%s %d');
		pred_label = zeros(length(class), 1);
		features = zeros(length(class), conf.feat_len(i));
		for j = 1:length(class)
			fprintf('%d %d %d %d\n', i,k, j, length(class));
			im = imread(path{j});
			%fprintf('%d\n', ndims(im));
			%size(im)
			
			if ndims(im)<3
				tmp_im = [];
				tmp_im(:,:,1) = im;
				tmp_im(:,:,2) = im;
				tmp_im(:,:,3) = im;
				im = tmp_im;
			end
			
			input = extractor(im, img_mean, conf.crop_size(i));
			%size(input)
			f = net.forward(input);
			f = f{1};
			f = mean(squeeze(f),2)';
            %size(f)
			[fc_act, label] =max(f);  
			pred_label(j) = label; 
			features(j,:) = f; 
        end
 		gt_label = class + 1;
		true_positive = find(pred_label == gt_label);
		accuracy = length(true_positive)/length(gt_label);
		fprintf('Accuracy of: %f \n', accuracy);
		[C,index] = confusionmat( pred_label, gt_label);
		x_sum = sum(C);
		C = double(C);
		p=zeros(31,1);
		for j =1:31
			C(:,j) = C(:,j)/x_sum(j);
			p(j) = C(j,j);
			fprintf('%.1f &', p(j)*100);
		end
		fprintf('%.2f', accuracy*100);
        
        
	end
end

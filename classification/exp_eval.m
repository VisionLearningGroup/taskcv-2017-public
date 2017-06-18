pred_label = textread('./result/pred.txt');
gt_label = textread('./result/val_gt.txt');
category_num  = 12;


[C,index] = confusionmat( pred_label, gt_label);
x_sum = sum(C);
C = double(C);
p=zeros(category_num,1);
for j =1:category_num
	C(:,j) = C(:,j)/x_sum(j);
	p(j) = C(j,j);
	fprintf('%.1f &', p(j)*100);
end

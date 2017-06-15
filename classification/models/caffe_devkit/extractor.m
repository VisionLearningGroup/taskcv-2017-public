function input_data = extractor(im, img_mean, crop_size)
% scores: n-dimensional vector, n represents the number of
% tic;
input_data = {prepare_image(im, img_mean, crop_size)};





%scores = squeeze(scores);%convert scores(4-D vector) to n*10 vector.

end

% ------------------------------------------------------------------------
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

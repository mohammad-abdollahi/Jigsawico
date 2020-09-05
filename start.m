clc;close all;clear;

images_path = './Puzzle_1_160/';
directory = dir(images_path);
dirSize = numel(directory);
sample = imread([images_path directory(12).name]);
output = imread([images_path 'Output.tif']);
patch_size = size(sample,1);
col = size(output,2)/patch_size;
row = size(output,1)/patch_size;
patch_count = (size(output,1)*size(output,2))/(patch_size*patch_size) - 4;
patches = [];
final = [];
visited = [];
result = output;
imshow(result,[]);
pause(0.2);

for i=1:patch_count
    name = [images_path 'Patch_' num2str(i) '.tif'];
    j = imread(name);
    patches = cat(4, patches,j);
end

% sort first column
for r = 1:row-2
    c = result(( (r-1)*patch_size+1:r*patch_size ), (1:patch_size), :);
    diff = zeros(patch_count);
    for i=1:patch_count
       if ismember(i, visited)
           continue;
       else
           diff(i) = psnr(c(end, :,:), patches(1, :,:,i));
       end
    end
    [m,index] = max(diff);
    visited = [visited, index(1)];
    result( (r*patch_size+1 : (r+1)*patch_size), (1:patch_size), : ) = patches(:,:,:, index(1));
    imshow(result);
end

%sort first row
for k = 1:col-2
    c = result( (1:patch_size), ( (k-1)*patch_size+1:k*patch_size ), :);
    diff = zeros(patch_count);
    for i=1:patch_count
       if ismember(i, visited)
           continue;
       else
           diff(i) = psnr(c(:,(end),:), patches(:,(1),:,i));
       end
    end
    
    [m,i] = max(diff);
    visited = [visited, i(1)];
    result( (1:patch_size), (k*patch_size+1 : (k+1)*patch_size), : ) = patches(:,:,:, i(1));
    imshow(result);
end

%sort inside
for i = 1:row-2
    c1 = result( ( i*patch_size+1:(i+1)*patch_size ), (1:patch_size), : );
    for j = 1:col-1
        c2 = result( ( (i-1)*patch_size+1 : i*patch_size ), ((j)*patch_size+1 : (j+1)*patch_size), : );
        diff = zeros(patch_count);
        for k=1:patch_count
           if ismember(k, visited)
               continue;
           else
               diff(k) = psnr(c1( :, (end),:), patches( :, (1),:,k));
               diff(k) = diff(k) + psnr(c2((end), :,:), patches( (1),:,:,k));
           end
        end
        [m,ind] = max(diff);
        visited = [visited, ind(1)];
        result( (i*patch_size+1: (i+1)*patch_size), (j)*patch_size+1 : (j+1)*patch_size, : ) = patches(:,:,:, ind(1));
        imshow(result);
        c1 = patches(:,:,:, ind(1));
    end
end

% sort last column
for k = 1:col-2
    c = result( (end-patch_size+1:end), ( (k-1)*patch_size+1:k*patch_size ), :);
    diff = zeros(patch_count);
    for i=1:patch_count
       if ismember(i, visited)
           continue;
       else
           diff(i) = psnr(c(:,(end),:), patches(:,(1),:,i));
       end
    end
    
    [m,i] = max(diff);
    visited = [visited, i(1)];
    result( (end-patch_size+1:end), (k*patch_size+1 : (k+1)*patch_size), : ) = patches(:,:,:, i(1));
    imshow(result);
    
end

imshow(result);

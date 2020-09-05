clc; close all; clear;

img = imread('Documents/computer_vision/final-proj/Final_Project_V1/Puzzle_1_40/Original.tif');

k = 1;
minus = 0;
for i=1:60:1200
    for j=1:60:1920
        piece = img( (i:i+59), (j:j+59), : );
        %imshow(piece);
        if k == 1 || k == 32 || k == 609 || k == 640
            k = k + 1;
            minus = minus+1;
            continue;
        end
        imwrite(piece, ['Documents/computer_vision/final-proj/Final_Project_V1/Puzzle_1_640/Patch_' num2str(k-minus) '.tif']);
        k = k + 1;
    end
end

output = zeros(1200, 1920, 3);
imwrite(img( (1:60), (1:60), :), 'Documents/computer_vision/final-proj/Final_Project_V1/Puzzle_1_640/Corner_1_1.tif');
imwrite(img( (1:60), (1861:1920), :), 'Documents/computer_vision/final-proj/Final_Project_V1/Puzzle_1_640/Corner_1_32.tif');
imwrite(img( (1141:1200), (1:60), :), 'Documents/computer_vision/final-proj/Final_Project_V1/Puzzle_1_640/Corner_20_1.tif');
imwrite(img( (1141:1200), (1861:1920), :), 'Documents/computer_vision/final-proj/Final_Project_V1/Puzzle_1_640/Corner_20_32.tif');

output( (1:60), (1:60), :) = img( (1:60), (1:60), :);
output( (1:60), (1861:1920), :) = img( (1:60), (1861:1920), :);
output( (1141:1200), (1:60), :) = img( (1141:1200), (1:60), :);
output( (1141:1200), (1861:1920), :) = img( (1141:1200), (1861:1920), :);
imwrite(uint8(output), 'Documents/computer_vision/final-proj/Final_Project_V1/Puzzle_1_640/Output.tif');

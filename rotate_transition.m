perspective(imread('images/bernie_ring.jpg'), imread('images/hobbit_ring.png'), "Final_Vid_Clips/bernie_ring", 5);

function res = perspective(im1, im2, saveName, time)
    % assumes that im1 and im2 are of the same size, time in seconds
    % saveName: name of saved mp4 file
    % time: time in seconds for fade
    im1 = imresize(im1, [512 512]);
    im2 = imresize(im2, [512, 512]);
    numFrames = time * 25;
    for k = 1:numFrames

        im_rot = imrotate(im1, 5*k, 'bilinear', 'crop');
        im_rot_resize = imresize(im_rot, [max(1, 512-5*k), max(1, 512-5*k)]);
        im_curr = im2;
        [crop_row, crop_col] = size(im_rot_resize);
        crop_row_w = floor(crop_row/2);
        crop_col_w = floor(crop_col/2);
        try
        im_curr(256 - crop_row_w: 256 + crop_row_w, 256 - crop_row_w:256 + crop_row_w, :) = im_rot_resize;
        catch
        im_curr(256 - crop_row_w: 256 + crop_row_w-1, 256 - crop_row_w:256 + crop_row_w-1, :) = im_rot_resize;
        end
        M(k) = im2frame(im_curr);
    end
    v = VideoWriter(saveName,'Motion JPEG AVI'); %Name your video
    v.FrameRate = 25; %Set the frame rate to 25 frames per second
close all
open(v)
    writeVideo(v,M);
    close(v);

end

function result = rotate(im, angle)
rotation_mat = [cosd(angle), sind(angle); -sind(angle), cosd(angle)];

[rows, cols, num_channels] = size(im);
diagonal = sqrt(rows^2+ cols^2);
rowpad = ceil(diagonal - rows)+2;
colpad = ceil(diagonal - cols)+2;
rodinpad = zeros(rows + rowpad, cols + colpad, 3);

rodinpad(ceil(rowpad/2):(rows + ceil(rowpad/2) - 1), ceil(colpad/2):(cols + ceil(colpad/2) - 1), : ) = im;
rodin_45 = zeros(size(rodinpad));
% midpoints
midx = ceil((size(rodinpad, 1) + 1)/2);
midy = ceil((size(rodinpad, 2) + 1)/2);

    for i = 1:size(rodinpad, 1)
        for j = 1:size(rodinpad, 2)
            x = (i - midx)*cosd(angle) + (j-midy)*sind(angle);
            y = -(i-midx)*sind(angle) + (j-midy)*cosd(angle);
            x = round(x)+midx;
            y = round(y)+midy;

            if(x>=1 && y>= 1 && x<=size(rodinpad, 2)&& y<= size(rodinpad, 1))
               rodin_45(i,j, :) = rodinpad(x,y, :);
            end
        end
    end 
result = imresize(rodin_45, [rows cols 3]);
end


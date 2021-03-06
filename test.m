function res = fade(im1, saveName, time)
% p1_data = rgb2gray(im);
p1_data = im;

first_order_mask = [0.25 0.5 0.25; 0.5 1 0.5; 0.25 0.5 0.25];
[rows, cols, a] = size(p1_data);
interspersed = zeros(rows*2, cols*2, 3);
interspersed(1:2:rows*2, 1:2:cols*2, :) = p1_data;


conv_zoom1(:, :, 1) = (conv2(interspersed(:, :, 1), first_order_mask));
conv_zoom1(:, :, 2) = (conv2(interspersed(:, :, 2), first_order_mask));
conv_zoom1(:, :, 3) = (conv2(interspersed(:, :, 3), first_order_mask));
conv_zoom1 = rescale_255(conv_zoom1);
    % assumes that im1 and im2 are of the same size, time in seconds
    % saveName: name of saved mp4 file
    % time: time in seconds for fade
    im1 = imresize(im1, [512 512]);
    im2 = imresize(im2, [512, 512]);
    numFrames = time * 25;
    for k = 1:numFrames
        leftx = floor(k * (220 - 1)/numFrames);
        rightx = 1026 - ((1026 - 420) * k / numFrames);
        lefty = floor(k * (550 - 1)/numFrames);
        righty = 750 - ((1026 - 750) * k / numFrames);
        im_curr = conv_zoom1(leftx:rightx, lefty:righty, :);
        im_curr = imresize(im_curr, [512 512]);
        imagesc(im_curr);
        M(k) = getframe(gcf);
    end
    v = VideoWriter(saveName,'MPEG-4'); %Name your video
    v.FrameRate = 25; %Set the frame rate to 25 frames per second
close all
open(v)
    writeVideo(v,M);
    close(v);

end


function scaled = rescale_255(im)
    im_max = max(max(im));
    im_min = min(min(im));
    %normed = (im - im_min)/(im_max - im_min);
    scaled =  floor(255 .* ((im - im_min)./(im_max - im_min)));
end
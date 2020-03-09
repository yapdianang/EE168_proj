zoom_girl(imread('images_processed/9_out.jpg'), "Final_Vid_Clips/zoom_grill_biden", 5);

function res = zoom_girl(im1, saveName, time)
im1 = imresize(im1, [512 512]);
% p1_data = rgb2gray(im);
p1_data = im1;

first_order_mask = [0.25 0.5 0.25; 0.5 1 0.5; 0.25 0.5 0.25];
[rows, cols, a] = size(p1_data);
interspersed = zeros(rows*2, cols*2, 3);
interspersed(1:2:rows*2, 1:2:cols*2, :) = p1_data;


conv_zoom1(:, :, 1) = (conv2(interspersed(:, :, 1), first_order_mask));
conv_zoom1(:, :, 2) = (conv2(interspersed(:, :, 2), first_order_mask));
conv_zoom1(:, :, 3) = (conv2(interspersed(:, :, 3), first_order_mask));
conv_zoom1 = rescale_255(conv_zoom1);

    numFrames = time * 25;
    for k = 1:numFrames
        leftx = (k-1) * (220/numFrames) + 1;
        rightx = 1026 -  (1026 - 420)*(k-1)/numFrames;
        lefty = (k-1) * (550/numFrames) + 1;
        righty = 1026 - (1026 - 750)*(k-1)/numFrames;
        im_curr = conv_zoom1(leftx:rightx, lefty:righty, :);

        im_curr = imresize(im_curr, [512 512]);
        M(k) = im2frame(uint8(im_curr));
    end
    v = VideoWriter(saveName,'Motion JPEG AVI'); %Name your video
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
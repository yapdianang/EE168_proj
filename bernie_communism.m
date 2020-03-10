
communism(imread('images/bernie_financial.jpg'), 'Final_Vid_Clips/bernie_communism', 5);

function res = communism(im1, saveName, time)
    % assumes that im1 and im2 are of the same size, time in seconds
    % saveName: name of saved mp4 file
    % time: time in seconds for fade
    im1 = imresize(im1, [512 512]);
    numFrames = time * 25;
    factor = im1(:, :, 3)/round(numFrames/2);
    factor = factor + im1(:, :, 2)/round(numFrames/2);
    im_curr = im1;
    for k = 1:numFrames/2
        im_curr = im_curr - factor;
        im_curr(:, :, 1) = rescale_255(im_curr);
        image(im_curr);
        M(k) = im2frame(im_curr);
    end
    for k = 1:numFrames/2
        im_curr_new = im1.* (k/(numFrames/2)) + im_curr .* (1 - k/(numFrames/2));
        image(im_curr_new);
        M(k) = im2frame(im_curr_new);
    end

    v = VideoWriter(saveName,'Motion JPEG AVI'); %Name your video
    v.FrameRate = 25; %Set the frame rate to 25 frames per second
    close all
    open(v)
    writeVideo(v,M);
    close(v);

end

function scaled = rescale_255(im)
    im_max = max(max(im(:, :, 1)));
    im_min = min(min(im(:, :, 1)));
    %normed = (im - im_min)/(im_max - im_min);
    scaled =  floor(255 .* ((im(:, :, 1) - im_min)./(im_max - im_min)));
end
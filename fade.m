function res = fade(im1, im2, saveName, time)
    % assumes that im1 and im2 are of the same size, time in seconds
    % saveName: name of saved mp4 file
    % time: time in seconds for fade
    im1 = imresize(im1, [512 512]);
    im2 = imresize(im2, [512, 512]);
    numFrames = time * 25;
    for k = 1:numFrames

        im_curr = rescale(im1(:, :, :) .* (1-k/numFrames) + im2(:, :, :) .* ((k)/numFrames));
        image(im_curr);
        M(k) = im2frame(im_curr);
    end
    v = VideoWriter(saveName,'Motion JPEG AVI'); %Name your video
    v.FrameRate = 25; %Set the frame rate to 25 frames per second
close all
open(v)
    writeVideo(v,M);
    close(v);

end
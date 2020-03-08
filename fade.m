function res = fade(im1, im2, time)
    % assumes that im1 and im2 are of the same size, time in seconds
    numFrames = time * 25;
    for k = 1:numFrames

        im_curr = im1(:, :, :) * k/numFranes + im2(:, :, :) * (1-k)/numFrames;

        imagesc(im_curr);
        M(k) = getframe(gcf);
    end
    v = VideoWriter('FluxFade','MPEG-4'); %Name your video
    v.FrameRate = 25; %Set the frame rate to 25 frames per second
    open(v)
    writeVideo(v,M);
    close(v);

end
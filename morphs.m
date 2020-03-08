function morph = makeMorph(csv1, csv2, im1, im2, fps, name)

    p_1 = imread(im1);
    p_2 = imread(im2);
    
    x_1 = readtable(csv1)(1,:);
    y_1 = readtable(csv1)(2,:);
    x_2 = readtable(csv2)(1,:);
    x_2 = readtable(csv2)(2,:);

    vectors_x = x_2 - x_1;
    vectors_y = y_2 - y_1;

    % generate resampling grid
    x=linspace(1,512,512);
    y=linspace(1,512,512);
    [xi,yi]=meshgrid(x,y);
    % shiftx is an array of the shift in x at each point
    shiftx=griddata(x_1,y_1,vectors_x,xi,yi,'linear');
    shiftx(isnan(shiftx)) = 0;
    shifty=griddata(x_1,y_1,vectors_y,xi,yi,'linear');
    shifty(isnan(shifty)) = 0;
    shiftx = -shiftx;
    shifty = -shifty;

    final = zeros(512,512);
    for k=1:11
        frac=(k-1)/10;
        % get the new locations of the pixels, moving the first image towards the second, and
        % the second towards the first
        locx = round(xi+shiftx*frac);
        locy = round(yi+shifty*frac);
        locxx = round(xi-shiftx*(1-frac));
        locyy = round(yi-shifty*(1-frac));
        % make sure all pixels stay within the array (use the clip.m code in the class directory)
        locx=clip(locx,1,512);
        locy=clip(locy,1,512);
        locxx=clip(locxx,1,512);
        locyy=clip(locyy,1,512);

        % alternatively, you can speed things up if you use the following matlab code that
        % takes advantage of built-in matlab functions
        final= p_1((locx(:)-1)*512+locy(:))*(1-frac) + p_2((locxx(:)-1)*512+locyy(:))*frac;
        %final= p_1((locx(:)-1)*512+locy(:))*(1-frac);

        final=reshape(final,512,512);
        figure;
        imshow(final,[min(min(final)) max(max(final))]); % but scale it properly
        M(k) = getframe;
    end

    figure;
    final = zeros(512,512);
    for k=1:11
        frac=(k-1)/10;
        % get the new locations of the pixels, moving the first image towards the second, and
        % the second towards the first
        locx = round(xi+shiftx*frac);
        locy = round(yi+shifty*frac);
        locxx = round(xi-shiftx*(1-frac));
        locyy = round(yi-shifty*(1-frac));
        % make sure all pixels stay within the array (use the clip.m code in the class directory)
        locx=clip(locx,1,512);
        locy=clip(locy,1,512);
        locxx=clip(locxx,1,512);
        locyy=clip(locyy,1,512); 

        % alternatively, you can speed things up if you use the following matlab code that
        % takes advantage of built-in matlab functions
        final= p_1((locx(:)-1)*512+locy(:))*(1-frac);

        final=reshape(final,512,512);
        figure;
        imshow(final,[min(min(final)) max(max(final))]); % but scale it properly
        M(k) = getframe;
    end

    v = VideoWriter(name + '.avi','Motion JPEG AVI'); %Name your video
    v.FrameRate = fps; %Set the frame rate to 25 frames per second
    open(v)
    writeVideo(v,M);
    close(v);
end


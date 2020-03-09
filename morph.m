pairs = ["3"; "4"; "5"; "6"; "7"; "8"; "10"; "11"; "12"; "13"; "16"; "17"; "19"; "20"];

for i=1:2:length(pairs)
    pairs(i)
    pairs(i+1)
    name1 = strcat(char(pairs(i)), '_out.jpg');
    name2 = strcat(char(pairs(i+1)), '_out.jpg');
    csv1 = strcat(char(pairs(i)), '.csv');
    csv2 = strcat(char(pairs(i+1)), '.csv');
    out_name = strcat('morph_', int2str(uint8(i / 2)));

    morph_images(strcat('images_processed/', name1), strcat('images_processed/', name2), strcat('images_processed/', csv1), strcat('images_processed/', csv2), strcat('out/', out_name))
end

function video = morph_images(img1_name, img2_name, img1_points, img2_points, out_name)
    img1=imread(img1_name);
    img2=imread(img2_name);
    
    %img1 = uint8(255 * img1 / max(max(img1, [], 1), [], 2));
    %img2 = uint8(255 * img2 / max(max(img2, [], 1), [], 2));
    img1 = uint8(img1);
    img2 = uint8(img2);
    
    img1_points = csvread(img1_points);
    img2_points = csvread(img2_points);
    X1 = [1; 1; 512; 512; img1_points(:, 1)];
    Y1 = [1; 512; 1; 512; img1_points(:, 2)];
    X2 = [1; 1; 512; 512; img2_points(:, 1)];
    Y2 = [1; 512; 1; 512; img2_points(:, 2)];

    X_diffs = X2 - X1;
    Y_diffs = Y2 - Y1;

    x=linspace(1,512,512);
    y=linspace(1,512,512);
    [xi,yi]=meshgrid(x,y);
    shiftx=-griddata(X1,Y1,X_diffs,xi,yi);
    shifty=-griddata(X1,Y1,Y_diffs,xi,yi);

    figure;
    colormap('gray')
    FRAMES=144;
    for k=1:FRAMES,
    frac=(k-1)/(FRAMES - 1);
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
    % now map the pixels to their new positions and blend
    %final = zeros(512,512, 3);
    for i=1:512,
        for j=1:512,
         final(j,i,:)=img1(locy(j,i),locx(j,i),:)*(1-frac) + img2(locyy(j,i),locxx(j,i),:)*frac;
        end;
    end;
    image(final);
    %test = getframe(gca);
    M(k) = im2frame(final);
    end;
    v = VideoWriter(out_name,'Motion JPEG AVI'); %Name your video
    v.FrameRate = 24;
    open(v)
    writeVideo(v,M);
    close(v);
end

function normalized = normalize(A)
    scale_factors = max(max(A, [], 1), [], 2);
    normalized = A;
    for i=1:3
        normalized(:,:,i) = normalized(:,:,i) / scale_factors(:,:,i);
    end
end

function clipped = clip(a, low, high) 
    a(a > high) = high;
    a(a < low) = low;
    clipped = a;
end

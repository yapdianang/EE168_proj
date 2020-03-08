%% capitol data
data = zeros(512, 512);
rad1 = 10;
rad2 = 45;
width = 50;
length = 150;
height1 = 50;
height3 = 120;
for x=1:512
    for y=1:512
        if abs(257 - x) < width && abs(257 - y) < length
            data(x, y) = height1;
        end
        radius = ((257 - x) ^ 2 + (257 - y) ^ 2) ^ 0.5;
        if radius < rad1
            data(x, y) = height3;
        elseif radius < rad2
            data(x, y) = height1 + 10 + (rad2 ^ 2 - radius ^ 2) ^ 0.5;
        end
    end
end

%figure;
%imshow(data / 255)

k = 1;
for angle=0:2:180
    data_rot = imrotate(data, angle, 'crop');
    data_rot = 255 - data_rot;
    relief = (conv2(data_rot, [1 -0.5; -0.5 0], 'same') + 1) ./ 2;
    relief(relief < -50) = -50;
    relief(relief > 50) = 50;
    relief = relief - min(min(relief));
    relief = relief / max(max(relief)) * 255;
    relief = relief .* (255 - data_rot + 128)/255;

    perspective = perspective_projection(data_rot, relief/255, 2000, 1500);
    imshow(perspective')
    M(k) = getframe;
    k = k + 1;
end
v = VideoWriter('flyby','MPEG-4'); %Name your video
v.FrameRate = 20;
open(v)
writeVideo(v,M);
close(v);

function returned = perspective_projection(im, sr, d, h)
 returned = zeros(size(im, 1), size(im, 2)) + 0.1;
 for i=1:size(im, 1)
 for j=1:size(im, 2)
 u = ceil((i*d)/(j+d));
 v = ceil(h + (im(i, j) - h)*d/(j+d));
 returned(u, v) = sr(i, j);
 end
 end
end
            
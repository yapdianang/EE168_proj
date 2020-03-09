img = imread('images_processed/6_out.jpg');
negated_img = 255 - img;

figure;
for k=1:100
    if (mod(idivide(k, uint8(10), 'floor'), 2) == 0)
        image(img);
    else
        image(negated_img);
    end
    M(k) = getframe;
end

v = VideoWriter('pete_negated','MPEG-4'); %Name your video
v.FrameRate = 24;
open(v)
writeVideo(v,M);
close(v);
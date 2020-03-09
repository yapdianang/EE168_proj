img1 = imread('images_processed/18_out.jpg');
img2 = imread('images_processed/booker_face.png');
img2 = imresize(img2, 0.25);
figure;
image(img1)

prev = img1(175:175+size(img2, 1)-1,240:240+size(img2, 2)-1,:); 
FRAMES=150;
for k=1:FRAMES
    frac=(k-1)/(FRAMES-1);
    new_img = img1;
    new_img(175:175+size(img2, 1)-1,240:240+size(img2, 2)-1,:) = (1-frac)*prev + frac.*img2;
    M(k) = im2frame(new_img);
end
v = VideoWriter('bunny','MPEG-4'); %Name your video
v.FrameRate = 24;
open(v)
writeVideo(v,M);
close(v);
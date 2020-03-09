% Eajer Toh 
% EE168 Flames Fading
close all; clear all; 
rourke = im2double(imread("11_out.jpg"));
flames = im2double(imread("flames.jpg"));

flames_1 = flames(24:535,300:811,:);
flames_2 = flames(24:535,400:911,:);

%{
figure;
imshow(flames_1)

figure;
imshow(flames_2)

figure;
imshow(rourke)
%}

numFrames = 175;
figure;
for i = 1:numFrames
    rourke_frac = ((numFrames+1-i)/numFrames);
    flames_frac = ((i-1)/numFrames);
    if mod(i,10) == 0 | mod(i,10) == 1 | mod(i,10) == 2 | mod(i,10) == 3 | mod(i,10) == 4
        final_image = (rourke_frac.*rourke) + (flames_frac.*flames_1);
    else
        final_image = (rourke_frac.*rourke) + (flames_frac.*flames_2);
    end
    imshow(final_image)
    M(i) = getframe;
end

v = VideoWriter('RourkeFlames','MPEG-4'); %Name your video
v.FrameRate = 25; %Set the frame rate to 25 frames per second
open(v)
writeVideo(v,M);
close(v);



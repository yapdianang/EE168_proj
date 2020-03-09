% Eajer Toh 
% EE168 Circshift
clear all; close all;
castro = im2double(imread("14_out.jpg"));
warren = im2double(imread("15_out.jpg"));

combined = [warren castro];
[row, cols] = size(castro);

numFrames = 150;
figure;
for i = 1:numFrames
    curr_start_col = 514-floor(i*(512/numFrames));
    imshow(combined(:,curr_start_col:curr_start_col+511,:))
    M(i) = getframe;
end

v = VideoWriter('CastroWarren','MPEG-4'); %Name your video
v.FrameRate = 25; %Set the frame rate to 25 frames per second
open(v)
writeVideo(v,M);
close(v);
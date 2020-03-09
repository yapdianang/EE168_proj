% Eajer Toh 
% EE168 High Pass/Low Pass Turn to Dust
%image_1 = im2double(imread('Castro.jpg'));
close all; clear all;
% Read in image
image_1 = im2double(imread("2_out.jpg"));

% Fourier transform of images and shift 
image_1_fft = fftshift(fft2(double(image_1)));

% Size of images
[rows, columns, numberOfColorChannels] = size(image_1);

% Create meshgrid
[x, y] = meshgrid(-rows/2:(rows/2)-1, -columns/2:(columns/2)-1);

% Create filters
magnitude = sqrt((x/(rows/2)).^2 + (y/(columns/2)).^2);

numFrames = 175;
max_val = 0.2
cutoff_lowpass = max_val-(max_val/numFrames):-max_val/numFrames:0;
cutoff_highpass = 0:max_val/numFrames:max_val-(max_val/numFrames);
image_1_filtered = zeros(size(image_1_fft));
figure;
for i = 1:numFrames
    %filter_lowpass = double(magnitude <= cutoff_lowpass(i));
    filter_highpass = double(magnitude >= cutoff_highpass(i));

    for z = 1:numberOfColorChannels
        image_1_filtered(:,:,z) = image_1_fft(:,:,z) .* filter_highpass;
    end   
    final_image_1 = abs(ifft2(ifftshift(image_1_filtered)));
    imshow(final_image_1)
    M(i) = getframe;
end
v = VideoWriter('KoblucharHighPass','MPEG-4'); %Name your video
v.FrameRate = 25; %Set the frame rate to 25 frames per second
open(v)
writeVideo(v,M);
close(v);


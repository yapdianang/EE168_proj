%% Display
img = rgb2gray(imread('warren.jpg'));
points = csvread('warren.csv');

imshow(img)
hold on
for i=1:68
    plot(points(i, 1), points(i, 2), 'ro', 'MarkerSize', 2);
end
hold off

%% capitol data
data = zeros(512, 512);
rad1 = 10;
rad2 = 45;
width = 50;
length = 150;
height1 = 50;
height2 = 150;
height3 = 160;
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

figure;
imshow(data / 255)
            
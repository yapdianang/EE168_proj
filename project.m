img = rgb2gray(imread('warren.jpg'));
points = csvread('warren.csv');

imshow(img)
hold on
for i=1:68
    plot(points(i, 1), points(i, 2), 'ro', 'MarkerSize', 2);
end
hold off

img = rgb2gray(imread('images_square/warren_out.jpg'));
points = csvread('warren.csv');

imshow(img)
hold on
for i=1:1
    plot(points(i, 1), points(i, 2), 'ro', 'MarkerSize', 2);
end
hold off
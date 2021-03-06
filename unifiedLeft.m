
pairs = ["3"; "4"; "5"; "6"; "7"; "8"; "10"; "11"; "12"; "13"; "16"; "17"; "19"; "20"];

lefftr = zeros(512, 512);
lefftg = zeros(512, 512);
lefftb = zeros(512, 512);

for i=1:2:length(pairs)
    name1 = strcat(char(pairs(i)), '_out.jpg');
    name1 = strcat('images_processed/', name1);
    name2 = strcat(char(pairs(i+1)), '_out.jpg');
    name2 = strcat('images_processed/', name2);
    
    im1 = imread(name1);
    im2 = imread(name2);
    
    r1 = im1(:, :, 1);
    g1 = im1(:, :, 2);
    b1 = im1(:, :, 3);
    r2 = im2(:, :, 1);
    g2 = im2(:, :, 2);
    b2 = im2(:, :, 3);
    
    lefftr = lefftr + fft2(fftshift(r1)) + fft2(fftshift(r2));
    lefftg = lefftg + fft2(fftshift(g1)) + fft2(fftshift(g2));
    lefftb = lefftb + fft2(fftshift(b1)) + fft2(fftshift(b2));
end

r = real(fftshift(ifft2(lefftr/14)));
avg = mean(r, 'all');
stdev = std2(r);
r = rescale((r - avg).*140./stdev+60);

g = real(fftshift(ifft2(lefftg/14)));
avg = mean(g, 'all');
stdev = std2(g);
g = rescale((g - avg).*140./stdev+60);

b = real(fftshift(ifft2(lefftb/14)));
avg = mean(b, 'all');
stdev = std2(b);
b = rescale((b - avg).*140./stdev+60);

theUnifiedLeft = cat(3, r, g, b);

theTrueLeft = rescale(im2double(imread('images/theTrueLeft.png')));

fade(theUnifiedLeft, theTrueLeft, "Final_Vid_Clips/theTrueLeft", 5);

image(theUnifiedLeft)
M = im2frame(theUnifiedLeft);
imwrite(M.cdata, 'out/UnifiedLeft.jpg');

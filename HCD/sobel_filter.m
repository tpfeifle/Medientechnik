function [Iu, Iv] = sobel_filter(image)

dx = [1 0 -1; 2 0 -2; 1 0 -1];
dy = [1 2 1; 0 0 0 ; -1 -2 -1];

image = im2double(image);

Iu = imfilter(image, dx);
Iv = imfilter(image, dy);

end


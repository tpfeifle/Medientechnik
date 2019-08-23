function [] = Main()

% select image to apply the HCD on
image = imread('lena.jpg');


% paramters for the HCD
k=0.04;

filter_size = input('Input the `filter size` in pixels (Default: 4): ');
if isempty(filter_size)
    filter_size = 4;
end

theta = input('Input the `threshold` (Default: 40): ');
if isempty(theta)
    theta = 40;
end

min_feature_dist = input('Input the `feature distance` (Default: 10): ');
if isempty(min_feature_dist)
    min_feature_dist = 10;
end

% with the input now run the harris-detector
harris_detector(image, filter_size, k, theta, "do_plot", min_feature_dist);

end


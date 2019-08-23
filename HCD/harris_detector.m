function [] = harris_detector(img, varargin)

% varargin consists of:
% 1. segment_length: filtersize in pixels
% 2. priority k: how edges and vertices get prioritized
% 3. theta: threshold to decide that it's an edge
% 4. do_plot: if given print the image with the detected features
% 5. min_dist: minimal distance between 2 found features

parameters = {4,0.04,40,"do_plot",10}; %default parameters
parameters(1:(nargin-1)) = varargin;
filter_size = parameters{1};
k = parameters{2};
threshold = parameters{3};
do_plot = parameters{4};

% dont allow min-distance of 0 --> min-distance of 1 results in the
% same, but else the step-size in this function makes problems
if parameters{5} ~= 0
    min_dist = parameters{5};
else
    min_dist = 1;
end

image_gray = rgb2gray(img);

fprintf("[+] Applying Sobel-Filter \n");
[Iu, Iv] = sobel_filter(image_gray);

% process further
Iu2 = Iu.^2;
Iv2 = Iv.^2;
Iuv = Iu.*Iv;

H = zeros(size(img, 1), size(img, 2));


% calculating Harris-Criterium with filter
fprintf("[+] Calculating Harris-Criterium with: filter-size=" + string(filter_size) + ", k=" + k + "\n");
offset = floor(filter_size/2);
for x = filter_size+1:size(img,2)-(filter_size+1)
    for y = filter_size+1:size(img,1)-(filter_size+1)
        
        % from lecture
        Iu_window = Iu2(y-offset:y+offset,x-offset:x+offset);
        Iv_window = Iv2(y-offset:y+offset,x-offset:x+offset);
        Iuv_window = Iuv(y-offset:y+offset,x-offset:x+offset);
        
        % calculating Q-matrix
        Q = [sum(Iu_window(:)), sum(Iuv_window(:)); 
             sum(Iuv_window(:)), sum(Iv_window(:))];
        
        H(y,x) = det(Q) - (k * trace(Q)^2);
       
    end
end


fprintf("[+] Applying the threshold=" + string(threshold) + " and the minimimal-distance of " + string(min_dist) + " between features \n");

% list of features
x_score = [];
y_score = [];

offset = floor(min_dist/2);
for x = offset+1:min_dist:size(img,2)-(offset+1)
    for y = offset+1:min_dist:size(img,1)-offset(+1)
        % find maximum in the sliding-window
        window = H(y-offset:y+offset,x-offset:x+offset);
        maxValue = max(window(:));
        
        if maxValue > threshold
            [row, col] = find(window == maxValue, 1, 'first'); 
            % append the found feature to the list of features
            x_score = [x_score; y-offset+row];
            y_score = [y_score; x-offset+col];
        end
    end
end

% display the image with the features found by HCD
if do_plot ~= ""
    fprintf("[+] Displaying found features \n");
    imshow(img);
    hold on;
    plot(x_score,y_score,'r+', 'MarkerSize', 5);
end

fprintf("DONE \n");

end


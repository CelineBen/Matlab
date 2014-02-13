% Final Project - Interest Points Detection and Image Matching
% Author: Céline Bensoussan & Jill Perreault 
% Course: Computer Vision
% Date: April 15, 2013

function theta = gradientOrientation(im, sigma)
% GRADIENT ORIENTATION: Calculate the direction angle of the gradient (orientation)
%
%   theta = gradient(im, sigma)
%
%   INPUT ARGUMENTS
%   im    - the image to analyse
%   sigma - the standard deviation
%
%   OUTPUT ARGUMENTS
%   theta - a matrix the size of the image with the direction of the angle
%           at each pixel
%

im = double(im);
n = 2*ceil(sigma) + 1;

%Set up size of mask
[x, y] = meshgrid((-n+1)/2 : (n-1)/2, (-n+1)/2 : (n-1)/2);

% Evaluation of coutour in X
maskX = (-x ./ (2 * pi * sigma.^4)) .* exp(-(x.^2 + y.^2) / (2*sigma.^2));
contourX = imfilter(im, maskX);

% Evaluation of countour in Y
mask = (-y ./ (2 * pi * sigma.^4)) .* exp(-(x.^2 + y.^2) / (2*sigma.^2));
contourY = imfilter(im, mask);

% Calculate the direction angle of the gradient (orientation)
theta = atan2(contourX, contourY);

end
% Final Project - Interest Points Detection and Image Matching
% Author: Céline Bensoussan & Jill Perreault 
% Course: Computer Vision
% Date: April 15, 2013

function filtered = gaussFilter(image, sigma)
% GAUSS FILTER
%   filtered = gaussFilter(image, sigma)
%   Generates and applies a Gaussian filter on a given image with 
%   a given standard deviation ? > 0
%
%   INPUT ARGUMENTS
%   image    - the image to be filtered
%   sigma    - the standard devation
%
%   OUTPUT ARGUMENTS
%   filtered - the filtered image

% Set up size of mask
n = 6*ceil(sigma) + 1;
[x, y] = meshgrid((-n+1)/2 : (n-1)/2, (-n+1)/2 : (n-1)/2);

% Evaluation of 2D Gaussian
mask = 1 / (2 * pi * sigma.^2) * exp(-(x.^2 + y.^2) / (2*sigma.^2));

% Normalize
mask = mask ./ sum(mask(:));

% Apply mask on image
filtered = imfilter(image, mask);

        

% Final Project - Interest Points Detection and Image Matching
% Author: Céline Bensoussan & Jill Perreault 
% Course: Computer Vision
% Date: April 15, 2013

%% Initialization
clear; close all; clc;

% The two pairs work fine for both Corners Detection & Image Matching
s1 = imread('shapes.pgm');
s2 = imread('shapes3.pgm');

obj1 = imread('objects.jpg');
obj2 = imread('objects2.pgm');

% These images work fine with Corners Detection
trevi1 = imread('trevi1.pgm');
a1 = imread('artificialTest.gif');
b1 = imread('blocksTest.gif');

% Pick the pair of image you want to test it on
im1 = obj1;
im2 = obj2;
sigma = 1;

% n is the number of corner points wanted
n = 30;

% disp is a flag (0 or 1) indicating whether you want to display the n
% corner points overlaid on the original images.
disp = 1;      

%% Harris Corner Detector

%[r1, c1, harris1] = harrisCornerDetector(im1, sigma, n);
[r1, c1, harris1] = harrisCornerDetector(im1, sigma, n, disp);

%Shows the Harris Corner Response map
f2 = figure;imshow(uint8(harris1));title('im1 Harris Corner Response Map')

%% Image matching
[ f3 ] = imageMatching(im1, im2, sigma, n, disp);


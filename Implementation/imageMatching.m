% Final Project - Interest Points Detection and Image Matching
% Author: Céline Bensoussan & Jill Perreault 
% Course: Computer Vision
% Date: April 15, 2013

function [ fig, match ] = imageMatching(im1, im2, sigma, n, disp)
% IMAGE MATCHING: matches interest points in two images
%   [ fig, match ] = imageMatching(im1, im2, sigma, n, disp)
%                                                        \
%                                                      optional
%   [ fig, match ] = imageMatching(im1, im2, sigma, n)
%
%   INPUT ARGUMENTS
%   im1     - image to analyse
%   im2     - image to analyse
%   sigma   - the standard deviation ( 0 - 1.5 )
%   n       - the number of desired corner points
%   disp    - optional flag (0 or 1) indicating whether you want to display
%             the harris corners overlayed on the original images.
%             DEFAULT: disp = 0.
%
%   returns match (a Nx4 matrix where N >=M)
%   match(:,1) and match(:,2) correspond to the y and x coordinate values
%   of a matched point in im1 respectively; match(:,3) and match(:,4)
%   correspond to the y and x coordinate values of a matched point in im2
%   respectively.
%
%   The function computes SIFT descriptors for each interest point. SSD of
%   the descriptors was used to find the best matches.



% check input variables
% if not specified otherwise use defaults
if ( nargin < 5 || isempty(disp) )
    disp = 0;
end

% get interest points
[r1, c1] = harrisCornerDetector(im1, sigma, n, disp);
[r2, c2] = harrisCornerDetector(im2, sigma, n, disp);

% initialization of storage space of descriptors
% descriptors_im# will hold descriptors of interest points of image #.
descriptors_im1 = zeros(8,16*n);
descriptors_im2 = zeros(8,16*n);

im1_pad = padarray(im1,[8 8],'replicate');
im2_pad = padarray(im2,[8 8],'replicate');

% compensate for padding of images
rr1 = r1+8;
cc1 = c1+8;
rr2 = r2+8;
cc2 = c2+8;

% Creation of SIFT Descriptors (window size is 16)
for i = 1:numel(r1)
    %Descriptors for interest points in image 1
    window = im1_pad(rr1(i)-8:rr1(i)+7, cc1(i)-8:cc1(i)+8);
    theta = gradientOrientation(window,sigma);
    d = getDescriptor(theta);
    descriptors_im1(1:8,((i-1)*16+1):(i*16)) = d;
end
for i = 1:numel(r2)
    %Descriptors for interest points in image 2
    window2 = im2_pad(rr2(i)-8:rr2(i)+7, cc2(i)-8:cc2(i)+8);
    theta2 = gradientOrientation(window2,sigma);
    d2 = getDescriptor(theta2);
    descriptors_im2(1:8,((i-1)*16+1):(i*16)) = d2;
end

[ indecies1, indecies2 ] = getCorrelations(descriptors_im1,descriptors_im2, n);

match = zeros(numel(r1),4);

count = 1;
for i = 1:numel(r1)
   if( indecies2(indecies1(i,1),1) == i )
       match(count,1) = r1(i);
       match(count,2) = c1(i);
       match(count,3) = r2(indecies1(i,1));
       match(count,4) = c2(indecies1(i,1));
       count = count + 1;
   elseif ( indecies2(indecies1(i,2),1) == i )
       match(count,1) = r1(i);
       match(count,2) = c1(i);
       match(count,3) = r2(indecies1(i,2));
       match(count,4) = c2(indecies1(i,2));
       count = count + 1;       
   end
end

% transform match into input of match_plot function
points1(:,1) = match(:,2);
points1(:,2) = match(:,1);
points2(:,1) = match(:,4);
points2(:,2) = match(:,3);

% match_plot is created by Li Yang Ku, the function and its license can be found in the
% borrowed_functions directory.
fig = match_plot(im1,im2,points1,points2);

end




        
        

    
    
    
        
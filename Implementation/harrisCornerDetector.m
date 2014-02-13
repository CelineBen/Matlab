% Final Project - Interest Points Detection and Image Matching
% Author: Céline Bensoussan & Jill Perreault 
% Course: Computer Vision
% Date: April 15, 2013

function [r, c, harris] = harrisCornerDetector(im, sigma, n, disp)
% HARRIS CORNER DETECTOR: detects n interest points of an image
%
%   [fig, r, c, harris] = harrisCornerDetector(im, sigma, n, disp)
%                                                              \
%                                                             optional
%   [fig, r, c, harris] = harrisCornerDetector(im, sigma, n)
%
%   INPUT ARGUMENTS
%   im      - image to analyse
%   sigma   - the standard deviation ( 0 - 1.5 )
%   n       - the number of desired corner points
%   disp    - optional flag (0 or 1) indicating whether you want to display
%             the n corner points overlaid on the original image.
%             DEFAULT: disp = 0.
%
%   OUTPUT ARGUMENTS
%   fig     - figure displaying corners overlayed on the original image.
%   r       - the row coordinates of the corner points
%   c       - the column coordinates of the corner points
%   harris  - map of Nobel's Corner Response prior to non-maximal
%             suppression and thresholding.


% check input variables
% if not specified otherwise use defaults
if ( nargin < 4 || isempty(disp) )
    disp = 0;
end

% We pad the image before processing it to not find interest points in the
% corners of the image
psize = 1; % pad size
pad_im = padarray(im,[psize psize], 'replicate');

% get the partial derivatives of the image using function
% derivative7 by Peter Kovesi.
[Ix, Iy] = derivative7(pad_im, 'x', 'y');

% Compute products of derivatives
Ix2 = gaussFilter(Ix.^2,  sigma);
Iy2 = gaussFilter(Iy.^2,  sigma);    
Ixy = gaussFilter(Ix.*Iy, sigma);

% Harris' Corner Response
%k = 0.04;
%cim = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;

% Nobel's Corner Measure (sometimes gives a better result)
harris = 2*(Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2 + eps);

% eliminate edges (response < 0)
harris(harris<0) = 0;

% get local maximas 
bin_im = imregionalmax(harris); % get logical map of local maximas
corners = bin_im.*harris; % get local maximas with actual intensities

% compensate for earlier image padding
[M, N] = size(harris);
harris = harris(psize+1:M-psize,psize+1:N-psize);
corners = corners(psize+1:M-psize,psize+1:N-psize);
[M, N] = size(corners);

% get n best corner points
c_vector = reshape(corners,1,M*N); % transform matrix into vector for sorting
c_vector = sort(c_vector,'descend'); % sort responses in decreasing order
% set threshold to nth best corner response if it exists.
if( c_vector(n) ~= 0 )
    T = c_vector(n);
else
    c_vector = c_vector( c_vector > 0 );
    S = size( c_vector );
    str = sprintf('Only %.0f corners were found\n',S(2));
    fprintf(str);
    T = c_vector(S(2));
end
corners(corners<T)=0; % threshold corner points.
[ r, c ] = find(corners); % find row and column coordinates.

% Plot the corners with red crosses on the original image.
% Shown only if disp is set to 1.
fig = figure('visible','off');
imshow(im,[]); hold on      
plot(c,r,'r+'), title('corners detected');
hold off

if ( disp == 1 )
    set(fig,'visible','on');
end

end

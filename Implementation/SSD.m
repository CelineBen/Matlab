% Final Project - Interest Points Detection and Image Matching
% Author: Céline Bensoussan & Jill Perreault 
% Course: Computer Vision
% Date: April 15, 2013

function SSD_table = SSD(d_im1, d_im2, M)
% SSD: Generates the sum of the squared difference of all descriptors of all
%   points from image1 and image2
%
%   SSD_table = SSD(d_im1, d_im2, M)
%
%   INPUT ARGUMENTS
%   d_im1 - all the descriptors of the interest points of image 1
%           (therefore we have 16*M columns in d_im1)
%   d_im2 - all the descriptors of the interest points of image 2
%           (therefore we have 16*M columns in d_im2)
%   M     - the number of interest points 
%
%   OUTPUT ARGUMENTS
%   SSD_table -  a matrix with all the SSD values
%                SSD(i,j) = the value of comparing the descriptors of
%                point i in image 1 and point j in image 2
%

SSD_table = zeros(M);

for x = 1:M
    % Gets the 16 descriptors from one interest point in the d_im1 
    d1 = d_im1(1:8, ((x-1)*16+1):x*16); 
    for y = 1:M
        % Gets the 16 descriptors from one interest point in the d_im2
        d2 = d_im2(1:8, ((y-1)*16+1):y*16);
        sum = 0;
        for i = 1:8
            for j = 1:16
                %Calculates the sum of squared differences of the 16
                %descriptors of point x in image 1 and the 16 descriptors
                %of point y in image 2
                sum = sum + (d1(i,j) - d2(i,j))^2;
            end
        end
        SSD_table(x,y) = sum;
    end
end

end

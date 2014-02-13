function [ indices1, indices2 ] = getCorrelations(descriptors_im1,descriptors_im2, M)
% GET CORRELATIONS: finds the best matches using the SSD of each interest
% point in image 1 with each interest point in image 2, using the
% descriptors of each image.
%
% [ indices1, indices2 ] = getCorrelations(descriptors_im1,descriptors_im2, M)
%
%   INPUT ARGUMENTS
%   descriptors_im1 - all the descriptors of the interest points of image 1
%                     (therefore we have 16*M columns in d_im1)
%   descriptors_im2 - all the descriptors of the interest points of image 2
%                     (therefore we have 16*M columns in d_im2)
%   M               - the number of interest points 
%
%   OUTPUT ARGUMENTS
%   indices1        - an Mx2 matrix.
%                     indices1(:,1) indices of points with best SSD (from image 1 to image 2)
%                     indices1(:,2) indices of points with second best SSD (from image 1 to image 2)
%   indices2        - an Mx2 matrix.
%                     indices2(:,1) indices of points with best SSD (from image 2 to image 1)
%                     indices2(:,2) indices of points with second best SSD (from image 2 to image 1)
%   

SSD_table1 = SSD(descriptors_im1,descriptors_im2,M);
SSD_table2 = SSD(descriptors_im2,descriptors_im1,M);


indices1 = zeros(M,2);
indices2 = zeros(M,2);
for i = 1:M
    smallest1 = SSD_table1(i,1);
    smallest2 = SSD_table2(i,1);
    index1 = 1; 
    sub_index1 = 1;
    index2 = 1; 
    sub_index2 = 1;
    for j = 2:M
        if SSD_table1(i,j) < smallest1
            smallest1 = SSD_table1(i,j);
            sub_index1 = index1;
            index1 = j;
        end
        if SSD_table2(i,j) < smallest2
            smallest2 = SSD_table2(i,j);
            sub_index2 = index2;
            index2 = j;
        end
    end
    indices1(i, 1) = index1; % index of point with best SSD (from image 1 to image 2)
    indices1(i, 2) = sub_index1; % index of point with second best SSD (from image 1 to image 2)
    indices2(i, 1) = index2; % index of point with best SSD (from image 2 to image 1)
    indices2(i, 2) = sub_index2; % index of point with second best SSD (from image 2 to image 1)
end

end


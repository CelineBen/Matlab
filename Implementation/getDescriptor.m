function descriptor = getDescriptor(theta)
% GET DESCRIPTOR: Generates the 16 descriptors of a 16x16 window given only the 
% values of the orientation of the gradient of its pixels
%
%   descriptor = getDescriptor(theta)
%
%   INPUT ARGUMENTS
%   theta - the values of the orientation of the gradient of the pixels of
%   the 16x16 window
%
%   OUTPUT ARGUMENTS
%   descriptor: a 8x16 matrix of 16 vertical histograms of the gradient values
%       1st row = count from -pi to -3pi/4
%       2nd row = count from -3pi/4 to -pi/2
%       3rd row = count from -pi/2 to -pi/4
%       4th row = count from -pi/4 to 0
%       5th row = count from 0 to pi/4
%       6th row = count from pi/4 to pi/2
%       7th row = count from pi/2 to 3pi/4
%       8th row = count from 3pi/4 to pi
%

descriptor = zeros(8,16);
count = 1;
for i = 1:4:16
    for j = 1:4:16
        for x = 0:3
            for y = 0:3
                if theta(i+x,j+y) < (-3*pi/4)
                    descriptor(1, count) = descriptor(1, count) + 1;
                elseif theta(i+x,j+y) < (-pi/2)
                    descriptor(2, count) = descriptor(2, count) + 1;
                elseif theta(i+x,j+y) < (-pi/4)
                    descriptor(3, count) = descriptor(3, count) + 1;
                elseif theta(i+x,j+y) < 0
                    descriptor(4, count) = descriptor(4, count) + 1;
                elseif theta(i+x,j+y) < (pi/4)
                    descriptor(5, count) = descriptor(5, count) + 1;
                elseif theta(i+x,j+y) < (pi/3)
                    descriptor(6, count) = descriptor(6, count) + 1;
                elseif theta(i+x,j+y) < (3*pi/4)
                    descriptor(7, count) = descriptor(7, count) + 1;
                else
                    descriptor(8, count) = descriptor(8, count) + 1;
                end
                
            end
        end
        count = count + 1;
    end
end
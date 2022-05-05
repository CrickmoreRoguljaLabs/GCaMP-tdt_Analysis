function [myMask]= getROI(imageName, pathname)
%% References
%https://www.mathworks.com/help/images/ref/images.roi.assistedfreehand.draw.html#mw_a4b4b3bf-eff0-450a-a4be-1b24aeffe90a
%https://www.mathworks.com/help/images/ref/poly2mask.html

%% Go to the folder where the images is contained

originalpath = pwd;

if nargin > 1
    cd(pathname);
end 

%% Import image into MATLAB
inputImage = imread(imageName); %import image
figure
imshow(inputImage) %displays the image

%% Ask user to select the ROI

%allows the user to draw points that connect to form a polygon that will be the ROI
p = drawpolygon('LineWidth',5,'Color','cyan');

%% Create a mask from the ROI
myMask = poly2mask(p.Position(:,1),p.Position(:,2),size(inputImage,1),size(inputImage,2));

%% Save the ROI mask
% Use if you are using this independently

%x = input('Name the mask file.');
%save(x,'bw');

%% Go back to the original directory

cd(originalpath);

%% Close the figure 
close

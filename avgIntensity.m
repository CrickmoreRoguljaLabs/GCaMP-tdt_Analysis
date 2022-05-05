function [meanValue]= avgIntensity(imageName,maskName,pathname)
%% References

%% Go to the folder where the images is contained

originalpath = pwd;

if nargin > 1
    cd(pathname);
end 

%% Load Image and Mask
inputImage = imread(imageName); %import image

%% if using independently:
% mask = load(maskName); %import mask (if it's saved separately)
% mask = mask.bw; %extract logical

%% Get the average intensity
meanValue = mean(inputImage(maskName));

%% Return to original path
cd(originalpath);
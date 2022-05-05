%% BatchNormalizedIntensity.m
% The goal of this code is to calculate the normalized intensity for a
% series of images where:
% Normalized fluorescence =(GCaMP_ROI - GcaMP6s_background)/(tdTomato_ROI - tdTomato_background)

% You must put this code and the required functions in the same folder as
% your images
%% Get directory

% Get the folder containing the blinded tiffs
pathname = uigetdir;

%% Extract information about the images

% Get the list of the tif files in the folder
contents = dir( fullfile( pathname , '*.tif' ) );

% Get the file names
filenames = { contents.name }';

% Count the number of files
nfiles = length( filenames );

% The number of files is 2 x the number of original images (because each
% image contained 2 channels which have now been split into separate tiffs)
% Count the number of distinct image sets
nSets = nfiles/2;

%% Data Storage

% Set up an empty cell to contain the sorted data
myData = cell( nSets , 11 );

% The data cell will be set up such that:
% Column 1 = the red images names
% Column 2 = the green images names
% Column 3 = logical for the image ROI
% Column 4 = logical for the image background
% Column 5 = avg intensity in green ROI
% Column 6 = avg intensity in green background
% Column 7 = background corrected green intensity
% Column 8 = avg intensity in red ROI
% Column 9 = avg intensity in red background
% Column 10 = background corrected red intensity
% Column 11 = normalized intensity

%% Sort images into green or red channels

% set up counters for sorting (this is used for indexing into the new cell
% array)
redi = 1;
greeni = 1;

% Sort files into the new cell
for i = 1 : nfiles % for all the file
    if contains(filenames{i}, 'red') % if the name contains the word red
        myData{redi, 1} = filenames{i}; % add that filename to the red column
        redi = redi + 1; % increase the counter so the next red file goes to the next row
    elseif contains(filenames{i}, 'green') % if the name contains the word green
        myData{greeni, 2} = filenames{i}; % add that filename to the green column
        greeni = greeni + 1; % increase the counter so the next green file goes to the next row
    else
        warning('A file was unable to be sorted') % throw a warning if something does not contain red or green
    end
end 
    
%% Sorting Check

% this quickly checks that in the sortednames cell, for each row the red
% image and the green image came from the same orginial image

% it does this by removing the red or green that was appended to the file
% name via the fiji code, then checking that without that, the filenames
% match 
for i = 1:nSets
 redtest = erase(myData{i,1}, 'red');
 greentest = erase(myData{i,2}, 'green');
 if redtest ~= greentest 
     warning ('Image sets were matched improperly')
 end 
end 
% it will throw an error if the filenames do not match
% if you get this error, just sort the filenames alphabetically in the
% folder then rerun the code
 
%% Get ROIs

% for each image set 
for i = 1:nSets 
    
% Use the tdtomato (red) channel to select an ROI
% Create a mask for the ROI
% Store it in the cell array
    myData{i,3} = getROI(myData{i,1},pathname);

% Use the tdtomato(red) channel to select a background area
% Create a mask for the background
    myData{i,4} = getROI(myData{i,1},pathname);
end 

%% Analyze
for i = 1:nSets 
% For the GCaMP (green) channel:
% Get the average intensity within the ROI
    myData{i,5} = avgIntensity(myData{i,2},myData{i,3},pathname);
% Subtract the average intensity in the background area
    myData{i,6} = avgIntensity(myData{i,2},myData{i,4},pathname);
    myData{i,7} = myData{i,5} - myData{i,6};
    
% For the tdtomato (red) channel:
% Get the average intensity within the ROI
    myData{i,8} = avgIntensity(myData{i,1},myData{i,3},pathname);
% Subtract the average intensity in the background area 
    myData{i,9} = avgIntensity(myData{i,1},myData{i,4},pathname);
    myData{i,10} = myData{i,8} - myData{i,9};
% Calculate the normalized intensity by dividing the results
    myData{i,11} = myData{i,7}/myData{i,10};

% Repeat for all images in the directory
end 

%% Save the intensities
originalpath = pwd; % gets the path your currently in
cd pathname % switches to where your images are stored
save myData.mat myData % saves the myData cell array in that folder
cd originalpath % switches you back to where your scripts are
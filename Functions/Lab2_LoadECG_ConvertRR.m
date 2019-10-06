%% Import Data
% Import both sets of data, detrend and create the time signals
clear variables       
close all

% Set the filename path  
filename = 'record1.csv';
% Open the file to read
fileID = fopen(filename,'r');
% Read in the data to cell array 
dataArray = textscan(fileID, '%s%f%[^\n\r]', 'Delimiter', '\t', 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,1);
% Close file
fclose(fileID);
% Convert the first cell of strings into a date
Date_resting = datetime(dataArray{:,1},'InputFormat','dd/MM/yyyy HH:mm:ss.SSSSSS');
% Create a time duration in milliseconds 
t_resting = milliseconds(Date_resting-Date_resting(1));
% Detrend the recorded data stored the second cell to remove the offset
ECG_resting = detrend(dataArray{:,2});
% Check the length of the time vector (there may be an extra sample)
if length(t_resting) > length(ECG_resting)
    t_resting = t_resting(1:end-1);
end
% Clear the unneeded variables
clear filename fileID dataArray

% Repeat for the other data set
% Set the filename path
filename = 'record2.csv';
% Open the file to read
fileID = fopen(filename,'r');
% Read in the data to cell array 
dataArray = textscan(fileID, '%s%f%[^\n\r]', 'Delimiter', '\t', 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,1);
% Close file
fclose(fileID);
% Convert the first cell of strings into a date
Date_postEx = datetime(dataArray{:,1},'InputFormat','dd/MM/yyyy HH:mm:ss.SSSSSS');
% Create a time duration in milliseconds 
t_postEx = milliseconds(Date_postEx-Date_postEx(1));
% Detrend the recorded data stored the second cell to remove the offset
ECG_postEx = detrend(dataArray{:,2});
% Check the length of the time vector (there may be an extra sample)
if length(t_postEx) > length(ECG_postEx)
    t_postEx = t_postEx(1:end-1);
end
% Clear the unneeded variables
clear filename fileID dataArray ans

%% Extract RR Intervals
% Use the ECG_to_RRI function to convert your ECG data to RR intervals

% Input your first data 
% When you run this you will get a figure showing the identified R peaks
% It will also ask you if you are happy with the options, you will have to
% decide if any peaks have been missed and adjust accordingly
%
%   ampthresh   - is the amplitude threshold which is marked on the graph
%   timethresh  - is the time threshold specifying how far apart the R peaks
%                   should be the default is 0.4
%   sign        - allows you to flip the sign of the data 
%                   (you shouldn't need this)
%
% After adjusting the thresholds the code will then identify any remaining
% anomalies in the data and ask you about these 
%(useful if you can't detect every peak accurately using the thresholds)
[RRI_resting,fsRRI] = ECG_to_RRI(ECG_resting,500);

% Save any figures produced from this data to use in your report using
% savefig
% Adjust these according to how many figures you have and how many you want
% for your report - this will save you having to go through this every time
savefig(figure(1),'InitialRestingRR.fig');
savefig(figure(2),'AmpCorrectRestingRR.fig');
savefig(figure(3),'TimeCorrectRestingRR.fig');
savefig(figure(4),'RestingRRI.fig');

% Repeat with your second data set
[RRI_postEx,~] = ECG_to_RRI(ECG_postEx,500);
savefig(figure(5),'InitialPostExRR.fig');
savefig(figure(6),'AmpCorrectPostExRR.fig');
savefig(figure(7),'TimeCorrectPostExRR.fig');
savefig(figure(8),'PostExRRI.fig');

% Now save your RR data to allow you to perform your analysis for your
% report
save('RR_Data.mat');



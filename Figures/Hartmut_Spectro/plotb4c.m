clear all
%% Initialize variables.
filename = 'C:\Users\Romain\Documents\Thèse\these\Figures\Hartmut_Spectro\b4c2.txt';
delimiter = ',';
startRow = 2;

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
E = dataArray{:, 1};
R = dataArray{:, 2};


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% 
[E2,a,b] = unique(E);
R2 = R(a);
figure(1)
clf
plot(E2,R2)
hold on

E3 = linspace(min(E2),max(E2),200);
R3 = interp1(E2,R2,E3);
R3 = smooth(R3);
plot(E3(1:2:end),R3(1:2:end),'-o')

a=gca;
a.XMinorTick = 'on';
a.YTick = 0.1:0.1:0.4;
a.YMinorTick = 'on';
% 30:10:250;
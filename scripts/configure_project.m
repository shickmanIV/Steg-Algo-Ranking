% configure_project.m
% --------------------

% Should change reset once project is more concrete.
clearvars -except projectRoot;

% Locate the project root dynamically
scriptPath = fileparts(mfilename('fullpath')); % Path to this script
projectRoot = fileparts(scriptPath);          % One level up

% Shortcuts for input/output locations
dataFolder = fullfile(projectRoot, 'data');
inputFolder = fullfile(dataFolder, 'input');
outputFolder = fullfile(dataFolder, 'output');

% Verify images folder exists
imagesFolder = fullfile(inputFolder, 'images');

% Verify critical file exists
fileName = '480-360-sample.jpg'; % Example: Hardcoded file name
imageFilePath = fullfile(projectRoot, 'data', 'input', 'images', '480-360-sample.jpg');

% Output the configured paths (optional)
disp('Project paths configured:');
disp(['Root: ', projectRoot]);
disp(['Data folder: ', dataFolder]);
disp(['Input folder: ', inputFolder]);
disp(['Image file path: ', imageFilePath]);
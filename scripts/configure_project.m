% configure_project.m
% --------------------

% Should change reset once project is more concrete.
clearvars -except projectRoot;

datasetNames = {
    'ALASKA_v2_JPG_256_QF100_GrayScale';
    'ALASKA_v2_JPG_256_QF90_GrayScale';
    'ALASKA_v2_JPG_256_QF80_GrayScale';
    'ALASKA_v2_JPG_512_QF100_GrayScale';
    'ALASKA_v2_JPG_512_QF90_GrayScale';
    'ALASKA_v2_JPG_512_QF80_GrayScale'
};

% The images to be pulled from each dataset
imageIndices = 1:30;
imageIndices = imageIndices * 1000;

% Locate the project root dynamically
scriptPath = fileparts(mfilename('fullpath')); % Path to this script
projectRoot = fileparts(scriptPath); % One level up

% Shortcuts for input/output locations
dataFolder = fullfile(projectRoot, 'data');
inputFolder = fullfile(dataFolder, 'input');
outputFolder = fullfile(dataFolder, 'output');

% Output the configured paths (optional)
disp('Project paths configured:');
disp(['Root: ', projectRoot]);
disp(['Data folder: ', dataFolder]);
disp(['Input folder: ', inputFolder]);
disp(['Output folder: ', outputFolder]);
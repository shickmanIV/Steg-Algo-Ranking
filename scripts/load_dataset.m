
% Default list of ALASKAv2 datasets if none already defined.
if ~exist("datasetNames", "var")
    datasetNames = {
        'ALASKA_v2_JPG_256_QF100_GrayScale';
        'ALASKA_v2_JPG_256_QF90_GrayScale';
        'ALASKA_v2_JPG_256_QF80_GrayScale';
        'ALASKA_v2_JPG_512_QF100_GrayScale';
        'ALASKA_v2_JPG_512_QF90_GrayScale';
        'ALASKA_v2_JPG_512_QF80_GrayScale'
    };
end

% By default load 20 images from each dataset
if ~exist("imageIndices", "var")
    imageIndices = 1:20;
end 

filesExtension = '.jpg';

% Loop through each given dataset
for i = 1:length(datasetNames)

    dirPath = fullfile(projectRoot, ...
        'data/input/images/ALASKAv2', ...
        datasetNames{i});
    
    % If directory for this dataset does not exist, create one.
    if ~exist(dirPath, 'dir')
        mkdir(dirPath);
    end

    filesDownloaded = 0;
    filesSkipped = 0;

    for imageIndex = imageIndices
        imageName = sprintf('%05d%s', imageIndex, filesExtension);
        imagePath = fullfile(dirPath, imageName);
        % Only download if image file is missing.
        if ~exist(imagePath, 'file')
            imageURL = sprintf('http://alaska.utt.fr/DATASETS/%s/%s', ...
                datasetNames{i}, imageName);
        
            websave(fullfile(dirPath, imageName), imageURL);
            filesDownloaded = filesDownloaded + 1;
        else
            filesSkipped = filesSkipped + 1;
        end
    end
    fprintf('%d images downloaded, %d  skipped\n', ...
        filesDownloaded, filesSkipped);
end
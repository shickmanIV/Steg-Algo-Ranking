function path = getImagePath(i, projectRoot, dirName)
    fileName = sprintf('%05d.jpg', i);

    % By default, use full quality 256p JPEGs
    if nargin < 3 || isempty(dirName)
        dirName = 'ALASKA_v2_JPG_256_QF100_GrayScale';
    end

    
    path = fullfile(projectRoot, ...
        'data/input/images/ALASKAv2/', dirName, fileName);
end
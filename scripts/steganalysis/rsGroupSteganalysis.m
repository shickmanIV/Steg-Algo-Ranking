function [embeddingRate, RSValues] = rsGroupSteganalysis(imagePath, blockSize, flipPattern)
    % rsGroupSteganalysis - Performs RS Group Steganalysis on an input image.
    % 
    % Inputs:
    %   imagePath   - Path to the input grayscale image.
    %   blockSize   - Size of the pixel blocks (e.g., 8 for 8x8 blocks). Optional.
    %   flipPattern - Matrix for flipping pattern (e.g., [0 1; 1 0] for checkerboard).
    % 
    % Outputs:
    %   embeddingRate - Estimated embedding rate (value between 0 and 1).
    %   RSValues      - Struct with Regular and Singular values.

    % Read the input image
    image = imread(imagePath);
    if size(image, 3) ~= 1
        image = rgb2gray(image);
        disp('Converted image to grayscale.');
    end

    % Ensure the image is double for processing
    image = double(image);

    % Get image dimensions
    [rows, cols] = size(image);

    % Determine block size if not provided
    if nargin < 2 || isempty(blockSize)
        blockSize = gcd(rows, cols); % Use greatest common divisor for maximum block size
    end

    % Initialize RS values
    R = 0; % Regular unflipped
    S = 0; % Singular unflipped
    R_ = 0; % Regular flipped
    S_ = 0; % Singular flipped

    % Calculate the number of blocks
    numBlocksRow = floor(rows / blockSize);
    numBlocksCol = floor(cols / blockSize);

    % Ensure flipPattern is valid and resizeable
    if nargin < 3 || isempty(flipPattern)
        error('flipPattern is required and cannot be empty.');
    end
    if ~ismatrix(flipPattern)
        error('flipPattern must be a 2D matrix.');
    end

    % Resize flipPattern to block size if necessary
    [fpRows, fpCols] = size(flipPattern);
    if fpRows > blockSize || fpCols > blockSize
        error('flipPattern dimensions exceed the block size. Please provide a smaller pattern.');
    end
    
    flipPatternResized = repmat(flipPattern, ceil(blockSize / fpRows), ceil(blockSize / fpCols));
    flipPatternResized = flipPatternResized(1:blockSize, 1:blockSize);
    
    % Iterate over all blocks
    for i = 1:numBlocksRow
        for j = 1:numBlocksCol
            % Extract the block
            rowStart = (i - 1) * blockSize + 1;
            rowEnd = i * blockSize;
            colStart = (j - 1) * blockSize + 1;
            colEnd = j * blockSize;
            block = image(rowStart:rowEnd, colStart:colEnd);

            % Calculate smoothness for original and flipped block
            R = R + calculateSmoothness(block);
            S = S + calculateSmoothness(block, 'singular');

            % Apply the flipping pattern
            flippedBlock = mod(block + flipPatternResized, 256); % Ensure values are within valid range
            R_ = R_ + calculateSmoothness(flippedBlock);
            S_ = S_ + calculateSmoothness(flippedBlock, 'singular');
        end
    end

    % Estimate embedding rate
    if (R - S + R_ - S_) == 0
        error('Invalid RS values: division by zero. Check the input image or parameters.');
    end
    embeddingRate = (S_ - S) / (R - S + R_ - S_);

    % Package RS values into a struct
    RSValues = struct('R', R, 'S', S, 'R_', R_, 'S_', S_);
end

function smoothness = calculateSmoothness(block, type)
    % calculateSmoothness - Calculates smoothness of a block.
    % 
    % Inputs:
    %   block - Pixel block to analyze.
    %   type  - 'regular' or 'singular'. Default is 'regular'.
    % 
    % Outputs:
    %   smoothness - Smoothness value of the block.

    if nargin < 2 || strcmp(type, 'regular')
        % Default: Regular smoothness
        diffBlockRow = diff(block, 1, 1);  % Differences along rows
        diffBlockCol = diff(block, 1, 2);  % Differences along columns

        % Pad the smaller dimension with zeros to match sizes
        diffBlockRow = [diffBlockRow; zeros(1, size(block, 2))];  % Pad rows to match original block size
        diffBlockCol = [diffBlockCol, zeros(size(block, 1), 1)];  % Pad columns to match original block size

        % Calculate regular smoothness
        diffValue = diffBlockRow.^2 + diffBlockCol.^2;
    else
        % Singular smoothness
        diffBlockRow = diff(block, 1, 1);  % Differences along rows
        diffBlockCol = diff(block, 1, 2);  % Differences along columns

        % Pad the smaller dimension with zeros to match sizes
        diffBlockRow = [diffBlockRow; zeros(1, size(block, 2))];  % Pad rows to match original block size
        diffBlockCol = [diffBlockCol, zeros(size(block, 1), 1)];  % Pad columns to match original block size

        % Calculate singular smoothness
        diffValue = abs(diffBlockRow) + abs(diffBlockCol);
    end

    smoothness = sum(diffValue(:));  % Sum of all difference values
end

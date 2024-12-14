function [chiSquaredValues, pValues, stegoIndicator] = chiSquaredAttack(image, blockSize)
    % CHISQUAREATTACK Perform a chi-squared steganalysis attack on an image.
    %
    % Parameters:
    %   image - Grayscale image (2D array)
    %   blockSize - Size of the block to perform local analysis
    %
    % Returns:
    %   chiSquaredValues - Chi-squared values computed for each block
    %   pValues - p-values associated with the chi-squared test for each block
    %   stegoIndicator - Binary map indicating potential stego regions

    % Ensure the input is grayscale
    if size(image, 3) ~= 1
        error('Input image must be grayscale.');
    end

    % Get image dimensions
    [height, width] = size(image);

    % Preallocate arrays for chi-squared and p-values
    numBlocksX = ceil(width / blockSize);
    numBlocksY = ceil(height / blockSize);
    chiSquaredValues = zeros(numBlocksY, numBlocksX);
    pValues = zeros(numBlocksY, numBlocksX);

    % Process each block
    for by = 1:numBlocksY
        for bx = 1:numBlocksX
            % Define block boundaries
            rowStart = (by - 1) * blockSize + 1;
            rowEnd = min(by * blockSize, height);
            colStart = (bx - 1) * blockSize + 1;
            colEnd = min(bx * blockSize, width);

            % Extract block
            block = image(rowStart:rowEnd, colStart:colEnd);

            % Compute observed and expected frequencies
            pixelCounts = histcounts(block(:), 0:256); % Histogram from 0 to 255
            expectedCounts = mean(pixelCounts) * ones(size(pixelCounts)); % Uniform distribution

            % Chi-squared test
            chiSquared = sum((pixelCounts - expectedCounts).^2 ./ expectedCounts, 'omitnan');
            pValue = 1 - chi2cdf(chiSquared, length(pixelCounts) - 1);

            % Store results
            chiSquaredValues(by, bx) = chiSquared;
            pValues(by, bx) = pValue;
        end
    end

    % Generate a stego-indicator map (threshold p-values)
    threshold = 0.05; % Adjust threshold based on sensitivity
    stegoIndicator = pValues < threshold;
end

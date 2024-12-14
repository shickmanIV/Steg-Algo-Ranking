function ssimIndex = computeSSIM(image1, image2)
    % COMPUTESSIM Computes the Structural Similarity (SSIM) index between two images.
    %
    % Usage:
    %   ssimIndex = computeSSIM(image1, image2)
    %
    % Inputs:
    %   image1 - First input image (grayscale or color).
    %   image2 - Second input image (grayscale or color).
    %
    % Output:
    %   ssimIndex - The SSIM value, a scalar between -1 and 1.
    %               Values closer to 1 indicate high similarity.
    %
    % Note:
    %   This function requires MATLAB's Image Processing Toolbox.
    
    % Ensure the images are of the same size
    if ~isequal(size(image1), size(image2))
        error('Input images must have the same dimensions.');
    end

    % Convert images to grayscale if they are RGB
    if size(image1, 3) == 3
        image1 = rgb2gray(image1);
    end
    if size(image2, 3) == 3
        image2 = rgb2gray(image2);
    end

    % Normalize images to double for computation
    image1 = im2double(image1);
    image2 = im2double(image2);

    % Default parameters for SSIM calculation
    windowSize = 11; % Size of the Gaussian window
    K = [0.01 0.03]; % Stability constants for luminance and contrast
    L = 1; % Dynamic range of pixel values (0 to 1 for normalized images)

    % Compute SSIM using MATLAB's built-in function
    ssimIndex = ssim(image1, image2, ...
                     'DynamicRange', L, ...
                     'Radius', floor(windowSize / 2), ...
                     'K1', K(1), ...
                     'K2', K(2));
end

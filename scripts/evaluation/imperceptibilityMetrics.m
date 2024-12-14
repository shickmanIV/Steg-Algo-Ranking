function [psnr,ssimIndex,mse] = imperceptibilityMetrics(original,modified)
% IMPERCEPTIBILITYMETRICS Computes imperceptibility metrics between two 
% images: the original and the modified (encoded) image.
%
% Inputs:
%   original: The original image (matrix of pixel values).
%   modified: The modified image (matrix of pixel values).
%
% Outputs:
%   psnr      - The Peak Signal-to-Noise Ratio (PSNR) in decibels (dB).
%   ssimIndex - The SSIM value, a scalar between -1 and 1. Values closer 
%               to 1 indicate high similarity.
%   mse       - The Mean Squared Error (MSE) between the images.
%
% Note:
%   This function requires MATLAB's Image Processing Toolbox.

    % Convert images to grayscale if they are RGB
    if size(original, 3) == 3
        original = rgb2gray(original);
    end
    if size(modified, 3) == 3
        modified = rgb2gray(modified);
    end

    % Normalize images to double for computation
    original = im2double(original);
    modified = im2double(modified);

    % Calculate the Mean Squared Error (MSE) between the images
    % MSE measures the average squared difference between the original and
    % modified images, indicating distortion.
    mse = mean((original - modified).^2, 'all');

    % Define the maximum possible pixel intensity value
    max_val = 255;

    % Calculate the PSNR. 
    % A higher PSNR value indicates less distortion.
    psnr = 10 * log10(max_val^2 / mse);

    % Default parameters for SSIM calculation
    windowSize = 11; % Size of the Gaussian window
    K = [0.01 0.03]; % Stability constants for luminance and contrast
    L = 1; % Dynamic range of pixel values (0 to 1 for normalized images)'

    % Compute SSIM using MATLAB's built-in function
    ssimIndex = ssim(image1, image2, ...
                     'DynamicRange', L, ...
                     'Radius', floor(windowSize / 2), ...
                     'K1', K(1), ...
                     'K2', K(2));
end



function psnr_val = computePSNR(original, modified)
    % computePSNR computes the Peak Signal-to-Noise Ratio (PSNR) between
    % two images: the original and the modified (encoded) image.
    %
    % Parameters:
    %   original: The original image (matrix of pixel values).
    %   modified: The modified image (matrix of pixel values).
    %
    % Returns:
    %   psnr_val: The computed PSNR value in decibels (dB).

    % Convert images to double precision for accurate calculations
    original = double(original);
    modified = double(modified);

    % Calculate the Mean Squared Error (MSE) between the images
    % MSE measures the average squared difference between the original and
    % modified images, indicating distortion.
    mse = mean((original - modified).^2, 'all');

    % Define the maximum possible pixel intensity value
    max_val = 255;

    % Calculate the PSNR. 
    % A higher PSNR value indicates less distortion.
    psnr_val = 10 * log10(max_val^2 / mse);
end
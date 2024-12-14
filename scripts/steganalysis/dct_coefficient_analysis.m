function dct_coeffs = dct_coefficient_analysis(image)
    % dct_coefficient_analysis - Performs DCT Coefficient Analysis on an input image.
    % 
    % Input:
    %   imagePath   - Path to the input grayscale image.
    % 
    % Output:   
    %   dct_coeffs  - Matrix of DCT Coefficients
    
    % Load the image
       %img = imread(imagePath);
    
    % Convert to grayscale if necessary
    if size(image, 3) == 3
        image = rgb2gray(image);
        disp('Converted image to grayscale.');
    end

    % Get the dimensions of the image
    [rows, cols] = size(image);

    % Ensure the dimensions are multiples of 8
    rows = floor(rows / 8) * 8;
    cols = floor(cols / 8) * 8;
    image = image(1:rows, 1:cols);

    % Initialize a matrix to store DCT coefficients
    dct_coeffs = zeros(rows, cols);

    % Process the image block by block
    for i = 1:8:rows
        for j = 1:8:cols
            % Extract the 8x8 block
            block = double(image(i:i+7, j:j+7));
            
            % Compute the DCT of the block
            dct_block = dct2(block);
            
            % Store the DCT coefficients
            dct_coeffs(i:i+7, j:j+7) = dct_block;
        end
    end

    % Flatten the DCT coefficients for histogram analysis
        %dct_coeffs_flat = dct_coeffs(:);

    % Visualize the distribution of DCT coefficients
        %figure;
    % The histogram shows the frequency distribution of DCT coefficients. 
    % Look for a peak near zero (typical for natural images) and anomalies 
    % such as flattened or irregular distributions, which might indicate 
    % steganography.
        %histogram(dct_coeffs_flat, 100); 
        %title('Histogram of DCT Coefficients');
        %xlabel('DCT Coefficient Value');
        %ylabel('Frequency');

    % Identify and display statistical properties

    % The DCT coefficients' mean should be close to zero for natural images.
        %mean_coeff = mean(dct_coeffs_flat);
    % The stdev reflects the variability of the DCT coefficients. A high 
    % value may suggest more texture or possible alterations, while a low 
    % value indicates smoother image regions.
        %std_coeff = std(dct_coeffs_flat);
        %fprintf('Mean of DCT coefficients: %.2f\n', mean_coeff);
        %fprintf('Standard deviation of DCT coefficients: %.2f\n', std_coeff);

    % Optional: Visualize a sample DCT block
    % The sample DCT block visualization helps to see the distribution of 
    % frequency components. Pay attention to unusual magnitudes in middle 
    % or high frequencies, which might indicate tampering.
        %figure;
        %sample_block = dct_coeffs(1:8, 1:8);
        %imagesc(sample_block);
        %colormap('jet');
        %colorbar;
        %title('Sample DCT Block (Top-Left)');

        %dct_coeff_stats = struct('mean', mean_coeff, 'std', std_coeff);
end

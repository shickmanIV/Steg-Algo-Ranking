

% Set the message to embed in the cover images
message = 'This is a secret message';  % Example message

results = struct();

for idx = 1:numel(imageIndices)
    i = imageIndices(idx);

    % Read the image
    imgPath = getImagePath(i, projectRoot);
    img = imread(imgPath);

    % Convert the image to grayscale if necessary
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    % Perform LSB steganography
    lsb_img = lsb_embed(img, message);
    [psnr_lsb, ssim_lsb, mse_lsb] = imperceptibilityMetrics(img, lsb_img);
    results(2 * idx - 1).method = 'lsb'; % Explicit indexing for LSB
    results(2 * idx - 1).imageIndex = i;
    results(2 * idx - 1).psnr = psnr_lsb;
    results(2 * idx - 1).ssimIndex = ssim_lsb;
    results(2 * idx - 1).mse = mse_lsb;

    % Perform PVD steganography
    pvd_img = pvd_embed(img, message);
    [psnr_pvd, ssim_pvd, mse_pvd] = imperceptibilityMetrics(img, pvd_img);
    results(2 * idx).method = 'pvd'; % Explicit indexing for PVD
    results(2 * idx).imageIndex = i;
    results(2 * idx).psnr = psnr_pvd;
    results(2 * idx).ssimIndex = ssim_pvd;
    results(2 * idx).mse = mse_pvd;
end
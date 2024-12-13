% Set of image paths (replace with your own list of image file paths)
imagePaths = {imageFilePath}; 

% Set the message to embed in the cover image (adjust as needed)
message = 'This is a secret message';  % Example message

% Initialize output structures to hold results
psnrResults = struct();
steganalysisResults = struct();

% Define blockSize and flipPattern (adjust as needed)
blockSize = 8;  % Example block size
flipPattern = 'default';  % Example flip pattern (adjust as needed)

% Loop through the images and process with LSB and PVD
for i = 1:length(imagePaths)
    % Read the image
    img = imread(imagePaths{i});

    % Ensure the image is grayscale (convert if necessary)
    if size(img, 3) == 3  % If the image has 3 channels (RGB)
        img = rgb2gray(img);  % Convert to grayscale
        disp('Converted img to grayscale');
    end
    
    % LSB Embedding
    lsbImg = lsb_embed(img, message);  % Pass message as second argument
    psnrLsb = calculate_psnr(img, lsbImg);
    [embeddingRateLsb, rsValuesLsb] = rsGroupSteganalysis(imagePaths{i}, blockSize, flipPattern);
    
    % PVD Embedding
    pvdImg = pvd_embed(img, message);  % Pass message as second argument
    psnrPvd = calculate_psnr(img, pvdImg);
    [embeddingRatePvd, rsValuesPvd] = rsGroupSteganalysis(imagePaths{i}, blockSize, flipPattern);
    
    % Store results
    psnrResults(i).image = imagePaths{i};
    psnrResults(i).lsb = psnrLsb;
    psnrResults(i).pvd = psnrPvd;
    
    steganalysisResults(i).image = imagePaths{i};
    steganalysisResults(i).lsb.embeddingRate = embeddingRateLsb;
    steganalysisResults(i).lsb.RSValues = rsValuesLsb;
    steganalysisResults(i).pvd.embeddingRate = embeddingRatePvd;
    steganalysisResults(i).pvd.RSValues = rsValuesPvd;
end

% Display results
disp('PSNR Results:');
disp(struct2table(psnrResults));

disp('Steganalysis Results:');
disp(struct2table(steganalysisResults));

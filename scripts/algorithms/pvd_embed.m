function stego_img = pvd_embed(cover_img, message)
    % pvd_embed embeds a text message into a cover image using the 
    % Pixel Value Differencing (PVD) technique.
    %
    % Parameters:
    %   cover_img: The input grayscale image (matrix of pixel values).
    %   message: The text message to embed into the image.
    %
    % Returns:
    %   stego_img: The image with the embedded message.

    % Convert the message to binary representation
    message_bin = reshape(dec2bin(message, 8).'-'0', 1, []);  % Binary array
    message_len = length(message_bin);

    % Get dimensions of the image
    [rows, cols] = size(cover_img);
    if mod(rows * cols, 2) ~= 0
        error('Image dimensions must allow pairs of pixels.');
    end

    % Check if the message fits in the image
    max_capacity = (rows * cols) / 2;  % Each pair embeds at least 1 bit
    if message_len > max_capacity
        error('Message is too large to embed in the given image.');
    end

    % Initialize stego image as a copy of the cover image
    stego_img = cover_img;
    bin_index = 1;

    % Iterate through pixel pairs
    for i = 1:2:rows * cols
        if bin_index > message_len
            break;
        end

        % Access the current pixel pair
        p1 = stego_img(i);      % First pixel
        p2 = stego_img(i + 1);  % Second pixel

        % Calculate the difference and embedding range
        diff = abs(p1 - p2);
        if diff >= 0 && diff <= 15
            embed_bits = 1;  % Embed 1 bit
        elseif diff >= 16 && diff <= 31
            embed_bits = 2;  % Embed 2 bits
        else
            embed_bits = 3;  % Embed 3 bits
        end

        % Extract bits to embed
        if bin_index + embed_bits - 1 > message_len
            embed_bits = message_len - bin_index + 1;
        end
        data_to_embed = message_bin(bin_index:bin_index + embed_bits - 1);
        bin_index = bin_index + embed_bits;

        % Convert data to decimal
        embed_val = bin2dec(num2str(data_to_embed));

        % Adjust pixel pair to embed the value
        avg = floor((p1 + p2) / 2);
        if mod(avg, 2) == 0
            p1 = avg + embed_val;  % Modify first pixel
        else
            p2 = avg + embed_val;  % Modify second pixel
        end

        % Update stego image
        stego_img(i) = p1;
        stego_img(i + 1) = p2;
    end

    % Display status
    if bin_index <= message_len
        warning('Message was truncated due to limited capacity.');
    end
end

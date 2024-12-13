function encoded_img = lsb_embed(cover_img, message)
    % lsb_embed embeds a text message into the least significant bits (LSB) 
    % of a cover image.
    %
    % Parameters:
    %   cover_img: The input grayscale image (matrix of pixel values).
    %   message: The text message to embed into the image.
    %
    % Returns:
    %   encoded_img: The image with the embedded message.

    % Convert the message to binary representation
    message_bin = reshape(dec2bin(message, 8).'-'0', 1, []); 
    [rows, cols, ~] = size(cover_img);
    max_capacity = rows * cols;
    
    % Check message size
    if length(message_bin) > max_capacity
        error('Message is too large to embed.');
    end

    % Embed message into the least significant bits
    encoded_img = cover_img;
    for i = 1:length(message_bin)
        pixel = encoded_img(i);
        encoded_img(i) = bitset(pixel, 1, message_bin(i));
    end
end
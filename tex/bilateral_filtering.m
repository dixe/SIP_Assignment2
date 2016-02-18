function [ I_filtered ] = bilateral_filtering(I, N, sigma, tau)

%Padding image boundaries with N zeros.
I_padded = zeros(size(I, 1) + 2 * N, size(I, 2) + 2 * N);
I_padded(N + 1 : N + size(I, 1), N + 1 : N + size(I, 2)) = double(I);

k = fspecial('gaussian', [N N], sigma);
I_filtered = zeros(size(I));
for i = 1 : size(I, 1)
    for j = 1 : size(I, 2)
        x_i = (N + i - ceil(size(k, 1) / 2)) : (N + i + floor(size(k, 1) / 2) - 1);
        y_i = (N + j - ceil(size(k, 2) / 2)) : (N + j + floor(size(k, 2) / 2) - 1);
        w = k.*exp(-(I_padded(x_i, y_i) - I(i, j)).^2 / (2 * tau^2));
        I_filtered(i, j) = sum(sum(I_padded(x_i, y_i).*w)) / sum(sum(w));    
    end
end

end
I = imread('images/eight.tif');
I = imnoise(I, 'gaussian', 0.02);

S = edge(I, 'sobel');
P = edge(I, 'prewitt');
k = fspecial('log', [10 10], 3);
Z = edge(I, 'zerocross', [], k);

subplot(10, 4, 1);
imshow(I);
subplot(10, 4, 2);
imshow(S);
subplot(10, 4, 3);
imshow(P);
subplot(10, 4, 4);
imshow(Z);

i = 5;
for tau = 10 : 40 : 90
    for sigma = 1 : 8 : 17

        window_size = floor(3 * sigma);

        I_filtered = bilateral_filtering(double(I), window_size, sigma, tau);
        I_filtered = uint8(I_filtered);

        S = edge(I_filtered, 'sobel');
        P = edge(I_filtered, 'prewitt');
        
        k = fspecial('log', [10 10], 3);
        Z = edge(I_filtered, 'zerocross', [], k);

        subplot(10, 4, i);
        imshow(I_filtered);
        i = i + 1;
        subplot(10, 4, i);
        imshow(S);
        i = i + 1;
        subplot(10, 4, i);
        imshow(P);
        i = i + 1;
        subplot(10, 4, i);
        imshow(Z);
        i = i + 1;        
    end
end
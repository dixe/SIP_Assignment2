%%
K = zeros(3,3);
K(1,2) = -1;
K(2,1) = -1;
K(3,2) = 1;
K(2,3) = 1;

K= K/2;
I = imread('/home/nikolaj/Dropbox/4.aar/SIP/images/ch2_images/trui.png');

K2 = ones(3,3) * -1;
K2(2,2) = 8;


IB = imfilter(I,K);
IC = imfilter(I,K2);
subplot(1,3,1); imshow(I); axis off; axis image;
subplot(1,3,2); imshow(IB); axis off; axis image;
subplot(1,3,3); imshow(IC); axis off; axis image;

colormap(gray);

%% 1.3
I =  imread('pout.tif');
size(I)
I2 = fun13(I);
subplot(1,2,1); imhist(I);
subplot(1,2,2); imhist(I2);

%% 1.4
addpath('.');
I =  imread('pout.tif');
CDF = fun13(I);
I2 = fun14(I,CDF);
subplot(1,2,1); %% 1.3
I =  imread('pout.tif');
size(I)
I2 = fun13(I);
subplot(1,2,1); imhist(I);
subplot(1,2,2); imhist(I2);

%% 1.4
addpath('.');
I =  imread('pout.tif');
CDF = fun13(I);
I2 = fun14(I,CDF);
subplot(1,2,1); imagesc(I); axis off; axis image;
subplot(1,2,2); imagesc(I2); axis off; axis image
colormap(gray);


%% 1.5
addpath('.');
I = imread('pout.tif');
CDF = fun13(I);
I2 = fun15(0.1,CDF);
subplot(1,2,1); imagesc(I); axis off; axis image;
subplot(1,2,2); imagesc(I2); axis off; axis image
colormap(gray);


%% 1.6
I1 = imread('pout.tif');
I2 = imread('trui.png');
fun15




%% 2.3
I = imread('eight.tif');
k = ones(3,3)/9;
Isp = imnoise(I,'salt & pepper', 0.03);
Ig = imnoise(I,'gaussian',0.02);
IspMean = imfilter(Isp,k);
IgMean = imfilter(Ig,k);
IspMed = medfilt2(Isp,[3,3]);
IgMed= medfilt2(Ig,[3,3]);

subplot(2,3,1); imagesc(Isp); axis off; axis image;
subplot(2,3,2); imagesc(Ig); axis off; axis image;
subplot(2,3,3); imagesc(IspMean); axis off; axis image;
subplot(2,3,4); imagesc(IgMean); axis off; axis image;
subplot(2,3,5); imagesc(IspMed); axis off; axis image;
subplot(2,3,6); imagesc(IgMed); axis off; axis image;
colormap(gray);


%% 2.4
I = imread('cameraman.tif');

for n = 0: 2
    Filt = fspecial('gaussian', (n*2 + 7), 5);
    subplot(1,3,n+1); imagesc(imfilter(I,Filt)); axis off; axis image;
end

colormap(gray);

    


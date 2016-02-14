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
I = fun13(I);
size(I)
imhist(I);
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
addpath('.');
I1 = imread('pout.tif');
I2 = imread('trui.png'); 
% calc the cummulative histograms

HC1 = fun13(I1);
HC2 = fun13(I2);

% pseudo inverse of HC2

Range = 0:1/255:1;
PI2 = func15(HC2, Range);


Out = HC1(I1);
Out = uint8(Out * 255) + 1;

Out = uint8(PI2(Out));

subplot(1,3,1); imagesc(I1); axis off; axis image;
subplot(1,3,2); imagesc(I2); axis off; axis image;
subplot(1,3,3); imagesc(Out); axis off; axis image;
colormap(gray);



%% 2.3
I = imread('eight.tif');

Isp = imnoise(I,'salt & pepper', 0.03);
Ig = imnoise(I,'gaussian',0.02);

colormap(gray);
% for N = 1:25    
%     N
%     k = ones(N,N)/N^2;
%     
%     Isp_mean = imfilter(Isp,k);   
%     Ig_mean = imfilter(Ig,k);
%     
%     Isp_med = medfilt2(Isp,[N,N]);
%     Ig_med = medfilt2(Ig,[N,N]);
% 
%     
%     subplot(2,2,1); imagesc(Isp_mean); axis off; axis image;
%     subplot(2,2,2); imagesc(Ig_mean); axis off; axis image;
%     subplot(2,2,3); imagesc(Isp_med); axis off; axis image;
%     subplot(2,2,4); imagesc(Ig_med); axis off; axis image;
%     
%     pause
% 
% end


time_mean = zeros(25);
time_med = zeros(25);

for N = 1:25
    k = ones(N,N)/N^2;
    t1 = tic;
    
    for tmp = 1:100
        Ig_mean = imfilter(Ig,k);
    end
    elapsed_mean = toc(t1);
    time_mean(N) = elapsed_mean;
    
    t2 = tic;
    for tmp = 1:100
        Ig_mean = medfilt2(Ig,[N,N]);
    end
    elapsed_med = toc(t2);
    time_med(N) = elapsed_med;
end

mean_plot = plot(time_mean,'r');
hold on
med_plot = plot(time_med,'b');
xlabel('Windows size') % x-axis label
ylabel('Time in seconds') % y-axis label

hold off

%% 2.4
I = imread('cameraman.tif');
n = 1;
for N = 3:2:19
    Filt = fspecial('gaussian', N, 5);
    subplot(3,3,n); imagesc(imfilter(I,Filt)); axis off; axis image;  
    n = n+1;
end

colormap(gray);


%% 2.5
I = imread('cameraman.tif');

n = 1;
for sig = 1:2:18
    N = sig * 3 + 1;
    if mod(N,2) == 0
        N = N +1;
    end
    Filt = fspecial('gaussian', N, 5);
    subplot(3,3,n); imagesc(imfilter(I,Filt)); axis off; axis image;  
    n = n +1;
end

colormap(gray);



    


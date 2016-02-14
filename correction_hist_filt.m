%% Histograms 

% 1.1

% CDF is the integral of the PDF and since PDF are always positive, the
% cumulative distribution function is increasing.

% 1.2

% A constant image gives a spike histogram and thus its CDF is a crenel
% function. It's a ramp-like function if the histogram is itself constant.

% 1.3
clear all
close all

I=imread(['pout.tif']);
%I2=uint8(100*ones(size(I2)));

[counts,bins]=imhist(I); % computes the histogram of the image 
cH=cumsum(counts)/sum(counts); % makes the cumulative sum and normalize to obtain the cumulative histogram

figure() % display the histogram
imhist(I)

figure() % plot the cumulative histogram
plot(cH,'b')

% 1.4

I_transf=cH(I+1);

figure()
imagesc(I_transf)
colormap gray

% other solution : use arrayfun or a double loop

% 1.5

% CDF is not necessarily invertible as one can see easily in the case of a
% constant image. Flat regions can appear in ranges of intensities that are
% not existing in the image.

function [g] = pseudo_inverse(f,S)
g=zeros(size(S));

for l=1:length(g)
    ind=find(f>=S(l));
    g(l)=min(ind);
end

end

% 1.6

clear all
close all
%load the two images

I1=imread(['pout.tif']);
I2=imread(['eight.tif']);

% I1=imread(['movie_flicker1.tif']);
% I1=rgb2gray(I1);
% I2=imread(['movie_flicker2.tif']);
% I2=rgb2gray(I2);

%compute their cumulative histograms
[counts,bins]=imhist(I1);
Hc1=cumsum(counts)/sum(counts);

[counts,bins]=imhist(I2);
Hc2=cumsum(counts)/sum(counts);

%pseudo-inverse of Hc2
S=0:1/255:1;
[g2]=pseudo_inverse(Hc2,S);

I1_2=Hc1(I1+1);
I1_2=uint8(g2(uint8(I1_2*255)+1));
[counts,bins]=imhist(I1_2);
Hc1_2=cumsum(counts)/sum(counts);

I1_2_bis = imhistmatch(I1,I2);
[counts,bins]=imhist(I1_2_bis);
Hc1_2_bis=cumsum(counts)/sum(counts);

%Display resulting image and cumulative histograms
figure()
subplot(2,3,1)
imshow(I1)
subplot(2,3,2)
imshow(I2)
subplot(2,3,3)
imshow(I1_2)

subplot(2,3,4)
plot(Hc1,'b')
subplot(2,3,5)
plot(Hc2,'c')
subplot(2,3,6)
plot(Hc1_2,'r')
%plot(Hc1_2_bis,'g')

% figure()
% subplot(1,4,1)
% imshow(I1)
% subplot(1,4,2)
% imshow(I2)
% subplot(1,4,3)
% imshow(I1_2)
% subplot(1,4,4)
% imshow(I1_2_bis)

%compare respective cumulative histograms
figure()
hold on
plot(Hc1,'b')
plot(Hc1_2,'c')
plot(Hc2,'r')
plot(Hc1_2_bis,'g')


% 1.7

% Apply the same code as previously but by fixing Hc2=(0:255)/255
I=imread(['pout.tif']);
[counts,bins]=imhist(I);
Hc1=cumsum(counts)/sum(counts);

Hc2=(0:255)/255;

[g2]=pseudo_inverse(Hc2,Hc1);

I_eq=uint8(g2(I+1));
[counts,bins]=imhist(I_eq);
Hc_eq=cumsum(counts)/sum(counts);

I_eq_bis = histeq(I);
[counts,bins]=imhist(I_eq_bis);
Hc_eq_bis=cumsum(counts)/sum(counts);

%Display resulting image and cumulative histograms
figure()
subplot(2,3,1)
imshow(I)
title('Original')
subplot(2,3,2)
imshow(I_eq)
title('Equalized')
subplot(2,3,3)
imshow(I_eq_bis)
title('histeq')

subplot(2,3,4)
plot(Hc1,'b')
subplot(2,3,5)
plot(Hc_eq,'c')
subplot(2,3,6)
plot(Hc_eq_bis,'r')


% 1.8 

% The cumulative histograms of constant images are one-step functions where the
% step occurs precisely at the constant value of the corresponding image. Clearly,
% the average of two such functions located at different values a and b is 
% a two-step function and cannot be equal to the CDF of the mean image.

% 1.9
clear all
close all
I1=imread(['movie_flicker1.tif']);
I1=rgb2gray(I1);
I2=imread(['movie_flicker2.tif']);
I2=rgb2gray(I2);


%compute the cumulative histograms
[counts,bins]=imhist(I1);
Hc1=cumsum(double(counts))/sum(double(counts));

[counts,bins]=imhist(I2);
Hc2=cumsum(counts)/sum(counts);

S=0:1/255:1;
[g1]=pseudo_inverse(Hc1,S);
[g2]=pseudo_inverse(Hc2,S);
phi=1/2*(g1+g2);

I1_eq=uint8(phi(uint8(Hc1(I1+1)*255)+1));
I2_eq=uint8(phi(uint8(Hc2(I2+1)*255)+1));

figure()
subplot(2,2,1)
imshow(I1)
subplot(2,2,2)
imshow(I2)
subplot(2,2,3)
imshow(I1_eq)
subplot(2,2,4)
imshow(I2_eq)

[counts,bins]=imhist(I1_eq);
Hc1_eq=cumsum(counts)/sum(counts);

[counts,bins]=imhist(I2_eq);
Hc2_eq=cumsum(counts)/sum(counts);

figure()
hold on
plot(Hc1,'y')
plot(Hc2,'g')
plot(Hc1_eq,'b')
plot(Hc2_eq,'r')
plot((Hc1+Hc2)/2,'k')
legend('First image CDF','Second image CDF','I1tilde CDF','I2tilde CDF','Mean of the two original images CDF')

% Note that the two midway cumulative histograms are very close together 
% and that they are basically in-between the two original images' histograms.
% However they do NOT coincide with the actual mean of the CDFs.

%% Filtering and enhancement

% 2.1

% Kernel should be equal to [-1 0 1] with the first convention. With the
% convolution formula, it becomes [1 0 -1].
% Matlab's imfilter function has two options : correlation and convolution
% to deal with that.
% In the case of Gaussian or mean filters, this has no incidence since
% their kernels are symmetric and the two expressions are the same.

% 2.2 

% Prewitt and Sobel filters correspond to the composition of the previous
% finite difference filter followed by averaging respectively with kernels
% [1 1 1] and [1 2 1]. This averaging of the gradients results in a better 
% robustness to noise.


% 2.3

I=imread('eight.tif');

Isp=imnoise(I,'salt & pepper',0.03);
Ig=imnoise(I,'gaussian',0.02);

figure()
subplot(1,3,1)
imshow(I)
subplot(1,3,2)
imshow(Isp)
subplot(1,3,3)
imshow(Ig)

for N=1:25
    N
    k=ones(N,N)/N^2;
    Isp_m=imfilter(Isp,k);
    
    Ig_m=imfilter(Ig,k);
    
    Isp_med=medfilt2(Isp,[N N]);
    
    Ig_med=medfilt2(Ig,[N N]);
    
    figure(2)
    subplot(2,2,1)
    imshow(Isp_m)
    subplot(2,2,2)
    imshow(Ig_m)
    subplot(2,2,3)
    imshow(Isp_med)
    subplot(2,2,4)
    imshow(Ig_med)
    
    pause
end

%Time comparison
time_mean=[];
time_median=[];
for N=1:1:25
    N
    k=ones(N,N)/N^2;
    t1=tic;
    
    for it=1:100
    Isp_m=imfilter(Isp,k);
    end
    
    t_elapsed=toc(t1);
    time_mean=[time_mean t_elapsed];
    
    t1=tic;
    for it=1:100
    Isp_med=medfilt2(Isp,[N N]);
    end
    t_elapsed=toc(t1);
    time_median=[time_median t_elapsed];
    
end

figure()
hold on 
plot(time_mean,'r')
plot(time_median,'b')

% Mean and median filtering computational times both increases with N, as 
% expected. However, the behaviour is different between the two. For the 
% mean filter, time grows relatively slowly compared to median essentially 
% because the sorting of the intensities for median require more time 
% (O(N^2log(N^2)) complexity) than doing a mean which is a priori O(N^2) 
% but is actually even faster based on FFT. 
% The piking effect at odd numbers is essentially a consequence of the 
% definition of the definition of media for these. 

% 2.4

% After N becomes big enough, the result does not change anymore. This
% results from the fact that Gaussian kernel quicly decreases to very small
% values and those have neglectible contributions in the filter.


% 3.1

% It is not a linear filter due to the non-linear dependency of the
% weights w. We can see that if tau-->infinity, the second gaussian is
% always equal to one and the filter becomes exactly a Gaussian filter of
% standard deviation sigma.

% 3.2

%Function
function [I_filtered] = bilateral_filtering(I,N,sigma1,sigma2)

% Precomputation of spatial Gaussian filter;
k=fspecial('gaussian',[N N],sigma1);

% Taking account of the boundary by padding around the original image
% (instead of cropping)
I_bis=-ones(size(I,1)+2*N,size(I,2)+2*N);
I_bis(N+1:N+size(I,1),N+1:N+size(I,2))=double(I);

I_filtered=zeros(size(I));
for i=1:size(I,1)
    for j=1:size(I,2)
        indx=(N+i-ceil(size(k,1)/2)):(N+i+floor(size(k,1)/2)-1);
        indy=(N+j-ceil(size(k,2)/2)):(N+j+floor(size(k,2)/2)-1);
        w=k.*exp(-(I_bis(indx,indy).*(I_bis(indx,indy)>=0)-I(i,j)).^2/sigma2^2); % computation of the weight
        I_filtered(i,j)=sum(sum(I_bis(indx,indy).*w))/sum(sum(w));
        
    end
end
end

% 3.3
I=imread('eight.tif');

Isp=imnoise(I,'salt & pepper',0.03);
Ig=imnoise(I,'gaussian',0.02);

I=Ig;

tau=100;
for sig=1:20
    
    w=floor(3*sig);
    if (mod(w,2) == 0)
        w  = w+1;
    end
    
    I_reg =  bilateral_filtering(double(I),w,sig,tau);
    I_reg=uint8(I_reg);
    
    
    [IEs,ths]=edge(I_reg,'sobel'); ths;
    [IEp,thp]=edge(I_reg,'prewitt'); thp;
    
    k=fspecial('log',[10 10],3);
    [IEzc,thzc]=edge(I_reg,'zerocross',[],k); thzc;
    
    figure(2)
    subplot(1,4,1)
    imshow(I_reg)
    %imagesc(I_reg)
    subplot(1,4,2)
    imshow(IEs)
    subplot(1,4,3)
    imshow(IEp)
    subplot(1,4,4)
    imshow(IEzc)
    
    pause
end


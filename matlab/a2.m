%% a1.2
figure(01); consthist(128);
figure(02); consthist(50);

%% a1.3 cumulative histogram
cumhist('images/pout.tif');

%% a1.4
brighterthan('images/pout.tif');

%% a1.6
im        = imread('images/pout.tif');
targetim  = imread('images/trui.png');
matched   = histmatch(im, targetim);

subplot(3,2,1), imagesc(im);        axis off image;  colormap(gray); title('original');
subplot(3,2,3), imagesc(targetim);  axis off image;  colormap(gray); title('target');
subplot(3,2,5), imagesc(matched);   axis off image;  colormap(gray); title('histogram matched result');
subplot(3,2,2), cumhist(im);
subplot(3,2,4), cumhist(targetim);
subplot(3,2,6), cumhist(matched);


%% a1.7 - apply to constant
im        = imread('images/pout.tif');
targetim  = reshape(uint8(0:255),16,16);  % constant gradient (histogram)
matched   = histmatch(im, targetim);
he        = histeq(im);

subplot(3,2,1), imagesc(im);       axis off image;  colormap(gray); title('original');
subplot(4,2,3), imagesc(targetim); axis off image;  colormap(gray);% title('constant histogram');
subplot(4,2,5), imagesc(matched);  axis off image;  colormap(gray); title('result');
subplot(4,2,7), imagesc(he);       axis off image;  colormap(gray); title('histeq');
subplot(4,2,2), cumhist(im);
subplot(4,2,4), cumhist(targetim);
subplot(4,2,6), cumhist(matched);
subplot(4,2,8), cumhist(he);


%% a1.8
im1  = rgb2gray(imread('images/movie_flicker1.tif'));
im2  = rgb2gray(imread('images/movie_flicker2.tif'));

a = 60; b = 120;
I1 = uint8(ones(16)*a); I2 = uint8(ones(16)*b);
c1 = cdf(pdf(I1)); c2 = cdf(pdf(I2)); c3 = (c1+c2)/2
subplot(1,3,1), plot(c1); axis([0 256 -0.05 1.05]); title(['c1, b=',num2str(a)])
subplot(1,3,2), plot(c2); axis([0 256 -0.05 1.05]); title(['c2, b=',num2str(b)])
subplot(1,3,3), plot(c3); axis([0 256 -0.05 1.05]); title('c average')

%% a1.9
im1  = rgb2gray(imread('images/movie_flicker1.tif'));
im2  = rgb2gray(imread('images/movie_flicker2.tif'));

im3  = midway({im1, im2});
im4  = midway({im2, im1});

d12 = imabsdiff(im1,im2);
d34 = imabsdiff(im3,im4);

figure(01);
subplot(2,2,1), imagesc(im1); axis off image; colormap(gray); title('flicker1');
subplot(2,2,2), imagesc(im2); axis off image; colormap(gray); title('flicker2');
subplot(2,2,3), cumhist(im1); title('cdf flicker1');
subplot(2,2,4), cumhist(im2); title('cdf flicker2');

figure(02);
subplot(2,2,1), imagesc(im3); axis off image; colormap(gray); title('midway1');
subplot(2,2,2), imagesc(im4); axis off image; colormap(gray); title('midway2');
subplot(2,2,3), cumhist(im3); title('cdf midway1');
subplot(2,2,4), cumhist(im4); title('cdf midway2');

figure(03);
subplot(2,2,1), imagesc(d12); axis off image; colormap(gray); title('imabsdiff(flicker1,2)'); colorbar;
subplot(2,2,2), imagesc(d34); axis off image; colormap(gray); title('imabsdiff(midway1,2)'); colorbar;
subplot(2,2,3), cumhist(d12); title('cdf diff(f1,f2)');
subplot(2,2,4), cumhist(d34); title('cdf diff(m1,m2)');















function brighterthan(fname)
    if nargin == 0
        fname = 'images/pout.tif';
    end
    I = imread(fname);
    h = imhist(I);
    ncs = cdf(h);

    fmt = 'selected pixel x:%d, y:%d; I(%d,%d):%d, C( I(%d,%d)):%f';
    hFig = figure(1);
    set(hFig, 'Position', [20 20 750 750])
    imagesc(I); axis image; colormap(gray); xlabel('X'); ylabel('Y');
    while true
        [x,y] = ginput(1);
        x = round(x); y = round(y);
        s = sprintf(fmt,x,y,x,y,round(I(y,x)),x,y,ncs(I(y,x)))
        title(s);
end

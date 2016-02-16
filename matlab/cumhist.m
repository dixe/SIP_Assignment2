function cumhist(fname)
    if ischar(fname)
        I = imread(fname);   % load image
    elseif isinteger(fname)
        I = fname;
    elseif isfloat(fname)
        'float'
        I = fname;
    end
    % calculate 'normalized cumulative sum', and display the resulting array
    bar(cdf(pdf(I, true))); axis([0 256 -0.05 1.05]); 
end
function [ cs ] = cdf(pdf)
    % pdf is a histogram
    c = double(cumsum(pdf));
    cs = c / c(end);
end
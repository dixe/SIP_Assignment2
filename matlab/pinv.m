function [ pseudo_inverse ] = pinv( cdf, ls )
    % find the cdf values larger than l, and return the least of them
    pseudo_inverse = zeros([1 numel(ls)]);
    for i = 1:numel(ls)
        l = ls(i);
        pseudo_inverse(i) = min( find(cdf >= l) );
    end
end
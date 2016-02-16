function prob_dist_function = pdf(I, normalize)
    if ischar(I)
        I = imread(I);
    end
    
    prob_dist_function = imhist(I); % retrieve histogram
    
    if nargin == 2 && normalize ~= false
        prob_dist_function = prob_dist_function / sum(prob_dist_function);
    end
end

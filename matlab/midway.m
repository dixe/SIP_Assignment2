function out = midway(Is)
    % general midway function, taking up to n images
    % usage midway({im_1, .., im_n})
    phi = zeros([1 256]);  n  = length(Is);
    I   = Is{1};           CI = cdf(pdf(I));
    for i=1:n
        C    = cdf(pdf(Is{i}));
        Cinv = pinv(C, CI);
        phi  = phi + Cinv;
    end
    phi = uint8( phi / n );
    out = applymapping(I, phi);
end

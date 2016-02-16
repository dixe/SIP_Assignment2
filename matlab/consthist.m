function consthist(c)
    if nargin == 0
        c = 128;
    end
    
    const = uint8(ones(16) * c);
    h = imhist(const);
    ncs = cdf(h);
    
    nvar = reshape(uint8(0:255),16,16);
    ha = imhist(nvar);
    ncsa = cdf(ha);
    
    subplot(1,4,1); bar( h/sum(h) ); axis([0 256 -0.05 1.05]);
    title(['pdf of const im = ', num2str(c)]);
    subplot(1,4,2); plot(ncs); axis([0 256 -0.05 1.05]);
    title('cdf of const im');
    
    subplot(1,4,3); bar( ha/sum(ha) ); axis([-10 265 0.0 0.005]);
    title('pdf of const gradient im');
    subplot(1,4,4); plot(ncsa); axis([0 256 -0.05 1.05]);
    title('cdf of const gradient im');
end

%%


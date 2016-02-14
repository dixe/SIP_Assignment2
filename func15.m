function Out = func15(l, CDF)
Out = zeros(size(CDF));
    for i = 1 : length(Out)
        Out(l) = find(min(l >= CDF(i)));
    end
end
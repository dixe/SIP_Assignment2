function Out = func15(l, CDF)
Out = zeros(size(CDF));
    for i = 1 : length(Out)
        poss = find(l >= CDF(i), 1 );
        Out(i) = min(poss);
    end
end
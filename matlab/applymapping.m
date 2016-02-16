function out = applymapping(in, map)
    % apply the mapping
    [cs rs] = size(in);
    out = uint8(zeros([cs rs]));
    for r = 1:rs
        for c = 1:cs
            out(c,r) = map( in(c,r)+1 );
        end
    end
end
function Out = fun14(In, C)
In = double(In);
Out = In;
[n,m] = size(In);
for i = 1 : n
    for j = 1 : m
        Out(i,j) = C(In(i,j));
    end
end
end
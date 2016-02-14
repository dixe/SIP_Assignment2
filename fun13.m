function IRes = fun13(Im)
    IRes = cumsum(Im); %Calc sum
    IRes = IRes/ 255.0; % Normalize to lie between 0 and 1
  end
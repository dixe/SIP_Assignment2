function [ Ix_matched_to_Iz ] = histmatch(I_x, I_z)
    Cx = cdf(pdf(I_x));
    Cz = cdf(pdf(I_z));
    Czinv = uint8(pinv( Cz, Cx ));
    Ix_matched_to_Iz = applymapping(I_x, Czinv);
end

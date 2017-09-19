function [ e, idx ] = highest_valence( dos, orbital, ref_e, threshold )
%HIGHEST_VALENCE find the highest valence band level of the given
%orbital. 
%   ref_e is the reference energy level where the search initiate. Fermi
%   level is usually a good reference level.
%   One should examine proper value of threshold, which defaults to 5.0 and
%   may not be a suitable value for the system.

    if nargin < 4
        threshold = 5.0;
    end
    
    n = size(dos, 1);
    for i = n:-1:1
        if (dos(i, orbital) > threshold) && (dos(i, 1) < ref_e)
            e = dos(i, 1);
            idx = i;
            return
        end
    end

    idx = 0;
    e = -inf;
end


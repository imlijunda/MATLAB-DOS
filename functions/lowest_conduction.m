function [ e, idx ] = lowest_conduction( dos, orbital, ref_e, threshold )
%LOWEST_CONDUCTION find the lowest conduction band level of the given
%orbital. 
%   ref_e is the reference energy level where the search initiate. Fermi
%   level is usually a good reference level.
%   One should examine proper value of threshold, which defaults to 5.0 and
%   may not be a suitable value for the system.

    if nargin < 4
        threshold = 5.0;
    end

    n = size(dos, 1);
    for i = 1:n
        if (dos(i, orbital) > threshold) && (dos(i, 1) > ref_e)
            e = dos(i, 1);
            idx = i;
            return
        end
    end

    idx = 0;
    e = inf;
end


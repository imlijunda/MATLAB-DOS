function [ coord ] = wrap_coord( coord, threshold, vector )
%WRAP_COORD Wrap atoms in a unitcell if fall beyond threshold.
% WARNING: This function only works for fractional coordinates, and does no
% sanity check. Please make sure your POSCAR is Direct before using.
% Values of vector: 1 -> wrap alone a, 2 -> b, 3 -> c

    natom = size(coord, 1);
    for i = 1:natom
        if coord(i, vector) > threshold
            coord(i, vector) = coord(i, vector) - 1.0;
        end
    end

end


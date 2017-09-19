function [ gap ] = band_gap( tot_dos, efermi, threshold )
%BAND_GAP Returns band gap.

    if nargin < 3
        threshold = 5.0;
    end
    
    rows = size(tot_dos, 1);
    cols = size(tot_dos, 2);
    dos = zeros(rows, 2);
    if cols == 5
        %spin polarized
        for i = 1:rows
            dos(i, 1) = tot_dos(i, 1);
            dos(i, 2) = tot_dos(i, 2) + tot_dos(i, 3);
        end
    else
        for i = 1:rows
            dos(i, 1) = tot_dos(i, 1);
            dos(i, 2) = tot_dos(i, 2);
        end
    end
    
    [valence, ~] = highest_valence(dos, 2, efermi, threshold);
    [conduction, ~] = lowest_conduction(dos, 2, efermi, threshold);
    gap = conduction - valence;

end


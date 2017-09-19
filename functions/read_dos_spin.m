function [ n_ion, n_dos, Emax, Emin, Efermi,...
           tot_dos, pdos, pdos_sum ] = read_dos_spin( fname, shift_efermi )
%READ_DOS_SPIN Read a spin polarized DOSCAR file.
%   [ n_ion, n_dos, Emax, Emin, Efermi, tot_dos, pdos, pdos_sum ] = 
%   read_dos_spin( fname, shift_efermi ) reads a DOSCAR file with ISPIN 2.
%
%   Input
%   fname: filename of DOSCAR file
%   shift_efermi: optional input, determines wheter Fermi level is shifted
%   to zero
%
%   Output
%   n_ion: total number of ions.
%   n_dos: number of DOS data points per orbital
%   Emax: maximum eigenvalue
%   Emin: minimum eigenvalue
%   Efermi: Fermi level
%   tot_dos: a matrix of total DOS (n_dos x 5)
%   pdos: a 3d array of PDOS (n_ion x n_dos x 19)
%   pdos_sum: a 3d array of summed PDOS (n_ion x n_dos x 7)
%
%   Note on orbitals of output DOS:
%   tot_dos: eigenvalue, up, down, integrated up, integrated down
%   pdos: eigenvalue, s(up, down) py pz px dxy dyz dz2 dxz x2-y2
%   pdos_sum: eigenvalue, s(up, down), p, d

    if nargin < 2
        shift_efermi = false;
    end

    %Load DOS data file
    fid = fopen(fname, 'r');
    if fid < 0
        error('Can not open file.');
    end
    
    %read number of ions
    tmp = fgetl(fid);
    n_ion = sscanf(tmp, '%d %d %d %d');
    n_ion = n_ion(1);
    %skip the following 4 lines
    for i = 1:4
        fgetl(fid);
    end
    %read Emax, Emin, n_DOS, Efermi, and occu?
    tmp = fgetl(fid);
    data = sscanf(tmp, '%f %f %d %f %f');
    Emax = data(1);
    Emin = data(2);
    n_dos = data(3);
    Efermi = data(4);

    %read total dos
    %order:
    %dos up, dos down, dos int up, dos int down
    tot_dos = zeros(n_dos, 5);
    for i = 1:n_dos
        tmp = fgetl(fid);
        tot_dos(i, :) = sscanf(tmp, '%f %f %f %f %f');
    end
    if shift_efermi
        tot_dos(:, 1) = tot_dos(:, 1) - Efermi;
    end

    tmp = fgetl(fid);
    if tmp == ""
        pdos = [];
        pdos_sum = [];
        fclose(fid);
        return
    end

    %read ion contribution
    %order:
    % s(up, down) py pz px dxy dyz dz2 dxz  x2-y2 -> 18 columns
    pdos = zeros(n_ion, n_dos, 1 + 18);
    for i = 1:n_ion
        for j = 1:n_dos
            tmp = fgetl(fid);
            data = sscanf(tmp, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
            for k = 1:19
                pdos(i, j, k) = data(k);
            end
        end
        fgetl(fid);
    end
    fclose(fid);

    eigv = 1;
    s_up = 2;
    s_down = 3;
    p_up = 4;
    p_down = 5;
    d_up = 6;
    d_down = 7;
    
    %Sum s, p, d components
    pdos_sum = zeros(n_ion, n_dos, 7);
    for i = 1:n_ion
        for j = 1:n_dos
            %eigen value
            pdos_sum(i, j, eigv) = pdos(i, j, 1);
            if shift_efermi
                pdos_sum(i, j, eigv) = pdos_sum(i, j, eigv) - Efermi;
            end
            %s up down
            pdos_sum(i, j, s_up) = pdos(i, j, 2);
            pdos_sum(i, j, s_down) = pdos(i, j, 3);
            %p up down
            pdos_sum(i, j, p_up) = pdos(i, j, 4) + pdos(i, j, 6) + pdos(i, j, 8);
            pdos_sum(i, j, p_down) = pdos(i, j, 5) + pdos(i, j, 7) + pdos(i, j, 9);
            %d up down
            pdos_sum(i, j, d_up) = pdos(i, j, 10) + pdos(i, j, 12) + pdos(i, j, 14) + pdos(i, j, 16) + pdos(i, j, 18);
            pdos_sum(i, j, d_down) = pdos(i, j, 11) + pdos(i, j, 13) + pdos(i, j, 15) + pdos(i, j, 17) + pdos(i, j, 19);
        end
    end

end


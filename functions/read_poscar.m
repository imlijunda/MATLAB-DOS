function [ lat_vec, sp_name, sp_list, coord ] = read_poscar( fname )
%READ_POSCAR Read POSCAR file
% lat_vec and coord are read to row-based vectors.

    %Load CONTCAR
    fid = fopen(fname, 'r');
    if fid < 0 
        error('Can not open file.');
    end
    %Ignore title
    fgetl(fid);
    %Read lattice vectors
    scale = sscanf(fgetl(fid), '%f');
    lat_vec = zeros(3, 3);
    for i = 1:3
        tmp = sscanf(fgetl(fid), '%f %f %f');
        for j = 1:3
            lat_vec(i, j) = tmp(j) * scale;
        end
    end
    %Read species
    tmp = split(strtrim(fgetl(fid)));
    sp_name = cell(length(tmp), 1);
    sp_list = cell(length(tmp), 1);
    for i = 1:length(tmp)
        sp_name{i} = tmp{i};
    end
    tmp = split(strtrim(fgetl(fid)));
    start_ptr = 1;
    natom = 0;
    for i = 1:length(tmp)
        total = sscanf(tmp{i}, '%f');
        end_ptr = start_ptr + total - 1;
        natom = natom + total;
        sp_list{i} = start_ptr:end_ptr;
        start_ptr = end_ptr + 1;
    end
    %Ignore Direct/Cartesian
    fgetl(fid);
    %Read coordinate
    coord = zeros(natom, 3);
    for i = 1:natom
        tmp = sscanf(fgetl(fid), '%f %f %f');
        for j = 1:3
            coord(i, j) = tmp(j);
        end
    end
end


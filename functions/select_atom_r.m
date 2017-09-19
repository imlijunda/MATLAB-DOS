function [ selected ] = select_atom_r( lat_vec, coord, ref_atoms, r, from_group)
%SELECT_ATOM_R Select atoms if the distance to ref_atoms is smaller than r.
%   By default this function selects all atoms regardless of species. 
%   The returned selected atoms will include ref_atoms as well.
%   If you want to select only from a specific group of atoms, set
%   from_group to the preferred group.
%   
%   Example
%   % read a POSCAR
%   [ lat_vec, sp_name, sp_list, coord ] = read_poscar( 'POSCAR' )
%   %select from second species
%   ion_name = sp_name{2}
%   ion_group = sp_list{2}
%   %use first species as reference atoms
%   ref_name = sp_name{1}
%   ref_atoms = sp_list{1}
%   r = 4.0
%   selected = select_atom_r(lat_vec, coord, ref_atoms, r, ion_group)
%   n = length(selected)
%   fprintf('%d %s ions selected within the range of %.2f Å of %s ions.\n',
%       n, ion_name, r, ref_name)

    if nargin < 5
        from_group = 1:size(coord, 1);
    end

    % convert to absolute coord
    acoord = lat_vec' * coord';
    selected = [];
    idx = 0;
    for i = 1:length(ref_atoms)
        ref = acoord(:, i);
        for j = from_group
            tmp = acoord(:, j);
            d = norm(ref - tmp);
            if d < r
                idx = idx + 1;
                selected(idx) = j;
            end
        end
    end
    
    selected = unique(selected);

end


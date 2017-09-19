function selected = select_atom_z(atoms, from_group, threshold, surface_dir)
%SELECT_ATOM_Z Select atoms on the surface (beyond threshold level). Default 
%surface direction is surface_dir = 3

    if nargin < 4
        surface_dir = 3;
    end

    selected = [];
    idx = 1;
    for i = from_group
        if atoms(i, surface_dir) > threshold
            selected(idx) = i;
            idx = idx + 1;
        end
    end

end
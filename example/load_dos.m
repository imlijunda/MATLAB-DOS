[lat_vec, sp_name, sp_list, atoms] = read_poscar('testdata/CONTCAR');
ion_O = sp_list{1};
ion_Ti = sp_list{2};
ion_Au = sp_list{3};
atoms = wrap_coord(atoms, 0.8, 3);

[ n_ion, n_dos, Emax, Emin, Efermi, tot_dos, ldos, ldos_sum ] = read_dos_spin( 'testdata/DOSCAR', false );

eigv = 1;
s_up = 2;
s_down = 3;
p_up = 4;
p_down = 5;
d_up = 6;
d_down = 7;
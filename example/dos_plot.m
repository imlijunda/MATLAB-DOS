load_dos

%select surface atoms and calculate LDOS, Au atoms are all selected
s = select_atom_z(atoms, ion_O, 0.14);
Odos = local_spd_dos(ldos_sum, s);
s = select_atom_z(atoms, ion_Ti, 0.14);
Tidos = local_spd_dos(ldos_sum, s);
s = ion_Au;
Audos = local_spd_dos(ldos_sum, s);

%start plotting
%make new figure
fig = figure;
hax = axes;
hold(hax, 'on');
%plot total dos
[h_tot_up, h_tot_dw] = plot_total(tot_dos);

%set line width
lw = 2.0;
%plot O 2p
[xs, ys] = smoothed_line(Odos(:, 1), Odos(:, p_up));
h_o2p_up = plot(xs, ys, 'r:', 'LineWidth', lw);
[xs, ys] = smoothed_line(Odos(:, 1), Odos(:, p_down));
h_o2p_dw= plot(xs, -ys, 'r:', 'LineWidth', lw);
%plot Ti 3d
[xs, ys] = smoothed_line(Tidos(:, 1), Tidos(:, d_up));
h_Ti3d_up = plot(xs, ys, 'b:', 'LineWidth', lw);
[xs, ys] = smoothed_line(Tidos(:, 1), Tidos(:, d_down));
h_Ti3d_dw = plot(xs, -ys, 'b:', 'LineWidth', lw);
%plot Au 5d
[xs, ys] = smoothed_line(Tidos(:, 1), Audos(:, d_up));
h_Au5d_up = plot(xs, ys, 'g:', 'LineWidth', lw);
[xs, ys] = smoothed_line(Tidos(:, 1), Audos(:, d_down));
h_Au5d_dw = plot(xs, -ys, 'g:', 'LineWidth', lw);
%set legends
legend([h_tot_up, h_o2p_up, h_Ti3d_up, h_Au5d_up], ...
       {'Total DOS', 'O_2_p', 'Ti_3_d', 'Au_5_d'});
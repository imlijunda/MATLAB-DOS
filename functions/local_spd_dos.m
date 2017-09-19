function [ ldos ] = local_spd_dos(pdos_sum, selected_atoms)
%LOCAL_SPD_DOS calculate the total local dos of the selected atoms from the
%summed PDOS. Summed PDOS can be calculated from read_dos_spin and
%read_dos_nospin.

    n_dos = size(pdos_sum, 2);
    n_orb = size(pdos_sum, 3);
    ldos = zeros(n_dos, n_orb);
    for i = selected_atoms
        for j = 1:n_dos
            ldos(j, 1) = pdos_sum(i, j, 1);
            for k = 2:n_orb
                ldos(j, k) = ldos(j, k) + pdos_sum(i, j, k);
            end
        end
    end

end
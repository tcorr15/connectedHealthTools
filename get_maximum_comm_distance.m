% assumes all values are in dB
function get_maximum_comm_distance(f, tx_power, tx_eff, rx_eff, snr, noise_floor, rx_sensitivity)
    % Caluclate FSPL
    c = 3*10.^8;
    disp("FSPL(dB) = 20log10(4pif/c) + 20log10(d)");
    fprintf("FSPL(dB) = 20log10(4*pi*%d/%d) + 20log10(d)\n", f, c);
    fprintf("FSPL(dB) = %d + 20log10(d)\n", round(20*log10((4*pi*f)/c), 2));
    
    % Calculate Link Budget
    lower_limit = rx_sensitivity;
     if exist('noise_floor','var')
         if noise_floor > rx_sensitivity
            lower_limit = noise_floor;
         end
     end
     upper_limit = tx_power - tx_eff;
     lower_limit = lower_limit - snr - rx_eff;

     margin_db = abs(lower_limit) - abs(upper_limit);
     disp("Margin = " + margin_db);

     % get d
     fprintf("20log10(d) = %d - %d\n", margin_db, round(20*log10((4*pi*f)/c), 2));
     prop_loss = margin_db - 20*log10((4*pi*f)/c);
     fprintf("20log10(d) = %d\n", round(prop_loss, 2));
     fprintf("d = 10.^(%d/20)\n", round(prop_loss, 2));
     d = 10.^(prop_loss/20);
     disp("d = " + round(d, 1));
end
function get_sp02(r_peak, r_trough, ir_peak, ir_trough, aHbR, aHbO2R, aHbIR)
    % Calculate Amplitudes
    r_amp = round(r_peak - r_trough);
    ir_amp = (ir_peak - ir_trough);
    disp("R = (Iac_R/Idc_R)/(Iac_IR/Idc_IR)");
    r = (r_amp/r_peak)/(ir_amp/ir_peak);
    fprintf("R = (%d/%d)/(%d/%d) = %d\n", r_amp, r_peak, ir_amp, ir_peak, r);
    disp("Sp02 = (aHbR - aHb02R*R) / (aHbR - aHb02R + (aHb02R + aHbIR)*R)");
    fprintf("Sp02 = (%d - %d*%d) / (%d - %d + (%d + %d)*%d)\n", aHbR, aHbO2R, r, aHbR, aHbO2R, aHbO2R, aHbIR, r);
    tp_frac = aHbR - aHbO2R*r;
    bt_frac = aHbR - aHbO2R;
    bt_frac_2 = aHbO2R + aHbIR;
    fprintf("Sp02 = (%d) / (%d + (%d)*%d)\n", tp_frac, bt_frac, bt_frac_2, r);
    bt_frac = bt_frac + bt_frac_2*r;
    fprintf("Sp02 = %d / %d\n", tp_frac, bt_frac);
    spo2 = (aHbR - aHbO2R*r) / (aHbR - aHbO2R + (aHbO2R + aHbIR)*r);
    disp("Sp02 = " + spo2 + " or " + spo2*100 + " %");
end
function get_temperature(vs, thermistor, thermal_sensitivity, r_lead, temp_rise)
    % Get R4 and Lead Length
    diff = 10 + (thermistor - rem(thermistor, 10)) - thermistor;
    disp("Set r4 = thermistor + r_lead");
    fprintf("If r4 = %d\nThen r_lead = %d - %d = %d\n", 10 + (thermistor - rem(thermistor, 10)), 10 + (thermistor - rem(thermistor, 10)), thermistor, diff);
    fprintf("lead_length = %d / %d\n", diff, r_lead);
    disp("lead_length = " + diff/r_lead + "cm");
    
    % Set All resistors to be the same value
    r = 10 + (thermistor - rem(thermistor, 10));
    disp("Set R1=R2=R3=R4 = " + r);

    %Calculate v_sense
    disp("V_Sense = V_a - V_b");
    fprintf("V_Sense = Vs(%d/%d) - Vs(%d/%d) = %d V\n", r, 2*r, r, r*r, vs*(r/(r+r)) - vs*(r/(r+r)));
    r_d = thermistor*((thermal_sensitivity*temp_rise)/100);
    fprintf("R_delta @ %d oC = %d(%d / 100) = %d\n", temp_rise, thermistor, thermal_sensitivity, r_d);
    fprintf("V_Sense @ %d oC\n", temp_rise);
    disp("V_Sense = Vs(R2/(R1+R2)) - Vs(R3/(R3+R_therm+R_delta+R_lead))");
    fprintf("V_Sense = Vs(%d/%d) - Vs(%d/(%d+%d+%d+%d)) = %d V\n", r, 2*r, r, r, thermistor, r_d, diff, vs*(r/(r+r)) - vs*(r/(r+r_d+diff+thermistor)));
    v_s = vs*(r/(r+r)) - vs*(r/(r+r_d+diff+thermistor));

    % Get Gain
    gain = 50;
    while 0.5 >= gain*v_s || 2 <= gain*v_s
        if 0.5 > gain*v_s
            gain = gain + 10;
        else
            gain = gain - 10;
        end
    end
    disp("Gain = " + gain);

    % Get gain circuitry
    disp("G = (1 + 2Ra/Rg)(Rc/Rb)");
    disp("Rg = 2k and Ra=Rb=Rc = " + gain + "k");
    disp("G = " + gain);
end
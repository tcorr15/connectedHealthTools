function get_impedence_pneumography(v, i_a, i_f, rb, rd, e1_c, e1_r, e2_c, e2_r, el_r, deviation)
    % Get Ze1 and Ze2
    % Assuming e1_r and e2_r are >1kohm
    ze1 = 1/(2*pi*i_f*e1_c);
    ze2 = 1/(2*pi*i_f*e2_c);

    % Get v_b and v_d
    v_b = i_a*((2*el_r) + ze1 + ze2 + rb);
    disp("V Base = " + v_b);

    dev = 0:deviation;
    output = [];
    [~, col] = size(dev);
    for i=1:col
        % r_delta
        output(i, 1) = dev(i);
        output(2*dev(end)+1-dev(i), 1) = dev(i);
        % v_delta
        output(i, 2) = i_a*((2*el_r) + ze1 + ze2 + rb + dev(i));
        output(2*dev(end)+1-dev(i), 2) = i_a*((2*el_r) + ze1 + ze2 + rb + dev(i));
        % v_out
        output(i, 3) = output(i, 2) - v_b;
        output(2*dev(end)+1-dev(i), 3) = output(2*dev(end)+1-dev(i), 2) - v_b;
    end
    disp("outout:")
    disp(["R_Base", "V_Delta(V)", "V_Out(uV)"]);
    output(:, 3) = output(:, 3)*10^6;
    disp(output);

    [row, ~] = size(output);
    figure;
    hold on;
    plot(0:row-1, output(:, 3));
end
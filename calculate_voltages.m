function calculate_voltages(p_dBSPL, Vout_V)

% Microphone
p0_dBSPL = 94;
S_dBre1VPa = -40;

% Preamp
A0_dB = 46;

% Amplifier
Amin = 20;
Amax = 200;
Amin_dB = 20*log10(Amin);
Amax_dB = 20*log10(Amax);

Vpre_dBV = p_dBSPL - p0_dBSPL + S_dBre1VPa;
Vpre_V = 10.^(Vpre_dBV/20);

Vin_dBV = Vpre_dBV + A0_dB;
Vin_V = 10.^(Vin_dBV/20);

Vout_dBV = 20*log10(Vout_V);

A_dB = repmat(Vout_dBV', [1 length(Vin_dBV)]) - ...
       repmat(Vin_dBV, [length(Vout_dBV) 1]);
A = 10.^(A_dB/20);

line1 = plot(p_dBSPL, A_dB, 'r');
hold('on')
line2 = plot([p_dBSPL(1) p_dBSPL(end)], [Amin_dB Amax_dB
                                 Amin_dB Amax_dB], '--k');
xlabel('Sound pressure level [dB re 20uPa]');
ylabel('Amplifier gain [dB]');
legend([line1(1) line2(1)],...
       'Limits of acceptable gain',...
       'Limits of amplifier gain');

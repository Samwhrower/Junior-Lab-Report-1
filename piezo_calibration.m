% adapted from Maggie_Sash_Interferometry.m

clear;
instrreset; % resets GPIB instruments

% opens control of LIA and power supply via GPIB
LIA = visadev("LIA");
power_supply = visadev("USB0::0x2A8D::0x1102::MY61001223::0::INSTR");

j = 1;

% runs until all data is collected
% change j condition in while loop to make it collect more data
while j < 3
    
    % sets initial and final volatge and step size
    vi = 0;
    vf = 25;
    dv = 0.01;
    v = vi;
    
    % sets initial voltage of power supply
    write(power_supply, sprintf('SOUR:VOLT %f,(@2)', vi));
    write(power_supply, 'SOUR:CURR 0.200,(@2)');
    write(power_supply,'OUTP ON,(@2)'); % turns power supply on
    pause(3)
    
    % sets array for voltages to be collected i
    v_lia = 0;
    v_power = 0;
    phase_lia = 0;
    i = 1;

    % collects data, plots it, and saves the data
    while v<vf

        % sets power supply to voltage
        write(power_supply, sprintf('SOUR:VOLT %f,(@2)', v));
        pause(0.2);

        % reads the voltage from the LIA and plots
        v_power(i) = v;
        v_lia(i) = 1000*str2num(writeread(LIA,'outp? 2')); % output may need to be edited depending on LIA used
        v = v + dv;
        i = i+1;
        plot(v_power,v_lia)
        xlabel('Power Supply Voltage (V)');
        ylabel('LIA Voltage (mV)');
        title('LIA Voltage (mV) vs. Power Supply Voltage (V)')
    end

    % saves data in a txt and fig, and resets the voltage for next set of data
    data = [v_power; v_lia; phase_lia];
    save(sprintf('interferometry-fab-per-09-19-set3-auto%d.txt', j), 'data', '-ascii' );
    savefig(sprintf('interferometry-fab-per-09-19-set3-auto%d.fig', j));
    j = 1 + j;
    v = 0;
end

% turns power supply to 0 volts and closes instruments
fprintf(power_supply, 'SOUR:VOLT %f', 0);
delete(LIA);
delete(power_supply);

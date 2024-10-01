% adapted from Maggie_Sash_Interferometry.m

clear

instrreset; % resets GPIB instruments

% opens control of LIA and power supply via GPIB
LIA = visadev("LIA");
power_supply = visadev("USB0::0x2A8D::0x1102::MY61001223::0::INSTR");

% opens power supply and LIA
% fopen(power_supply);
% fopen(LIA);


%creating time array 
    
% sets initial and final volatge and step size
vi = 0;
vf = 25;
dv = 0.01;
v = vi;

% sets initial voltage of power supply
pause(1)

% sets array for voltages to be collected in
v_lia = 0;
v_power = 0;
phase_lia = 0;
i = 1;

while 1
    pause(0.2);
    v_power(i) = i;
    v_lia(i) = 1000*str2num(writeread(LIA,'outp? 3'));
    i = i+1;
    %plot(v_power,v_lia)
    plot(v_power,v_lia)
    xlabel('Power Supply Voltage (V)');
    ylabel('LIA Voltage (mV)');
    title('LIA Voltage (mV) vs. Power Supply Voltage (V)')
end

% turns power supply to 0 volts and closes instruments
fprintf(power_supply, 'SOUR:VOLT %f', 0);
delete(LIA);
delete(power_supply);
%% 

% save data
%v data = [v_power; v_lia; phase_lia];
% save('interferometry-sweepdata-09-05.txt', 'data', '-ascii' );
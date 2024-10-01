% adapted from Maggie_Sash_Interferometry.m

clear

instrreset; % resets GPIB instruments

% opens control of LIA and power supply via GPIB
LIA = visadev("LIA");
power_supply = visadev("USB0::0x2A8D::0x1102::MY61001223::0::INSTR");

% sets initial and final volatge and step size
vi = 0;
vf = 25;
dv = 0.01;
v = vi;
pause(1)

% sets array for voltages to be collected in
v_lia = 0;
v_power = 0;
phase_lia = 0;
i = 1;

% takes measurements and plots them
% runs until manually stopped in editor
while 1
    pause(0.2);
    v_lia(i) = 1000*str2num(writeread(LIA,'outp? 3')); % output may need to be edited depending on LIA used
    i = i+1;
    plot(i,v_lia)
    xlabel('Measurement Number');
    ylabel('LIA Voltage (mV)');
    title('LIA Voltage (mV) vs. Measurement Number')
end

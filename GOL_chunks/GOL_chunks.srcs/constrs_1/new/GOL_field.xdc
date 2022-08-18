## Clock signal
create_clock -add -name clk_stepper -period 10.00 -waveform {0 5} [get_ports {i_clk_stepper}];
create_clock -add -name clk_read -period 6.796 -waveform {0 5} [get_ports {i_clk_read}];

set_clock_groups -asynchronous -group {clk_stepper};
set_clock_groups -asynchronous -group {clk_read};
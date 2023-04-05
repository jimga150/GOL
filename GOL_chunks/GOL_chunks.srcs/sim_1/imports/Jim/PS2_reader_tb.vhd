----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2023 18:51:12
-- Design Name: PS2_reader_tb
-- Module Name: PS2_reader_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Created with VHDL Test Bench Template Generator
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

entity PS2_reader_tb is
end PS2_reader_tb;

architecture Behavioral of PS2_reader_tb is
	
	--Clocks
	signal i_ps2_clk : std_logic := '1';
	signal i_sys_clk : std_logic := '0';
	
	--Resets
	signal i_sys_rst : std_logic := '1';
	
	--General inputs
	signal i_ps2_dat : std_logic := '1';
	
	signal i_ready : std_logic := '0';
	
	--Outputs
	signal o_data : std_logic_vector(7 downto 0);
	signal o_data_valid : std_logic;
	signal o_data_error : std_logic;
	
	--Clock Periods
	constant i_ps2_clk_period : time := 2*(40 us);
	constant i_sys_clk_period : time := 10 ns;
	
    constant c_num_words_to_send : integer := 20;
    
    type t_data_arr is array(c_num_words_to_send-1 downto 0) of std_logic_vector(7 downto 0);
    signal s_data_arr : t_data_arr;
    signal s_parity_errs : boolean_vector(s_data_arr'range);
	
begin
	
	UUT: entity work.PS2_reader
	port map(
		i_ps2_clk => i_ps2_clk,
		i_sys_clk => i_sys_clk,
		i_sys_rst => i_sys_rst,
		i_ps2_dat => i_ps2_dat,
		o_data => o_data,
		o_data_valid => o_data_valid,
		o_data_error => o_data_error,
		i_ready => i_ready
	);
	
	--Clock Drivers
	i_ps2_clk <= not i_ps2_clk after i_ps2_clk_period/2;
	i_sys_clk <= not i_sys_clk after i_sys_clk_period/2;
	
	
    ps2_stim_proc: process is
        variable v_seed1, v_seed2 : positive;
        variable v_rnd : real;
        variable v_data : integer;
        variable v_data_slv : std_Logic_vector(7 downto 0);
        variable v_parity : std_logic;
        variable v_cycles : integer;
    begin
    
        wait for i_ps2_clk_period;
        
        i_sys_rst <= '0';
        
        wait for i_ps2_clk_period;
        
        --Insert stimuli here
        
        for i in s_data_arr'range loop
        
            --make up and record word
            uniform(v_seed1, v_seed2, v_rnd);
            v_data := integer(v_rnd*256);
            v_data_slv := std_logic_vector(to_unsigned(v_data, v_data_slv'length));
            s_data_arr(i) <= v_data_slv;
            v_parity := xnor v_data_slv;
            s_parity_errs(i) <= false;
            
            --insert some errors
            uniform(v_seed1, v_seed2, v_rnd);
            if (v_rnd < 0.3) then
                v_parity := not v_parity;
                s_parity_errs(i) <= true;
            end if;
            
            --transmit word
            i_ps2_dat <= '0';
            wait for i_ps2_clk_period;
            
            for b in v_data_slv'low to v_data_slv'high loop
                i_ps2_dat <= v_data_slv(b);
                wait for i_ps2_clk_period;
            end loop;
            
            i_ps2_dat <= v_parity;
            wait for i_ps2_clk_period;
            
            i_ps2_dat <= '1';
            wait for i_ps2_clk_period;
            
            --generate random number of cycles
            uniform(v_seed1, v_seed2, v_rnd);
            v_cycles := integer(v_rnd*5);
            
            wait for i_ps2_clk_period*v_cycles;
            
        end loop;
        
        assert false report "End Simulation" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
    
    end process;
    
    sys_stim_proc: process is begin
    
        wait until i_sys_rst = '0';
        
        for i in s_data_arr'range loop
            
            if (o_data_valid = '0') then
                wait until o_data_valid = '1';
            end if;
            
            if (s_parity_errs(i)) then
                assert o_data_error = '1'
                    report "Expected data error flag on word " & integer'image(i) & ", but none was reported"
                    severity error;
            else
                assert o_data_error = '0'
                    report "Got data error flag on word " & integer'image(i) & ", but none was expected"
                    severity error;
            end if;
            
            wait for i_sys_clk_period*3;
            
            i_ready <= '1';
            
            assert o_data = s_data_arr(i)
                report "Data mismatch at word " & integer'image(i) & "--expected " & 
                integer'image(to_integer(unsigned(s_data_arr(i)))) & ", got " & 
                integer'image(to_integer(unsigned(o_data))) severity error; 
            
            wait for i_sys_clk_period;
            
            i_ready <= '0';
            
            wait for i_sys_clk_period;
            
        end loop;
        
    
    end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/23/2022 18:44:52
-- Design Name: bram_dp_custom_tb
-- Module Name: bram_dp_custom_tb - Behavioral
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
use IEEE.MATH_REAL.ALL;
use work.GOL_pkg.all;

entity bram_dp_custom_tb is
end bram_dp_custom_tb;

architecture Behavioral of bram_dp_custom_tb is
    
    --Generics
    constant g_init_cells : t_block_chunk_arr := c_empty_block;
    
    
    --Clocks
    signal i_clka : std_logic := '0';
    signal i_clkb : std_logic := '0';
    
    --General inputs
    signal i_ena : std_logic := '0';
    signal i_wea : std_logic := '0';
    signal i_addra : std_logic_vector(c_bram_addr_bits-1 downto 0) := (others => '0');
    signal i_dina : std_logic_vector(c_bram_width-1 downto 0) := (others => '0');
    signal i_enb : std_logic := '0';
    signal i_web : std_logic := '0';
    signal i_addrb : std_logic_vector(c_bram_addr_bits-1 downto 0) := (others => '0');
    signal i_dinb : std_logic_vector(c_bram_width-1 downto 0) := (others => '0');
    
    --Outputs
    signal o_douta : std_logic_vector(c_bram_width-1 downto 0);
    signal o_doutb : std_logic_vector(c_bram_width-1 downto 0);
    
    --Clock Periods
    constant i_clka_period : time := 10 ns;
    constant i_clkb_period : time := 6.123 ns;
    
    constant c_read_delay : integer := 3;
    
begin
    
    UUT: entity work.bram_dp_custom
    generic map(
        g_init_cells => g_init_cells
    )
    port map(
        i_clka => i_clka,
        i_clkb => i_clkb,
        i_ena => i_ena,
        i_wea => i_wea,
        i_addra => i_addra,
        i_dina => i_dina,
        o_douta => o_douta,
        i_enb => i_enb,
        i_web => i_web,
        i_addrb => i_addrb,
        i_dinb => i_dinb,
        o_doutb => o_doutb
    );
    
    --Clock Drivers
    i_clka <= not i_clka after i_clka_period/2;
    i_clkb <= not i_clkb after i_clkb_period/2;
    
    stim_proc: process is
        
        constant c_num_addrs_test : integer := 100;
        constant c_addr_step : integer := c_bram_depth/c_num_addrs_test;
        
        variable v_addr_int : integer;
        
        type t_write_rec_type is record
            addr : std_logic_vector(c_bram_addr_bits-1 downto 0);
            data : std_logic_vector(c_bram_width-1 downto 0);
        end record t_write_rec_type;
        type t_writes_type is array(c_num_addrs_test-1 downto 0) of t_write_rec_type;
        
        variable v_writes : t_writes_type;
        
        variable v_pass : boolean := true;
        
    begin
        
        wait for i_clka_period;
        
        --Insert stimuli here
        
        --write data in on port A
        i_ena <= '1';
        i_wea <= '1';
        
        for i in 0 to c_num_addrs_test-1 loop
        
            v_addr_int := i*c_addr_step;
            v_writes(i).addr := std_logic_vector(to_unsigned(v_addr_int, v_writes(i).addr'length));
            v_writes(i).data := std_logic_vector(to_unsigned(v_addr_int, v_writes(i).data'length));
            
            i_addra <= v_writes(i).addr;
            i_dina <= v_writes(i).data;
            
            wait for i_clka_period;
            
        end loop;
        
        --read from port A first
        i_wea <= '0';
        
        for i in 0 to c_num_addrs_test-1 loop
        
            i_addra <= v_writes(i).addr;
            
            wait for i_clka_period;
            
            i_addra <= (others => '0');
            
            wait for i_clka_period*(c_read_delay-1);
            
            if (o_douta /= v_writes(i).data) then
                v_pass := false;
                report "Port A: Data mismatch at address " & integer'image(to_integer(unsigned(v_writes(i).addr)))
                severity error;
            end if;
                
            
        end loop;
        
        i_ena <= '0';
        
        --read same from port B
        wait until falling_edge(i_clkb);
        
        i_enb <= '1';
        
        for i in 0 to c_num_addrs_test-1 loop
        
            i_addrb <= v_writes(i).addr;
            
            wait for i_clkb_period;
            
            i_addrb <= (others => '0');
            
            wait for i_clkb_period*(c_read_delay-1);
            
            if (o_doutb /= v_writes(i).data) then
                v_pass := false;
                report "Port B: Data mismatch at address " & integer'image(to_integer(unsigned(v_writes(i).addr)))
                severity error;
            end if;
            
        end loop;
        
        --write data in on port B next
        i_web <= '1';
        
        for i in 0 to c_num_addrs_test-1 loop
        
            v_addr_int := i*c_addr_step;
            v_writes(i).addr := std_logic_vector(to_unsigned(v_addr_int, v_writes(i).addr'length));
            v_writes(i).data := std_logic_vector(to_unsigned(v_addr_int + 7, v_writes(i).data'length));
            i_addrb <= v_writes(i).addr;
            i_dinb <= v_writes(i).data;
            
            wait for i_clkb_period;
            
        end loop;
        
        --read from port B first
        i_web <= '0';
        
        for i in 0 to c_num_addrs_test-1 loop
        
            i_addrb <= v_writes(i).addr;
            
            wait for i_clkb_period;
            
            i_addrb <= (others => '0');
            
            wait for i_clkb_period*(c_read_delay-1);
            
            if (o_doutb /= v_writes(i).data) then
                v_pass := false;
                report "Port B: Data mismatch at address " & integer'image(to_integer(unsigned(v_writes(i).addr)))
                severity error;
            end if;
            
        end loop;
        
        i_enb <= '0';
        
        --read from port A next
        wait until falling_edge(i_clka);
        
        i_ena <= '1';
        
        for i in 0 to c_num_addrs_test-1 loop
        
            i_addra <= v_writes(i).addr;
            
            wait for i_clka_period;
            
            i_addra <= (others => '0');
            
            wait for i_clka_period*(c_read_delay-1);
            
            if (o_douta /= v_writes(i).data) then
                v_pass := false;
                report "Port A: Data mismatch at address " & integer'image(to_integer(unsigned(v_writes(i).addr)))
                severity error;
            end if;
            
        end loop;
        
        assert v_pass report "Test Failed!" severity failure;
        assert false report "Test Passed" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;

end Behavioral;

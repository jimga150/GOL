----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2020 05:56:20 PM
-- Design Name: 
-- Module Name: rm_sm_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library work;
use work.GOL_package.all;

entity rm_sm_tb is
--  Port ( );
end rm_sm_tb;

architecture Behavioral of rm_sm_tb is

    signal clk, pixel_clk, rst : std_logic := '0';
    signal count_in : std_logic_vector(GOL_col_addr_length-1 downto 0) := (others => '0');
    
    signal vsync, disp_en, hsync, rstn : std_logic;
    signal column_vga, row_vga : integer;
    signal row_vga_vect : std_logic_vector(GOL_row_addr_length-1 downto 0);
    
    signal row_out : std_logic_vector(GOL_row_addr_length-1 downto 0);
    signal ar_valid, rd_ready, count_rst : std_logic;
    
    constant clk_period : time := 10ns;
    constant pixel_clk_period : time := 21ns;

begin

    rstn <= not rst;
    
    clk <= not clk after clk_period/2;
    pixel_clk <= not pixel_clk after pixel_clk_period/2;
    
    row_vga_vect <= std_logic_vector(to_unsigned(row_vga, GOL_row_addr_length));
    
    process(clk) is begin
        if rising_edge(clk) then
            if count_rst = '1' then
                count_in <= (others => '0');
            elsif ar_valid = '1' or rd_ready = '1' then
                count_in <= std_logic_vector(unsigned(count_in) + 1);
            end if;
        end if;
    end process;

    uut: entity work.read_module_SM
    port map(
        clk => clk,
        rst => rst,
        vsync => vsync,
        disp_en => disp_en,
        hsync => hsync,
        row_out => row_out,
        count_in => count_in,
        row_vga_in => row_vga_vect,
        ar_valid => ar_valid,
        rd_ready => rd_ready,
        count_rst => count_rst
    );
    
    vga_cont_inst: entity work.vga_controller
    port map(
        pixel_clk => pixel_clk,
        reset_n => rstn,
        h_sync => hsync,
        v_sync => vsync,
        disp_ena => disp_en,
        column => column_vga,
        row => row_vga
    );
    
    stim_proc: process is begin
        rst <= '1';
        
        wait for clk_period*5;
        
        rst <= '0';
        
        wait until rising_edge(vsync);
        wait until rising_edge(vsync);
        wait until rising_edge(vsync);
        
        assert false report "End Simulation" severity failure;
        
    end process stim_proc;

end Behavioral;

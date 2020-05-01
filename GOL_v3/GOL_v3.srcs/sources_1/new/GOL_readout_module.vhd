----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2020 02:34:14 PM
-- Design Name: 
-- Module Name: GOL_readout_module - Structural
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

entity GOL_readout_module is
    port(
        clk, pixel_clk, rst : in std_logic;
        
        num_rows, num_cols : std_logic_vector(15 downto 0);
        
        ar_valid : out std_logic;
        ar_ready : in std_logic;
        ar_addr : out std_logic_vector(31 downto 0);
        
        rd_valid : in std_logic;
        rd_ready : out std_logic;
        rd_data : in std_logic_vector(31 downto 0);
        
        h_sync, v_sync, pixel : out std_logic
    );
end GOL_readout_module;

architecture Structural of GOL_readout_module is

    signal vsync, disp_en, hsync, count_rst, ar_valid_from_sm, rd_ready_from_sm, rstn : std_logic;
    
    signal count : std_logic_vector(15 downto 0) := (others => '0');
    
    signal row_vga_int, col_vga_int : integer;
    signal row_vga_vect, col_vga_vect, row_sm : std_logic_vector(15 downto 0);

begin

    row_vga_vect <= std_logic_vector(to_unsigned(row_vga_int, row_vga_vect'length));
    col_vga_vect <= std_logic_vector(to_unsigned(col_vga_int, col_vga_vect'length));
    
    ar_valid <= ar_valid_from_sm;
    rd_ready <= rd_ready_from_sm;
    
    rstn <= not rst;

    process(clk) is begin
        if rising_edge(clk) then
            if count_rst = '1' then
                count <= (others => '0');
            elsif (ar_valid_from_sm = '1' and ar_ready = '1') or (rd_ready_from_sm = '1' and rd_valid = '1') then
                count <= std_logic_vector(unsigned(count) + 1);
            end if;
        end if;
    end process;

    SM: entity work.read_module_SM
    port map(
        clk => clk,
        rst => rst,
        vsync => vsync,
        disp_en => disp_en,
        hsync => hsync,
        count_in => count,
        count_rst => count_rst,
        row_vga_in => row_vga_vect,
        row_out => row_sm,
        ar_valid => ar_valid_from_sm,
        rd_ready => rd_ready_from_sm
    );

    vga_cont_inst: entity work.vga_controller
    port map(
        pixel_clk => pixel_clk,
        reset_n => rstn,
        
    );
    
    

end Structural;

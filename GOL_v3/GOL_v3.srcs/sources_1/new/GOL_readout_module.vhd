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

library work;
use work.GOL_package.all;

entity GOL_readout_module is
    port(
        clk, pixel_clk, rst, frame_parity : in std_logic;
        
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

    signal vsync, disp_en, hsync, count_rst, ar_valid_from_sm, rd_ready_from_sm, rstn, rx_word, pixel_from_regs : std_logic;
    
    signal count : std_logic_vector(GOL_col_addr_length-1 downto 0) := (others => '0');
    
    signal row_vga_int, col_vga_int : integer;
    signal row_vga_vect, row_sm : std_logic_vector(GOL_row_addr_length-1 downto 0);
    signal col_vga_vect : std_logic_vector(GOL_pixel_col_addr_length-1 downto 0);

begin

    row_vga_vect <= std_logic_vector(to_unsigned(row_vga_int, row_vga_vect'length));
    col_vga_vect <= std_logic_vector(to_unsigned(col_vga_int, col_vga_vect'length));
    
    ar_valid <= ar_valid_from_sm;
    rd_ready <= rd_ready_from_sm;
    
    rx_word <= rd_ready_from_sm and rd_valid;
    
    rstn <= not rst;
    
    h_sync <= hsync;
    v_sync <= vsync;

    process(clk) is begin
        if rising_edge(clk) then
            if count_rst = '1' then
                count <= (others => '0');
            elsif (ar_valid_from_sm = '1' and ar_ready = '1') or rx_word = '1' then
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
        ar_ready => ar_ready,
        rd_valid => rd_valid,
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
        h_sync => hsync,
        v_sync => vsync,
        disp_ena => disp_en,
        row => row_vga_int,
        column => col_vga_int,
        n_blank => open,
        n_sync => open
    );
    
    row_regs: entity work.row_registers
    port map(
        clk => clk,
        rst => rst,
        write_en => rx_word,
        write_addr => count,
        read_addr => col_vga_vect,
        write_data => rd_data,
        pixel => pixel_from_regs
    );
    
    addr_combine: entity work.address_combiner
    port map(
        row => row_sm,
        col => count,
        addr_out => ar_addr(GOL_frame_addr_length-1 downto 0)
    );
    
    ar_addr(31 downto GOL_frame_addr_length+1) <= (others => '0');
    ar_addr(GOL_frame_addr_length) <= frame_parity;
    
    pixel <= pixel_from_regs and disp_en;

end Structural;

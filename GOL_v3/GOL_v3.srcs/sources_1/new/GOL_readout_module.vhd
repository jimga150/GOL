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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL_readout_module is
    port(
        clk, pixel_clk, rst : in std_logic;
        
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

    signal vsync, disp_en, hsync : std_logic;

begin

    SM: entity read_module_sm
    port map(
        clk => clk,
        rst => rst,
        vsync => vsync,
        disp_en => disp_en,
        hsync => hsync,
    );

    vga_cont_inst: entity work.vga_controller
    port map(
        
    );
    
    

end Structural;

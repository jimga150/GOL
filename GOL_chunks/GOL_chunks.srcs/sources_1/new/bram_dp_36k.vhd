----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/25/2022 10:39:00 AM
-- Design Name: 
-- Module Name: bram_dp_36k - Behavioral
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

entity bram_dp_36k is
    PORT (
        i_clka : IN STD_LOGIC;
        i_ena : IN STD_LOGIC;
        i_wea : IN STD_LOGIC;
        i_addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        i_dina : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
        o_douta : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
        
        i_clkb : IN STD_LOGIC;
        i_enb : IN STD_LOGIC;
        i_web : IN STD_LOGIC;
        i_addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        i_dinb : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
        o_doutb : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
      );
end bram_dp_36k;

architecture Behavioral of bram_dp_36k is

    COMPONENT blk_mem_gen_0
      PORT (
        clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
        clkb : IN STD_LOGIC;
        enb : IN STD_LOGIC;
        web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        dinb : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
        doutb : OUT STD_LOGIC_VECTOR(35 DOWNTO 0)
      );
    END COMPONENT;

begin

    bram_inst : blk_mem_gen_0
      PORT MAP (
        clka => i_clka,
        ena => i_ena,
        wea(0) => i_wea,
        addra => i_addra,
        dina => i_dina,
        douta => o_douta,
        clkb => i_clkb,
        enb => i_enb,
        web(0) => i_web,
        addrb => i_addrb,
        dinb => i_dinb,
        doutb => o_doutb
      );

end Behavioral;

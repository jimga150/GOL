----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2020 07:57:39 PM
-- Design Name: 
-- Module Name: grid_reader - Behavioral
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

entity grid_reader is
    port(
        clk, rst, read : in std_logic;
        addr_in : in std_logic_vector(5 downto 0);
        grid_index_en : out std_logic_vector(8 downto 0);
        dout : out std_logic_vector(63 downto 0)
    );
end grid_reader;

architecture Behavioral of grid_reader is
    
    signal br_en : std_logic;
    signal addr_to_bram : std_logic_vector(5 downto 0);
    
     COMPONENT blk_mem_gen_0
      PORT (
        clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
      );
    END COMPONENT;
    
begin

    SM: entity work.nine_read_sm
    port map(
        clk => clk,
        rst => rst, 
        read => read, 
        addr_base => addr_in,
        br_en => br_en,
        addr_out => addr_to_bram,
        grid_index_en => grid_index_en
    );
    
    bram : blk_mem_gen_0
      PORT MAP (
        clka => clk,
        ena => br_en,
        wea => "0",
        addra => addr_to_bram,
        dina => (others => '0'),
        douta => dout
      );
    
end Behavioral;

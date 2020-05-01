----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/18/2020 12:23:07 PM
-- Design Name: 
-- Module Name: GOL - Behavioral
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

package ternary_fxn is 
    function ternr(cond : boolean; iftrue, iffalse : integer) return integer;
end ternary_fxn;

package body ternary_fxn is 
    function ternr(cond : boolean; iftrue, iffalse : integer) 
        return integer is begin
        if cond then return iftrue;
        else return iffalse;
        end if;
    end;
end ternary_fxn;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use work.ternary_fxn.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity GOL is
    generic (
        w : integer := 40;
        h : integer := 40
    );
    Port ( 
        clk, rst : in STD_LOGIC;
        row : in integer;
        col : in integer;
        val : out STD_LOGIC
    );
end GOL;

architecture Behavioral of GOL is
    
    type neighbor_count_row_type is 
        array(w-1 downto 0) of
        std_logic_vector(7 downto 0);
        
    type GOL_neighbor_grid_type is 
        array(h-1 downto 0) of 
        neighbor_count_row_type;
    
    signal neighbor_counts : GOL_neighbor_grid_type;
    

    type GOL_grid_type is 
        array(h-1 downto 0) of 
        std_logic_vector(w-1 downto 0);
        
    signal GOL_outputs : GOL_grid_type;
    signal GOL_init_full : GOL_grid_type;

    
    constant init_width : integer := 38;
    constant init_height : integer := 11;
    type GOL_partial_init_type is 
        array(init_height-1 downto 0) of 
        std_logic_vector(init_width-1 downto 0);
        
    constant GOL_partial_init : GOL_partial_init_type := (
        0 => (others => '0'),
        1 => "00000000000000000000000001000000000000",
        2 => "00000000000000000000000101000000000000",
        3 => "00000000000001100000011000000000000110",
        4 => "00000000000010001000011000000000000110",
        5 => "01100000000100000100011000000000000000",
        6 => "01100000000100010110000101000000000000",
        7 => "00000000000100000100000001000000000000",
        8 => "00000000000010001000000000000000000000",
        9 => "00000000000001100000000000000000000000",
        10 => (others => '0')
    );
    
    signal corrected_row, corrected_col : integer;
    
begin

    rows: for r in 0 to h-1 generate
        constant prev_row : integer := ternr(r = 0, h-1, r-1);
        constant next_row : integer := ternr(r = h-1, 0, r+1);
    begin
        
        cols: for c in 0 to w-1 generate
            constant prev_col : integer := ternr(c = 0, w-1, c-1);
            constant next_col : integer := ternr(c = w-1, 0, c+1);
        begin
            
            neighbor_counts(r)(c) <= 
                GOL_outputs(prev_row)(prev_col) &   GOL_outputs(prev_row)(c) &  GOL_outputs(prev_row)(next_col) &
                GOL_outputs(r)(prev_col) &                                      GOL_outputs(r)(next_col) &
                GOL_outputs(next_row)(prev_col) &   GOL_outputs(next_row)(c) &  GOL_outputs(next_row)(next_col);
            
            init_mapping: if c < init_width and r < init_height generate begin
                GOL_init_full(r)(c) <= GOL_partial_init(r)(c);
            end generate;
            
            init_grounding: if c >= init_width or r >= init_height generate begin
                GOL_init_full(r)(c) <= '0';
            end generate;
            
            gol_cell_inst : entity work.GOL_cell
            port map(
                clk_gc => clk,
                preset_en => rst,
                preset => GOL_init_full(r)(c),
                neighbors => neighbor_counts(r)(c),
                cell_val => GOL_outputs(r)(c)
            );
            
        end generate cols;
    end generate rows;
    
    corrected_row <= row when row < 40 and row >= 0 else 0;
    corrected_col <= col when col < 40 and col >= 0 else 0;
    val <= GOL_outputs(corrected_row)(corrected_col);

end Behavioral;

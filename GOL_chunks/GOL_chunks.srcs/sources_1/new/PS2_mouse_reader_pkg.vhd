----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2023 07:52:30 PM
-- Design Name: 
-- Module Name: PS2_mouse_reader_pkg - Behavioral
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

package PS2_mouse_reader_pkg is

    constant c_resp_self_test_passed : std_logic_vector(7 downto 0) := X"AA";
    constant c_resp_mouse_id : std_logic_vector(7 downto 0) := X"00";
    constant c_resp_ack : std_logic_vector(7 downto 0) := X"FA";
    constant c_resp_resend : std_logic_vector(7 downto 0) := X"FE";
    constant c_resp_error : std_logic_vector(7 downto 0) := X"FC";
    
    constant c_cmd_reset : std_logic_vector(7 downto 0) := X"FF";
    constant c_cmd_resend : std_logic_vector(7 downto 0) := X"FE";
    constant c_cmd_set_defaults : std_logic_vector(7 downto 0) := X"F6";
    constant c_cmd_dis_data_reporting : std_logic_vector(7 downto 0) := X"F5";
    constant c_cmd_en_data_reporting : std_logic_vector(7 downto 0) := X"F4";
    constant c_cmd_set_sample_rate : std_logic_vector(7 downto 0) := X"F3";
    constant c_cmd_get_dev_id : std_logic_vector(7 downto 0) := X"F2";
    constant c_cmd_set_remote_mode : std_logic_vector(7 downto 0) := X"F0";
    constant c_cmd_set_wrap_mode : std_logic_vector(7 downto 0) := X"EE";
    constant c_cmd_rst_wrap_mode : std_logic_vector(7 downto 0) := X"EC";
    constant c_cmd_read_data : std_logic_vector(7 downto 0) := X"EB";
    constant c_cmd_set_stream_mode : std_logic_vector(7 downto 0) := X"EA";
    constant c_cmd_status_req : std_logic_vector(7 downto 0) := X"E9";
    constant c_cmd_set_resolution : std_logic_vector(7 downto 0) := X"E8";
    constant c_cmd_set_scaling_2_1 : std_logic_vector(7 downto 0) := X"E7";
    constant c_cmd_set_scaling_1_1 : std_logic_vector(7 downto 0) := X"E6";

end PS2_mouse_reader_pkg;

package body PS2_mouse_reader_pkg is

end PS2_mouse_reader_pkg;

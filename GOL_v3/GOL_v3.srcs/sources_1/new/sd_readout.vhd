----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/01/2020 02:58:03 PM
-- Design Name: 
-- Module Name: sd_readout - Behavioral
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

entity sd_readout is
    port(
        clk, rst : in std_logic;
        
        sd_rd_multiple, sd_ready : out std_logic;
        sd_error, sd_valid : in std_logic; --not exactly AXI4, but it does have a data handshake just like AXI4.
        sd_din : in std_logic_vector(7 downto 0);
        sd_block_addr : out std_logic_vector(31 downto 0);
        
        wa_addr : out std_logic_vector(31 downto 0);
        wa_valid : out std_logic;
        wa_ready : in std_logic;
        
        wd_data : out std_logic_vector(31 downto 0);
        wd_valid : out std_logic;
        wd_ready : in std_logic;
        
        wr_resp : in std_logic_vector(1 downto 0);
        wr_ready : out std_logic;
        wr_valid : in std_logic;
        
        done_flag : out std_logic
    );
end sd_readout;

architecture Behavioral of sd_readout is

    constant num_words : integer := GOL_num_words_per_frame;
    constant num_words_vect : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(num_words, 32));
    

    type state_type is (
        IDLE,
        WAIT_READ, 
        TAKE_DATA,
        WAIT_AW,
        WAIT_DW,
        WAIT_WR,
        DONE
    );
    signal state, next_state : state_type := IDLE;
    
    signal word, addr : std_logic_vector(31 downto 0) := (others => '0');
    signal word_index : integer range 0 to 3 := 0;

begin

    sd_block_addr <= (others => '0');
    wa_addr <= addr;
    wd_data <= word;

    sync_proc: process(clk) is begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= IDLE;
                word <= (others => '0');
                addr <= (others => '0');
                word_index <= 0;
            else
                state <= next_state;
                
                if state = TAKE_DATA then
                    word((word_index+1)*8 - 1 downto word_index*8) <= sd_din;
                     word_index <= word_index + 1;
                end if;
                
                if state = WAIT_AW then
                    word_index <= 0;
                end if;
                
                if state = WAIT_DW and next_state = WAIT_WR then
                    addr <= std_logic_vector(unsigned(addr) + 1);
                end if;
                
            end if;
        end if;
    end process sync_proc;
    
    ns_proc: process(state, sd_valid, wa_ready, wd_ready, wr_valid, word_index, addr) is begin
        case state is
            when IDLE => 
                next_state <= WAIT_READ;
            when WAIT_READ => 
                if sd_valid = '1' then
                    next_state <= TAKE_DATA;
                else
                    next_state <= WAIT_READ;
                end if;
            when TAKE_DATA => 
                if word_index = 3 then
                    next_state <= WAIT_AW;
                else
                    next_state <= WAIT_READ;
                end if;
            when WAIT_AW => 
                if wa_ready = '1' then
                    next_state <= WAIT_DW;
                else
                    next_state <= WAIT_AW;
                end if;
            when WAIT_DW => 
                if wd_ready = '1' then
                    next_state <= WAIT_WR;
                else
                    next_state <= WAIT_DW;
                end if;
            when WAIT_WR =>
                if wr_valid = '1' then
                    if addr = num_words_vect then
                        next_state <= DONE;
                    else
                        next_state <= WAIT_READ;
                    end if; 
                else
                    next_state <= WAIT_WR;
                end if; 
            when DONE => 
                next_state <= DONE;
        end case;
    end process ns_proc;
    
    rd_proc: process(state) is begin
        case state is
            when IDLE | DONE => sd_rd_multiple <= '0';
            when others => sd_rd_multiple <= '1';
        end case;
    end process rd_proc;
    
    sdr_proc: process(state) is begin
        case state is
            when TAKE_DATA => sd_ready <= '1';
            when others => sd_ready <= '0';
        end case;
    end process sdr_proc;
    
    wav_proc: process(state) is begin
        case state is
            when WAIT_AW => wa_valid <= '1';
            when others => wa_valid <= '0';
        end case;
    end process wav_proc;
    
    wdv_proc: process(state) is begin
        case state is
            when WAIT_DW => wd_valid <= '1';
            when others => wd_valid <= '0';
        end case;
    end process wdv_proc;
    
    wrr_proc: process(state) is begin
        case state is
            when WAIT_WR => wr_ready <= '1';
            when others => wr_ready <= '0';
        end case;
    end process wrr_proc;
    
    done_flag_proc: process(state) is begin
        case state is
            when DONE => done_flag <= '1';
            when others => done_flag <= '0';
        end case;
    end process done_flag_proc;

end Behavioral;

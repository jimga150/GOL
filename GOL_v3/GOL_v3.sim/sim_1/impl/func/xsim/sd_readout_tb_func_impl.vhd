-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1.3 (win64) Build 2644227 Wed Sep  4 09:45:24 MDT 2019
-- Date        : Wed Sep  2 11:59:28 2020
-- Host        : DESKTOP-JKR6EMK running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/Users/Jim/Desktop/Code/VHDL/GOL/GOL_v3/GOL_v3.sim/sim_1/impl/func/xsim/sd_readout_tb_func_impl.vhd
-- Design      : sd_readout
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity sd_readout is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    sd_rd_multiple : out STD_LOGIC;
    sd_ready : out STD_LOGIC;
    sd_error : in STD_LOGIC;
    sd_valid : in STD_LOGIC;
    sd_din : in STD_LOGIC_VECTOR ( 7 downto 0 );
    sd_block_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    wa_addr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    wa_valid : out STD_LOGIC;
    wa_ready : in STD_LOGIC;
    wd_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    wd_valid : out STD_LOGIC;
    wd_ready : in STD_LOGIC;
    wr_resp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    wr_ready : out STD_LOGIC;
    wr_valid : in STD_LOGIC;
    done_flag : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of sd_readout : entity is true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of sd_readout : entity is "5ba097ee";
end sd_readout;

architecture STRUCTURE of sd_readout is
  signal \addr[0]_i_1_n_0\ : STD_LOGIC;
  signal \addr[0]_i_3_n_0\ : STD_LOGIC;
  signal \addr_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \addr_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \addr_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \addr_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \addr_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \addr_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \addr_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \addr_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \addr_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \addr_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \addr_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \addr_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \addr_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \addr_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \addr_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \addr_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \addr_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \addr_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \addr_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \addr_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \addr_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \addr_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \addr_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \addr_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \addr_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \addr_reg[28]_i_1_n_4\ : STD_LOGIC;
  signal \addr_reg[28]_i_1_n_5\ : STD_LOGIC;
  signal \addr_reg[28]_i_1_n_6\ : STD_LOGIC;
  signal \addr_reg[28]_i_1_n_7\ : STD_LOGIC;
  signal \addr_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \addr_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \addr_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \addr_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \addr_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \addr_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \addr_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \addr_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \addr_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \addr_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal clk_IBUF : STD_LOGIC;
  signal clk_IBUF_BUFG : STD_LOGIC;
  signal done_flag_OBUF : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 31 downto 7 );
  signal rst_IBUF : STD_LOGIC;
  signal sd_din_IBUF : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal sd_rd_multiple_OBUF : STD_LOGIC;
  signal sd_ready_OBUF : STD_LOGIC;
  signal sd_valid_IBUF : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \state[0]_i_1_n_0\ : STD_LOGIC;
  signal \state[0]_i_2_n_0\ : STD_LOGIC;
  signal \state[1]_i_1_n_0\ : STD_LOGIC;
  signal \state[1]_i_2_n_0\ : STD_LOGIC;
  signal \state[1]_i_3_n_0\ : STD_LOGIC;
  signal \state[1]_i_4_n_0\ : STD_LOGIC;
  signal \state[2]_i_10_n_0\ : STD_LOGIC;
  signal \state[2]_i_11_n_0\ : STD_LOGIC;
  signal \state[2]_i_12_n_0\ : STD_LOGIC;
  signal \state[2]_i_13_n_0\ : STD_LOGIC;
  signal \state[2]_i_1_n_0\ : STD_LOGIC;
  signal \state[2]_i_2_n_0\ : STD_LOGIC;
  signal \state[2]_i_3_n_0\ : STD_LOGIC;
  signal \state[2]_i_4_n_0\ : STD_LOGIC;
  signal \state[2]_i_5_n_0\ : STD_LOGIC;
  signal \state[2]_i_6_n_0\ : STD_LOGIC;
  signal \state[2]_i_7_n_0\ : STD_LOGIC;
  signal \state[2]_i_8_n_0\ : STD_LOGIC;
  signal \state[2]_i_9_n_0\ : STD_LOGIC;
  signal wa_addr_OBUF : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal wa_ready_IBUF : STD_LOGIC;
  signal wa_valid_OBUF : STD_LOGIC;
  signal wd_data_OBUF : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal wd_ready_IBUF : STD_LOGIC;
  signal wd_valid_OBUF : STD_LOGIC;
  signal word_index : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \word_index[0]_i_1_n_0\ : STD_LOGIC;
  signal \word_index[1]_i_1_n_0\ : STD_LOGIC;
  signal wr_ready_OBUF : STD_LOGIC;
  signal wr_valid_IBUF : STD_LOGIC;
  signal \NLW_addr_reg[0]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_addr_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_addr_reg[16]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_addr_reg[20]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_addr_reg[24]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_addr_reg[28]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_addr_reg[4]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_addr_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute OPT_MODIFIED : string;
  attribute OPT_MODIFIED of \addr_reg[0]_i_2\ : label is "SWEEP";
  attribute OPT_MODIFIED of \addr_reg[12]_i_1\ : label is "SWEEP";
  attribute OPT_MODIFIED of \addr_reg[16]_i_1\ : label is "SWEEP";
  attribute OPT_MODIFIED of \addr_reg[20]_i_1\ : label is "SWEEP";
  attribute OPT_MODIFIED of \addr_reg[24]_i_1\ : label is "SWEEP";
  attribute OPT_MODIFIED of \addr_reg[28]_i_1\ : label is "SWEEP";
  attribute OPT_MODIFIED of \addr_reg[4]_i_1\ : label is "SWEEP";
  attribute OPT_MODIFIED of \addr_reg[8]_i_1\ : label is "SWEEP";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of done_flag_OBUF_inst_i_1 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of sd_rd_multiple_OBUF_inst_i_1 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of sd_ready_OBUF_inst_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \state[1]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \state[2]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \state[2]_i_5\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of wa_valid_OBUF_inst_i_1 : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of wd_valid_OBUF_inst_i_1 : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \word_index[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of wr_ready_OBUF_inst_i_1 : label is "soft_lutpair2";
begin
\addr[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => state(0),
      I1 => wd_ready_IBUF,
      I2 => state(1),
      I3 => state(2),
      O => \addr[0]_i_1_n_0\
    );
\addr[0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => wa_addr_OBUF(0),
      O => \addr[0]_i_3_n_0\
    );
\addr_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[0]_i_2_n_7\,
      Q => wa_addr_OBUF(0),
      R => rst_IBUF
    );
\addr_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \addr_reg[0]_i_2_n_0\,
      CO(2 downto 0) => \NLW_addr_reg[0]_i_2_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \addr_reg[0]_i_2_n_4\,
      O(2) => \addr_reg[0]_i_2_n_5\,
      O(1) => \addr_reg[0]_i_2_n_6\,
      O(0) => \addr_reg[0]_i_2_n_7\,
      S(3 downto 1) => wa_addr_OBUF(3 downto 1),
      S(0) => \addr[0]_i_3_n_0\
    );
\addr_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[8]_i_1_n_5\,
      Q => wa_addr_OBUF(10),
      R => rst_IBUF
    );
\addr_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[8]_i_1_n_4\,
      Q => wa_addr_OBUF(11),
      R => rst_IBUF
    );
\addr_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[12]_i_1_n_7\,
      Q => wa_addr_OBUF(12),
      R => rst_IBUF
    );
\addr_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_reg[8]_i_1_n_0\,
      CO(3) => \addr_reg[12]_i_1_n_0\,
      CO(2 downto 0) => \NLW_addr_reg[12]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \addr_reg[12]_i_1_n_4\,
      O(2) => \addr_reg[12]_i_1_n_5\,
      O(1) => \addr_reg[12]_i_1_n_6\,
      O(0) => \addr_reg[12]_i_1_n_7\,
      S(3 downto 0) => wa_addr_OBUF(15 downto 12)
    );
\addr_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[12]_i_1_n_6\,
      Q => wa_addr_OBUF(13),
      R => rst_IBUF
    );
\addr_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[12]_i_1_n_5\,
      Q => wa_addr_OBUF(14),
      R => rst_IBUF
    );
\addr_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[12]_i_1_n_4\,
      Q => wa_addr_OBUF(15),
      R => rst_IBUF
    );
\addr_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[16]_i_1_n_7\,
      Q => wa_addr_OBUF(16),
      R => rst_IBUF
    );
\addr_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_reg[12]_i_1_n_0\,
      CO(3) => \addr_reg[16]_i_1_n_0\,
      CO(2 downto 0) => \NLW_addr_reg[16]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \addr_reg[16]_i_1_n_4\,
      O(2) => \addr_reg[16]_i_1_n_5\,
      O(1) => \addr_reg[16]_i_1_n_6\,
      O(0) => \addr_reg[16]_i_1_n_7\,
      S(3 downto 0) => wa_addr_OBUF(19 downto 16)
    );
\addr_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[16]_i_1_n_6\,
      Q => wa_addr_OBUF(17),
      R => rst_IBUF
    );
\addr_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[16]_i_1_n_5\,
      Q => wa_addr_OBUF(18),
      R => rst_IBUF
    );
\addr_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[16]_i_1_n_4\,
      Q => wa_addr_OBUF(19),
      R => rst_IBUF
    );
\addr_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[0]_i_2_n_6\,
      Q => wa_addr_OBUF(1),
      R => rst_IBUF
    );
\addr_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[20]_i_1_n_7\,
      Q => wa_addr_OBUF(20),
      R => rst_IBUF
    );
\addr_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_reg[16]_i_1_n_0\,
      CO(3) => \addr_reg[20]_i_1_n_0\,
      CO(2 downto 0) => \NLW_addr_reg[20]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \addr_reg[20]_i_1_n_4\,
      O(2) => \addr_reg[20]_i_1_n_5\,
      O(1) => \addr_reg[20]_i_1_n_6\,
      O(0) => \addr_reg[20]_i_1_n_7\,
      S(3 downto 0) => wa_addr_OBUF(23 downto 20)
    );
\addr_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[20]_i_1_n_6\,
      Q => wa_addr_OBUF(21),
      R => rst_IBUF
    );
\addr_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[20]_i_1_n_5\,
      Q => wa_addr_OBUF(22),
      R => rst_IBUF
    );
\addr_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[20]_i_1_n_4\,
      Q => wa_addr_OBUF(23),
      R => rst_IBUF
    );
\addr_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[24]_i_1_n_7\,
      Q => wa_addr_OBUF(24),
      R => rst_IBUF
    );
\addr_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_reg[20]_i_1_n_0\,
      CO(3) => \addr_reg[24]_i_1_n_0\,
      CO(2 downto 0) => \NLW_addr_reg[24]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \addr_reg[24]_i_1_n_4\,
      O(2) => \addr_reg[24]_i_1_n_5\,
      O(1) => \addr_reg[24]_i_1_n_6\,
      O(0) => \addr_reg[24]_i_1_n_7\,
      S(3 downto 0) => wa_addr_OBUF(27 downto 24)
    );
\addr_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[24]_i_1_n_6\,
      Q => wa_addr_OBUF(25),
      R => rst_IBUF
    );
\addr_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[24]_i_1_n_5\,
      Q => wa_addr_OBUF(26),
      R => rst_IBUF
    );
\addr_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[24]_i_1_n_4\,
      Q => wa_addr_OBUF(27),
      R => rst_IBUF
    );
\addr_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[28]_i_1_n_7\,
      Q => wa_addr_OBUF(28),
      R => rst_IBUF
    );
\addr_reg[28]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_reg[24]_i_1_n_0\,
      CO(3 downto 0) => \NLW_addr_reg[28]_i_1_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \addr_reg[28]_i_1_n_4\,
      O(2) => \addr_reg[28]_i_1_n_5\,
      O(1) => \addr_reg[28]_i_1_n_6\,
      O(0) => \addr_reg[28]_i_1_n_7\,
      S(3 downto 0) => wa_addr_OBUF(31 downto 28)
    );
\addr_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[28]_i_1_n_6\,
      Q => wa_addr_OBUF(29),
      R => rst_IBUF
    );
\addr_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[0]_i_2_n_5\,
      Q => wa_addr_OBUF(2),
      R => rst_IBUF
    );
\addr_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[28]_i_1_n_5\,
      Q => wa_addr_OBUF(30),
      R => rst_IBUF
    );
\addr_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[28]_i_1_n_4\,
      Q => wa_addr_OBUF(31),
      R => rst_IBUF
    );
\addr_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[0]_i_2_n_4\,
      Q => wa_addr_OBUF(3),
      R => rst_IBUF
    );
\addr_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[4]_i_1_n_7\,
      Q => wa_addr_OBUF(4),
      R => rst_IBUF
    );
\addr_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_reg[0]_i_2_n_0\,
      CO(3) => \addr_reg[4]_i_1_n_0\,
      CO(2 downto 0) => \NLW_addr_reg[4]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \addr_reg[4]_i_1_n_4\,
      O(2) => \addr_reg[4]_i_1_n_5\,
      O(1) => \addr_reg[4]_i_1_n_6\,
      O(0) => \addr_reg[4]_i_1_n_7\,
      S(3 downto 0) => wa_addr_OBUF(7 downto 4)
    );
\addr_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[4]_i_1_n_6\,
      Q => wa_addr_OBUF(5),
      R => rst_IBUF
    );
\addr_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[4]_i_1_n_5\,
      Q => wa_addr_OBUF(6),
      R => rst_IBUF
    );
\addr_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[4]_i_1_n_4\,
      Q => wa_addr_OBUF(7),
      R => rst_IBUF
    );
\addr_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[8]_i_1_n_7\,
      Q => wa_addr_OBUF(8),
      R => rst_IBUF
    );
\addr_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addr_reg[4]_i_1_n_0\,
      CO(3) => \addr_reg[8]_i_1_n_0\,
      CO(2 downto 0) => \NLW_addr_reg[8]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \addr_reg[8]_i_1_n_4\,
      O(2) => \addr_reg[8]_i_1_n_5\,
      O(1) => \addr_reg[8]_i_1_n_6\,
      O(0) => \addr_reg[8]_i_1_n_7\,
      S(3 downto 0) => wa_addr_OBUF(11 downto 8)
    );
\addr_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => \addr[0]_i_1_n_0\,
      D => \addr_reg[8]_i_1_n_6\,
      Q => wa_addr_OBUF(9),
      R => rst_IBUF
    );
clk_IBUF_BUFG_inst: unisim.vcomponents.BUFG
     port map (
      I => clk_IBUF,
      O => clk_IBUF_BUFG
    );
clk_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => clk,
      O => clk_IBUF
    );
done_flag_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => done_flag_OBUF,
      O => done_flag
    );
done_flag_OBUF_inst_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => state(2),
      I1 => state(1),
      I2 => state(0),
      O => done_flag_OBUF
    );
rst_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => rst,
      O => rst_IBUF
    );
\sd_block_addr_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(0)
    );
\sd_block_addr_OBUF[10]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(10)
    );
\sd_block_addr_OBUF[11]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(11)
    );
\sd_block_addr_OBUF[12]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(12)
    );
\sd_block_addr_OBUF[13]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(13)
    );
\sd_block_addr_OBUF[14]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(14)
    );
\sd_block_addr_OBUF[15]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(15)
    );
\sd_block_addr_OBUF[16]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(16)
    );
\sd_block_addr_OBUF[17]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(17)
    );
\sd_block_addr_OBUF[18]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(18)
    );
\sd_block_addr_OBUF[19]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(19)
    );
\sd_block_addr_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(1)
    );
\sd_block_addr_OBUF[20]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(20)
    );
\sd_block_addr_OBUF[21]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(21)
    );
\sd_block_addr_OBUF[22]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(22)
    );
\sd_block_addr_OBUF[23]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(23)
    );
\sd_block_addr_OBUF[24]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(24)
    );
\sd_block_addr_OBUF[25]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(25)
    );
\sd_block_addr_OBUF[26]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(26)
    );
\sd_block_addr_OBUF[27]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(27)
    );
\sd_block_addr_OBUF[28]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(28)
    );
\sd_block_addr_OBUF[29]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(29)
    );
\sd_block_addr_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(2)
    );
\sd_block_addr_OBUF[30]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(30)
    );
\sd_block_addr_OBUF[31]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(31)
    );
\sd_block_addr_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(3)
    );
\sd_block_addr_OBUF[4]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(4)
    );
\sd_block_addr_OBUF[5]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(5)
    );
\sd_block_addr_OBUF[6]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(6)
    );
\sd_block_addr_OBUF[7]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(7)
    );
\sd_block_addr_OBUF[8]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(8)
    );
\sd_block_addr_OBUF[9]_inst\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => sd_block_addr(9)
    );
\sd_din_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sd_din(0),
      O => sd_din_IBUF(0)
    );
\sd_din_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sd_din(1),
      O => sd_din_IBUF(1)
    );
\sd_din_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sd_din(2),
      O => sd_din_IBUF(2)
    );
\sd_din_IBUF[3]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sd_din(3),
      O => sd_din_IBUF(3)
    );
\sd_din_IBUF[4]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sd_din(4),
      O => sd_din_IBUF(4)
    );
\sd_din_IBUF[5]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sd_din(5),
      O => sd_din_IBUF(5)
    );
\sd_din_IBUF[6]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sd_din(6),
      O => sd_din_IBUF(6)
    );
\sd_din_IBUF[7]_inst\: unisim.vcomponents.IBUF
     port map (
      I => sd_din(7),
      O => sd_din_IBUF(7)
    );
sd_rd_multiple_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => sd_rd_multiple_OBUF,
      O => sd_rd_multiple
    );
sd_rd_multiple_OBUF_inst_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BE"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      I2 => state(2),
      O => sd_rd_multiple_OBUF
    );
sd_ready_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => sd_ready_OBUF,
      O => sd_ready
    );
sd_ready_OBUF_inst_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => state(2),
      I1 => state(1),
      I2 => state(0),
      O => sd_ready_OBUF
    );
sd_valid_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => sd_valid,
      O => sd_valid_IBUF
    );
\state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFFFFD00"
    )
        port map (
      I0 => wr_valid_IBUF,
      I1 => \state[2]_i_3_n_0\,
      I2 => \state[2]_i_4_n_0\,
      I3 => wr_ready_OBUF,
      I4 => \state[0]_i_2_n_0\,
      I5 => rst_IBUF,
      O => \state[0]_i_1_n_0\
    );
\state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0707330307073F0F"
    )
        port map (
      I0 => wa_ready_IBUF,
      I1 => state(0),
      I2 => state(2),
      I3 => wd_ready_IBUF,
      I4 => state(1),
      I5 => sd_valid_IBUF,
      O => \state[0]_i_2_n_0\
    );
\state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFFF0008"
    )
        port map (
      I0 => \state[1]_i_2_n_0\,
      I1 => wr_valid_IBUF,
      I2 => \state[2]_i_3_n_0\,
      I3 => \state[2]_i_4_n_0\,
      I4 => \state[1]_i_3_n_0\,
      I5 => rst_IBUF,
      O => \state[1]_i_1_n_0\
    );
\state[1]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => state(0),
      I1 => state(2),
      O => \state[1]_i_2_n_0\
    );
\state[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C3CFC8C8C0CCC8C8"
    )
        port map (
      I0 => \state[1]_i_4_n_0\,
      I1 => state(1),
      I2 => state(2),
      I3 => wa_ready_IBUF,
      I4 => state(0),
      I5 => sd_valid_IBUF,
      O => \state[1]_i_3_n_0\
    );
\state[1]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => word_index(0),
      I1 => word_index(1),
      O => \state[1]_i_4_n_0\
    );
\state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFAAABAA"
    )
        port map (
      I0 => \state[2]_i_2_n_0\,
      I1 => \state[2]_i_3_n_0\,
      I2 => \state[2]_i_4_n_0\,
      I3 => state(2),
      I4 => \state[2]_i_5_n_0\,
      I5 => rst_IBUF,
      O => \state[2]_i_1_n_0\
    );
\state[2]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wa_addr_OBUF(21),
      I1 => wa_addr_OBUF(20),
      I2 => wa_addr_OBUF(23),
      I3 => wa_addr_OBUF(22),
      O => \state[2]_i_10_n_0\
    );
\state[2]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wa_addr_OBUF(17),
      I1 => wa_addr_OBUF(16),
      I2 => wa_addr_OBUF(19),
      I3 => wa_addr_OBUF(18),
      O => \state[2]_i_11_n_0\
    );
\state[2]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wa_addr_OBUF(29),
      I1 => wa_addr_OBUF(28),
      I2 => wa_addr_OBUF(31),
      I3 => wa_addr_OBUF(30),
      O => \state[2]_i_12_n_0\
    );
\state[2]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wa_addr_OBUF(25),
      I1 => wa_addr_OBUF(24),
      I2 => wa_addr_OBUF(27),
      I3 => wa_addr_OBUF(26),
      O => \state[2]_i_13_n_0\
    );
\state[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4444444"
    )
        port map (
      I0 => wr_valid_IBUF,
      I1 => state(2),
      I2 => state(0),
      I3 => state(1),
      I4 => wa_ready_IBUF,
      O => \state[2]_i_2_n_0\
    );
\state[2]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \state[2]_i_6_n_0\,
      I1 => \state[2]_i_7_n_0\,
      I2 => \state[2]_i_8_n_0\,
      I3 => \state[2]_i_9_n_0\,
      O => \state[2]_i_3_n_0\
    );
\state[2]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \state[2]_i_10_n_0\,
      I1 => \state[2]_i_11_n_0\,
      I2 => \state[2]_i_12_n_0\,
      I3 => \state[2]_i_13_n_0\,
      O => \state[2]_i_4_n_0\
    );
\state[2]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => state(1),
      I1 => state(0),
      O => \state[2]_i_5_n_0\
    );
\state[2]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFD"
    )
        port map (
      I0 => wa_addr_OBUF(4),
      I1 => wa_addr_OBUF(5),
      I2 => wa_addr_OBUF(7),
      I3 => wa_addr_OBUF(6),
      O => \state[2]_i_6_n_0\
    );
\state[2]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wa_addr_OBUF(1),
      I1 => wa_addr_OBUF(0),
      I2 => wa_addr_OBUF(3),
      I3 => wa_addr_OBUF(2),
      O => \state[2]_i_7_n_0\
    );
\state[2]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wa_addr_OBUF(13),
      I1 => wa_addr_OBUF(12),
      I2 => wa_addr_OBUF(15),
      I3 => wa_addr_OBUF(14),
      O => \state[2]_i_8_n_0\
    );
\state[2]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => wa_addr_OBUF(9),
      I1 => wa_addr_OBUF(8),
      I2 => wa_addr_OBUF(11),
      I3 => wa_addr_OBUF(10),
      O => \state[2]_i_9_n_0\
    );
\state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => \state[0]_i_1_n_0\,
      Q => state(0),
      R => '0'
    );
\state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => \state[1]_i_1_n_0\,
      Q => state(1),
      R => '0'
    );
\state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => \state[2]_i_1_n_0\,
      Q => state(2),
      R => '0'
    );
\wa_addr_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(0),
      O => wa_addr(0)
    );
\wa_addr_OBUF[10]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(10),
      O => wa_addr(10)
    );
\wa_addr_OBUF[11]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(11),
      O => wa_addr(11)
    );
\wa_addr_OBUF[12]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(12),
      O => wa_addr(12)
    );
\wa_addr_OBUF[13]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(13),
      O => wa_addr(13)
    );
\wa_addr_OBUF[14]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(14),
      O => wa_addr(14)
    );
\wa_addr_OBUF[15]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(15),
      O => wa_addr(15)
    );
\wa_addr_OBUF[16]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(16),
      O => wa_addr(16)
    );
\wa_addr_OBUF[17]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(17),
      O => wa_addr(17)
    );
\wa_addr_OBUF[18]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(18),
      O => wa_addr(18)
    );
\wa_addr_OBUF[19]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(19),
      O => wa_addr(19)
    );
\wa_addr_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(1),
      O => wa_addr(1)
    );
\wa_addr_OBUF[20]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(20),
      O => wa_addr(20)
    );
\wa_addr_OBUF[21]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(21),
      O => wa_addr(21)
    );
\wa_addr_OBUF[22]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(22),
      O => wa_addr(22)
    );
\wa_addr_OBUF[23]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(23),
      O => wa_addr(23)
    );
\wa_addr_OBUF[24]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(24),
      O => wa_addr(24)
    );
\wa_addr_OBUF[25]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(25),
      O => wa_addr(25)
    );
\wa_addr_OBUF[26]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(26),
      O => wa_addr(26)
    );
\wa_addr_OBUF[27]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(27),
      O => wa_addr(27)
    );
\wa_addr_OBUF[28]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(28),
      O => wa_addr(28)
    );
\wa_addr_OBUF[29]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(29),
      O => wa_addr(29)
    );
\wa_addr_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(2),
      O => wa_addr(2)
    );
\wa_addr_OBUF[30]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(30),
      O => wa_addr(30)
    );
\wa_addr_OBUF[31]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(31),
      O => wa_addr(31)
    );
\wa_addr_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(3),
      O => wa_addr(3)
    );
\wa_addr_OBUF[4]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(4),
      O => wa_addr(4)
    );
\wa_addr_OBUF[5]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(5),
      O => wa_addr(5)
    );
\wa_addr_OBUF[6]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(6),
      O => wa_addr(6)
    );
\wa_addr_OBUF[7]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(7),
      O => wa_addr(7)
    );
\wa_addr_OBUF[8]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(8),
      O => wa_addr(8)
    );
\wa_addr_OBUF[9]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wa_addr_OBUF(9),
      O => wa_addr(9)
    );
wa_ready_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => wa_ready,
      O => wa_ready_IBUF
    );
wa_valid_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => wa_valid_OBUF,
      O => wa_valid
    );
wa_valid_OBUF_inst_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => state(2),
      I1 => state(1),
      I2 => state(0),
      O => wa_valid_OBUF
    );
\wd_data_OBUF[0]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(0),
      O => wd_data(0)
    );
\wd_data_OBUF[10]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(10),
      O => wd_data(10)
    );
\wd_data_OBUF[11]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(11),
      O => wd_data(11)
    );
\wd_data_OBUF[12]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(12),
      O => wd_data(12)
    );
\wd_data_OBUF[13]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(13),
      O => wd_data(13)
    );
\wd_data_OBUF[14]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(14),
      O => wd_data(14)
    );
\wd_data_OBUF[15]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(15),
      O => wd_data(15)
    );
\wd_data_OBUF[16]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(16),
      O => wd_data(16)
    );
\wd_data_OBUF[17]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(17),
      O => wd_data(17)
    );
\wd_data_OBUF[18]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(18),
      O => wd_data(18)
    );
\wd_data_OBUF[19]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(19),
      O => wd_data(19)
    );
\wd_data_OBUF[1]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(1),
      O => wd_data(1)
    );
\wd_data_OBUF[20]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(20),
      O => wd_data(20)
    );
\wd_data_OBUF[21]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(21),
      O => wd_data(21)
    );
\wd_data_OBUF[22]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(22),
      O => wd_data(22)
    );
\wd_data_OBUF[23]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(23),
      O => wd_data(23)
    );
\wd_data_OBUF[24]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(24),
      O => wd_data(24)
    );
\wd_data_OBUF[25]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(25),
      O => wd_data(25)
    );
\wd_data_OBUF[26]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(26),
      O => wd_data(26)
    );
\wd_data_OBUF[27]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(27),
      O => wd_data(27)
    );
\wd_data_OBUF[28]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(28),
      O => wd_data(28)
    );
\wd_data_OBUF[29]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(29),
      O => wd_data(29)
    );
\wd_data_OBUF[2]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(2),
      O => wd_data(2)
    );
\wd_data_OBUF[30]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(30),
      O => wd_data(30)
    );
\wd_data_OBUF[31]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(31),
      O => wd_data(31)
    );
\wd_data_OBUF[3]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(3),
      O => wd_data(3)
    );
\wd_data_OBUF[4]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(4),
      O => wd_data(4)
    );
\wd_data_OBUF[5]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(5),
      O => wd_data(5)
    );
\wd_data_OBUF[6]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(6),
      O => wd_data(6)
    );
\wd_data_OBUF[7]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(7),
      O => wd_data(7)
    );
\wd_data_OBUF[8]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(8),
      O => wd_data(8)
    );
\wd_data_OBUF[9]_inst\: unisim.vcomponents.OBUF
     port map (
      I => wd_data_OBUF(9),
      O => wd_data(9)
    );
wd_ready_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => wd_ready,
      O => wd_ready_IBUF
    );
wd_valid_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => wd_valid_OBUF,
      O => wd_valid
    );
wd_valid_OBUF_inst_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => state(1),
      I1 => state(2),
      I2 => state(0),
      O => wd_valid_OBUF
    );
\word[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00040000"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      I2 => state(2),
      I3 => word_index(1),
      I4 => word_index(0),
      O => p_0_in(15)
    );
\word[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00040000"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      I2 => state(2),
      I3 => word_index(0),
      I4 => word_index(1),
      O => p_0_in(23)
    );
\word[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04000000"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      I2 => state(2),
      I3 => word_index(1),
      I4 => word_index(0),
      O => p_0_in(31)
    );
\word[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000004"
    )
        port map (
      I0 => state(0),
      I1 => state(1),
      I2 => state(2),
      I3 => word_index(1),
      I4 => word_index(0),
      O => p_0_in(7)
    );
\word_index[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20222122"
    )
        port map (
      I0 => word_index(0),
      I1 => rst_IBUF,
      I2 => state(2),
      I3 => state(1),
      I4 => state(0),
      O => \word_index[0]_i_1_n_0\
    );
\word_index[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0A000A0A0A060A0A"
    )
        port map (
      I0 => word_index(1),
      I1 => word_index(0),
      I2 => rst_IBUF,
      I3 => state(2),
      I4 => state(1),
      I5 => state(0),
      O => \word_index[1]_i_1_n_0\
    );
\word_index_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => \word_index[0]_i_1_n_0\,
      Q => word_index(0),
      R => '0'
    );
\word_index_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => \word_index[1]_i_1_n_0\,
      Q => word_index(1),
      R => '0'
    );
\word_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(7),
      D => sd_din_IBUF(0),
      Q => wd_data_OBUF(0),
      R => rst_IBUF
    );
\word_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(15),
      D => sd_din_IBUF(2),
      Q => wd_data_OBUF(10),
      R => rst_IBUF
    );
\word_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(15),
      D => sd_din_IBUF(3),
      Q => wd_data_OBUF(11),
      R => rst_IBUF
    );
\word_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(15),
      D => sd_din_IBUF(4),
      Q => wd_data_OBUF(12),
      R => rst_IBUF
    );
\word_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(15),
      D => sd_din_IBUF(5),
      Q => wd_data_OBUF(13),
      R => rst_IBUF
    );
\word_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(15),
      D => sd_din_IBUF(6),
      Q => wd_data_OBUF(14),
      R => rst_IBUF
    );
\word_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(15),
      D => sd_din_IBUF(7),
      Q => wd_data_OBUF(15),
      R => rst_IBUF
    );
\word_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(23),
      D => sd_din_IBUF(0),
      Q => wd_data_OBUF(16),
      R => rst_IBUF
    );
\word_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(23),
      D => sd_din_IBUF(1),
      Q => wd_data_OBUF(17),
      R => rst_IBUF
    );
\word_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(23),
      D => sd_din_IBUF(2),
      Q => wd_data_OBUF(18),
      R => rst_IBUF
    );
\word_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(23),
      D => sd_din_IBUF(3),
      Q => wd_data_OBUF(19),
      R => rst_IBUF
    );
\word_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(7),
      D => sd_din_IBUF(1),
      Q => wd_data_OBUF(1),
      R => rst_IBUF
    );
\word_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(23),
      D => sd_din_IBUF(4),
      Q => wd_data_OBUF(20),
      R => rst_IBUF
    );
\word_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(23),
      D => sd_din_IBUF(5),
      Q => wd_data_OBUF(21),
      R => rst_IBUF
    );
\word_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(23),
      D => sd_din_IBUF(6),
      Q => wd_data_OBUF(22),
      R => rst_IBUF
    );
\word_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(23),
      D => sd_din_IBUF(7),
      Q => wd_data_OBUF(23),
      R => rst_IBUF
    );
\word_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(31),
      D => sd_din_IBUF(0),
      Q => wd_data_OBUF(24),
      R => rst_IBUF
    );
\word_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(31),
      D => sd_din_IBUF(1),
      Q => wd_data_OBUF(25),
      R => rst_IBUF
    );
\word_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(31),
      D => sd_din_IBUF(2),
      Q => wd_data_OBUF(26),
      R => rst_IBUF
    );
\word_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(31),
      D => sd_din_IBUF(3),
      Q => wd_data_OBUF(27),
      R => rst_IBUF
    );
\word_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(31),
      D => sd_din_IBUF(4),
      Q => wd_data_OBUF(28),
      R => rst_IBUF
    );
\word_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(31),
      D => sd_din_IBUF(5),
      Q => wd_data_OBUF(29),
      R => rst_IBUF
    );
\word_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(7),
      D => sd_din_IBUF(2),
      Q => wd_data_OBUF(2),
      R => rst_IBUF
    );
\word_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(31),
      D => sd_din_IBUF(6),
      Q => wd_data_OBUF(30),
      R => rst_IBUF
    );
\word_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(31),
      D => sd_din_IBUF(7),
      Q => wd_data_OBUF(31),
      R => rst_IBUF
    );
\word_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(7),
      D => sd_din_IBUF(3),
      Q => wd_data_OBUF(3),
      R => rst_IBUF
    );
\word_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(7),
      D => sd_din_IBUF(4),
      Q => wd_data_OBUF(4),
      R => rst_IBUF
    );
\word_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(7),
      D => sd_din_IBUF(5),
      Q => wd_data_OBUF(5),
      R => rst_IBUF
    );
\word_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(7),
      D => sd_din_IBUF(6),
      Q => wd_data_OBUF(6),
      R => rst_IBUF
    );
\word_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(7),
      D => sd_din_IBUF(7),
      Q => wd_data_OBUF(7),
      R => rst_IBUF
    );
\word_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(15),
      D => sd_din_IBUF(0),
      Q => wd_data_OBUF(8),
      R => rst_IBUF
    );
\word_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => p_0_in(15),
      D => sd_din_IBUF(1),
      Q => wd_data_OBUF(9),
      R => rst_IBUF
    );
wr_ready_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => wr_ready_OBUF,
      O => wr_ready
    );
wr_ready_OBUF_inst_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => state(2),
      I1 => state(0),
      I2 => state(1),
      O => wr_ready_OBUF
    );
wr_valid_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => wr_valid,
      O => wr_valid_IBUF
    );
end STRUCTURE;

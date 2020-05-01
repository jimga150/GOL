-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1.3 (win64) Build 2644227 Wed Sep  4 09:45:24 MDT 2019
-- Date        : Sun Jan 19 10:35:33 2020
-- Host        : DESKTOP-JKR6EMK running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file {C:/Users/Jim
--               Snedecor/Desktop/Code/C_Cpp/Reconfig/GOL_v2/GOL_v2.sim/sim_1/impl/func/xsim/gol_tb_func_impl.vhd}
-- Design      : GOL
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell is
  port (
    \GOL_outputs[0]_0\ : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[0]_5\ : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    p_9_in : in STD_LOGIC;
    p_5_in : in STD_LOGIC;
    p_3_in : in STD_LOGIC;
    p_4_in : in STD_LOGIC;
    p_10_in : in STD_LOGIC;
    p_11_in : in STD_LOGIC;
    \GOL_outputs[0]_4\ : in STD_LOGIC;
    \GOL_outputs[0]_1\ : in STD_LOGIC
  );
end GOL_cell;

architecture STRUCTURE of GOL_cell is
  signal \^gol_outputs[0]_0\ : STD_LOGIC;
  signal \val_i_2__6_n_0\ : STD_LOGIC;
  signal \val_i_3__4_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__4\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \val_i_4__5\ : label is "soft_lutpair0";
begin
  \GOL_outputs[0]_0\ <= \^gol_outputs[0]_0\;
\val_i_1__4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[0]_5\,
      I1 => \val_i_2__6_n_0\,
      I2 => \val_i_3__4_n_0\,
      I3 => val_reg_3,
      I4 => p_9_in,
      I5 => p_5_in,
      O => val_reg_0
    );
\val_i_2__6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[0]_0\,
      I1 => p_3_in,
      I2 => p_4_in,
      I3 => p_10_in,
      I4 => p_11_in,
      I5 => \GOL_outputs[0]_4\,
      O => \val_i_2__6_n_0\
    );
\val_i_3__4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_0\,
      I1 => p_4_in,
      I2 => p_3_in,
      O => \val_i_3__4_n_0\
    );
\val_i_4__5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_0\,
      I1 => p_4_in,
      I2 => \GOL_outputs[0]_1\,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[0]_0\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_0 is
  port (
    \GOL_outputs[0]_1\ : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[0]_0\ : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    p_10_in : in STD_LOGIC;
    p_0_in : in STD_LOGIC;
    p_4_in : in STD_LOGIC;
    p_5_in : in STD_LOGIC;
    p_11_in : in STD_LOGIC;
    p_6_in : in STD_LOGIC;
    \GOL_outputs[0]_5\ : in STD_LOGIC;
    \GOL_outputs[0]_2\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_0 : entity is "GOL_cell";
end GOL_cell_0;

architecture STRUCTURE of GOL_cell_0 is
  signal \^gol_outputs[0]_1\ : STD_LOGIC;
  signal \val_i_2__0_n_0\ : STD_LOGIC;
  signal val_i_3_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of val_i_3 : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \val_i_4__6\ : label is "soft_lutpair1";
begin
  \GOL_outputs[0]_1\ <= \^gol_outputs[0]_1\;
val_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[0]_0\,
      I1 => \val_i_2__0_n_0\,
      I2 => val_i_3_n_0,
      I3 => val_reg_3,
      I4 => p_10_in,
      I5 => p_0_in,
      O => val_reg_0
    );
\val_i_2__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[0]_1\,
      I1 => p_4_in,
      I2 => p_5_in,
      I3 => p_11_in,
      I4 => p_6_in,
      I5 => \GOL_outputs[0]_5\,
      O => \val_i_2__0_n_0\
    );
val_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_1\,
      I1 => p_5_in,
      I2 => p_4_in,
      O => val_i_3_n_0
    );
\val_i_4__6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_1\,
      I1 => p_5_in,
      I2 => \GOL_outputs[0]_2\,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[0]_1\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_1 is
  port (
    \GOL_outputs[0]_2\ : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[0]_1\ : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    p_11_in : in STD_LOGIC;
    p_1_in : in STD_LOGIC;
    p_5_in : in STD_LOGIC;
    p_0_in : in STD_LOGIC;
    p_6_in : in STD_LOGIC;
    p_7_in : in STD_LOGIC;
    \GOL_outputs[0]_0\ : in STD_LOGIC;
    \GOL_outputs[0]_3\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_1 : entity is "GOL_cell";
end GOL_cell_1;

architecture STRUCTURE of GOL_cell_1 is
  signal \^gol_outputs[0]_2\ : STD_LOGIC;
  signal \val_i_2__12_n_0\ : STD_LOGIC;
  signal \val_i_3__0_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \val_i_4__7\ : label is "soft_lutpair2";
begin
  \GOL_outputs[0]_2\ <= \^gol_outputs[0]_2\;
\val_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[0]_1\,
      I1 => \val_i_2__12_n_0\,
      I2 => \val_i_3__0_n_0\,
      I3 => val_reg_3,
      I4 => p_11_in,
      I5 => p_1_in,
      O => val_reg_0
    );
\val_i_2__12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[0]_2\,
      I1 => p_5_in,
      I2 => p_0_in,
      I3 => p_6_in,
      I4 => p_7_in,
      I5 => \GOL_outputs[0]_0\,
      O => \val_i_2__12_n_0\
    );
\val_i_3__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_2\,
      I1 => p_0_in,
      I2 => p_5_in,
      O => \val_i_3__0_n_0\
    );
\val_i_4__7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_2\,
      I1 => p_0_in,
      I2 => \GOL_outputs[0]_3\,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[0]_2\,
      S => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_10 is
  port (
    p_4_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_3_in : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[0]_3\ : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GOL_outputs[0]_4\ : in STD_LOGIC;
    \GOL_outputs[0]_5\ : in STD_LOGIC;
    p_2_in : in STD_LOGIC;
    p_5_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_10 : entity is "GOL_cell";
end GOL_cell_10;

architecture STRUCTURE of GOL_cell_10 is
  signal \^p_4_in\ : STD_LOGIC;
  signal \val_i_2__30_n_0\ : STD_LOGIC;
  signal \val_i_3__9_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__9\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \val_i_4__16\ : label is "soft_lutpair11";
begin
  p_4_in <= \^p_4_in\;
\val_i_1__9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_3_in,
      I1 => \val_i_2__30_n_0\,
      I2 => \val_i_3__9_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[0]_3\,
      I5 => \GOL_outputs[2]\(2),
      O => val_reg_0
    );
\val_i_2__30\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_4_in\,
      I1 => \GOL_outputs[2]\(0),
      I2 => \GOL_outputs[2]\(1),
      I3 => \GOL_outputs[0]_4\,
      I4 => \GOL_outputs[0]_5\,
      I5 => p_2_in,
      O => \val_i_2__30_n_0\
    );
\val_i_3__9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_4_in\,
      I1 => \GOL_outputs[2]\(1),
      I2 => \GOL_outputs[2]\(0),
      O => \val_i_3__9_n_0\
    );
\val_i_4__16\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_4_in\,
      I1 => \GOL_outputs[2]\(1),
      I2 => p_5_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_4_in\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_11 is
  port (
    \GOL_outputs[2]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    p_3_in : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_4_in : in STD_LOGIC;
    p_5_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_11 : entity is "GOL_cell";
end GOL_cell_11;

architecture STRUCTURE of GOL_cell_11 is
  signal \^gol_outputs[2]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \val_i_2__3_n_0\ : STD_LOGIC;
  signal \val_i_3__16_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__16\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \val_i_4__17\ : label is "soft_lutpair12";
begin
  \GOL_outputs[2]\(0) <= \^gol_outputs[2]\(0);
\val_i_1__16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => val_reg_3(2),
      I1 => \val_i_2__3_n_0\,
      I2 => \val_i_3__16_n_0\,
      I3 => val_reg_4,
      I4 => p_3_in,
      I5 => \GOL_outputs[3]\(0),
      O => val_reg_0
    );
\val_i_2__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[2]\(0),
      I1 => \GOL_outputs[3]\(1),
      I2 => \GOL_outputs[3]\(2),
      I3 => p_4_in,
      I4 => p_5_in,
      I5 => val_reg_3(1),
      O => \val_i_2__3_n_0\
    );
\val_i_3__16\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[2]\(0),
      I1 => \GOL_outputs[3]\(2),
      I2 => \GOL_outputs[3]\(1),
      O => \val_i_3__16_n_0\
    );
\val_i_4__17\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[2]\(0),
      I1 => \GOL_outputs[3]\(2),
      I2 => val_reg_3(0),
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[2]\(0),
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_12 is
  port (
    val_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    p_4_in : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_5_in : in STD_LOGIC;
    p_0_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_12 : entity is "GOL_cell";
end GOL_cell_12;

architecture STRUCTURE of GOL_cell_12 is
  signal \val_i_2__10_n_0\ : STD_LOGIC;
  signal \val_i_3__11_n_0\ : STD_LOGIC;
  signal \^val_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__11\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \val_i_4__18\ : label is "soft_lutpair13";
begin
  val_reg_0(0) <= \^val_reg_0\(0);
\val_i_1__11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[2]\(0),
      I1 => \val_i_2__10_n_0\,
      I2 => \val_i_3__11_n_0\,
      I3 => val_reg_4,
      I4 => p_4_in,
      I5 => \GOL_outputs[3]\(1),
      O => val_reg_1
    );
\val_i_2__10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[3]\(2),
      I2 => \GOL_outputs[3]\(0),
      I3 => p_5_in,
      I4 => p_0_in,
      I5 => \GOL_outputs[2]\(2),
      O => \val_i_2__10_n_0\
    );
\val_i_3__11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[3]\(0),
      I2 => \GOL_outputs[3]\(2),
      O => \val_i_3__11_n_0\
    );
\val_i_4__18\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[3]\(0),
      I2 => \GOL_outputs[2]\(1),
      O => val_reg_2
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^val_reg_0\(0),
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_13 is
  port (
    \GOL_outputs[2]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    p_5_in : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_0_in : in STD_LOGIC;
    p_1_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_13 : entity is "GOL_cell";
end GOL_cell_13;

architecture STRUCTURE of GOL_cell_13 is
  signal \^gol_outputs[2]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \val_i_2__9_n_0\ : STD_LOGIC;
  signal \val_i_3__12_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__12\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \val_i_4__19\ : label is "soft_lutpair14";
begin
  \GOL_outputs[2]\(0) <= \^gol_outputs[2]\(0);
\val_i_1__12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => val_reg_3(1),
      I1 => \val_i_2__9_n_0\,
      I2 => \val_i_3__12_n_0\,
      I3 => val_reg_4,
      I4 => p_5_in,
      I5 => \GOL_outputs[3]\(2),
      O => val_reg_0
    );
\val_i_2__9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[2]\(0),
      I1 => \GOL_outputs[3]\(0),
      I2 => \GOL_outputs[3]\(1),
      I3 => p_0_in,
      I4 => p_1_in,
      I5 => val_reg_3(0),
      O => \val_i_2__9_n_0\
    );
\val_i_3__12\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[2]\(0),
      I1 => \GOL_outputs[3]\(1),
      I2 => \GOL_outputs[3]\(0),
      O => \val_i_3__12_n_0\
    );
\val_i_4__19\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[2]\(0),
      I1 => \GOL_outputs[3]\(1),
      I2 => val_reg_3(2),
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[2]\(0),
      S => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_14 is
  port (
    val_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    p_0_in : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_1_in : in STD_LOGIC;
    p_2_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_14 : entity is "GOL_cell";
end GOL_cell_14;

architecture STRUCTURE of GOL_cell_14 is
  signal \val_i_2__20_n_0\ : STD_LOGIC;
  signal \val_i_3__13_n_0\ : STD_LOGIC;
  signal \^val_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__13\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \val_i_4__20\ : label is "soft_lutpair15";
begin
  val_reg_0(0) <= \^val_reg_0\(0);
\val_i_1__13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[2]\(1),
      I1 => \val_i_2__20_n_0\,
      I2 => \val_i_3__13_n_0\,
      I3 => val_reg_4,
      I4 => p_0_in,
      I5 => \GOL_outputs[3]\(2),
      O => val_reg_1
    );
\val_i_2__20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[3]\(0),
      I2 => \GOL_outputs[3]\(1),
      I3 => p_1_in,
      I4 => p_2_in,
      I5 => \GOL_outputs[2]\(0),
      O => \val_i_2__20_n_0\
    );
\val_i_3__13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[3]\(1),
      I2 => \GOL_outputs[3]\(0),
      O => \val_i_3__13_n_0\
    );
\val_i_4__20\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[3]\(1),
      I2 => \GOL_outputs[2]\(2),
      O => val_reg_2
    );
val_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^val_reg_0\(0),
      S => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_15 is
  port (
    \GOL_outputs[2]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    p_1_in : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_2_in : in STD_LOGIC;
    p_3_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_15 : entity is "GOL_cell";
end GOL_cell_15;

architecture STRUCTURE of GOL_cell_15 is
  signal \^gol_outputs[2]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \val_i_2__26_n_0\ : STD_LOGIC;
  signal \val_i_3__14_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__14\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \val_i_4__21\ : label is "soft_lutpair16";
begin
  \GOL_outputs[2]\(0) <= \^gol_outputs[2]\(0);
\val_i_1__14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => val_reg_3(1),
      I1 => \val_i_2__26_n_0\,
      I2 => \val_i_3__14_n_0\,
      I3 => val_reg_4,
      I4 => p_1_in,
      I5 => \GOL_outputs[3]\(2),
      O => val_reg_0
    );
\val_i_2__26\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[2]\(0),
      I1 => \GOL_outputs[3]\(0),
      I2 => \GOL_outputs[3]\(1),
      I3 => p_2_in,
      I4 => p_3_in,
      I5 => val_reg_3(0),
      O => \val_i_2__26_n_0\
    );
\val_i_3__14\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[2]\(0),
      I1 => \GOL_outputs[3]\(1),
      I2 => \GOL_outputs[3]\(0),
      O => \val_i_3__14_n_0\
    );
\val_i_4__21\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[2]\(0),
      I1 => \GOL_outputs[3]\(1),
      I2 => val_reg_3(2),
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[2]\(0),
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_16 is
  port (
    val_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    p_2_in : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_3_in : in STD_LOGIC;
    p_4_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_16 : entity is "GOL_cell";
end GOL_cell_16;

architecture STRUCTURE of GOL_cell_16 is
  signal \val_i_2__32_n_0\ : STD_LOGIC;
  signal \val_i_3__15_n_0\ : STD_LOGIC;
  signal \^val_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__15\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \val_i_4__22\ : label is "soft_lutpair17";
begin
  val_reg_0(0) <= \^val_reg_0\(0);
\val_i_1__15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[2]\(2),
      I1 => \val_i_2__32_n_0\,
      I2 => \val_i_3__15_n_0\,
      I3 => val_reg_4,
      I4 => p_2_in,
      I5 => \GOL_outputs[3]\(2),
      O => val_reg_1
    );
\val_i_2__32\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[3]\(0),
      I2 => \GOL_outputs[3]\(1),
      I3 => p_3_in,
      I4 => p_4_in,
      I5 => \GOL_outputs[2]\(1),
      O => \val_i_2__32_n_0\
    );
\val_i_3__15\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[3]\(1),
      I2 => \GOL_outputs[3]\(0),
      O => \val_i_3__15_n_0\
    );
\val_i_4__22\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[3]\(1),
      I2 => \GOL_outputs[2]\(0),
      O => val_reg_2
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^val_reg_0\(0),
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_17 is
  port (
    \GOL_outputs[3]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_0 : out STD_LOGIC;
    \col[0]\ : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_5_out : in STD_LOGIC;
    p_1_out : in STD_LOGIC;
    p_0_out : in STD_LOGIC;
    col_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 );
    val_OBUF_inst_i_1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    row_IBUF : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_OBUF_inst_i_4_0 : in STD_LOGIC;
    p_5_in : in STD_LOGIC;
    \GOL_outputs[0]_0\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_17 : entity is "GOL_cell";
end GOL_cell_17;

architecture STRUCTURE of GOL_cell_17 is
  signal \^gol_outputs[3]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \GOL_outputs[5]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal val_OBUF_inst_i_19_n_0 : STD_LOGIC;
  signal \val_i_2__8_n_0\ : STD_LOGIC;
  signal \val_i_3__22_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__22\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \val_i_4__23\ : label is "soft_lutpair18";
begin
  \GOL_outputs[3]\(0) <= \^gol_outputs[3]\(0);
val_OBUF_inst_i_19: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => \GOL_outputs[2]\(0),
      I2 => row_IBUF(1),
      I3 => p_5_in,
      I4 => row_IBUF(0),
      I5 => \GOL_outputs[0]_0\,
      O => val_OBUF_inst_i_19_n_0
    );
val_OBUF_inst_i_4: unisim.vcomponents.MUXF8
     port map (
      I0 => \GOL_outputs[5]\(0),
      I1 => val_OBUF_inst_i_1(0),
      O => \col[0]\,
      S => col_IBUF(0)
    );
val_OBUF_inst_i_9: unisim.vcomponents.MUXF7
     port map (
      I0 => val_OBUF_inst_i_19_n_0,
      I1 => val_OBUF_inst_i_4_0,
      O => \GOL_outputs[5]\(0),
      S => row_IBUF(2)
    );
\val_i_1__22\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => val_reg_3(2),
      I1 => \val_i_2__8_n_0\,
      I2 => \val_i_3__22_n_0\,
      I3 => val_reg_4,
      I4 => \GOL_outputs[2]\(1),
      I5 => p_5_out,
      O => val_reg_0
    );
\val_i_2__8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => p_1_out,
      I2 => p_0_out,
      I3 => \GOL_outputs[2]\(2),
      I4 => \GOL_outputs[2]\(0),
      I5 => val_reg_3(1),
      O => \val_i_2__8_n_0\
    );
\val_i_3__22\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => p_0_out,
      I2 => p_1_out,
      O => \val_i_3__22_n_0\
    );
\val_i_4__23\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => p_0_out,
      I2 => val_reg_3(0),
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[3]\(0),
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_18 is
  port (
    val_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    \row[2]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_4_out : in STD_LOGIC;
    p_0_out : in STD_LOGIC;
    p_5_out : in STD_LOGIC;
    row_IBUF : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_OBUF_inst_i_4 : in STD_LOGIC;
    p_0_in : in STD_LOGIC;
    \GOL_outputs[0]_1\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_18 : entity is "GOL_cell";
end GOL_cell_18;

architecture STRUCTURE of GOL_cell_18 is
  signal val_OBUF_inst_i_21_n_0 : STD_LOGIC;
  signal \val_i_2__15_n_0\ : STD_LOGIC;
  signal \val_i_3__17_n_0\ : STD_LOGIC;
  signal \^val_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__17\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \val_i_4__24\ : label is "soft_lutpair19";
begin
  val_reg_0(0) <= \^val_reg_0\(0);
val_OBUF_inst_i_10: unisim.vcomponents.MUXF7
     port map (
      I0 => val_OBUF_inst_i_21_n_0,
      I1 => val_OBUF_inst_i_4,
      O => \row[2]\(0),
      S => row_IBUF(2)
    );
val_OBUF_inst_i_21: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[2]\(1),
      I2 => row_IBUF(1),
      I3 => p_0_in,
      I4 => row_IBUF(0),
      I5 => \GOL_outputs[0]_1\,
      O => val_OBUF_inst_i_21_n_0
    );
\val_i_1__17\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[3]\(0),
      I1 => \val_i_2__15_n_0\,
      I2 => \val_i_3__17_n_0\,
      I3 => val_reg_4,
      I4 => \GOL_outputs[2]\(2),
      I5 => p_4_out,
      O => val_reg_1
    );
\val_i_2__15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => p_0_out,
      I2 => p_5_out,
      I3 => \GOL_outputs[2]\(0),
      I4 => \GOL_outputs[2]\(1),
      I5 => \GOL_outputs[3]\(2),
      O => \val_i_2__15_n_0\
    );
\val_i_3__17\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => p_5_out,
      I2 => p_0_out,
      O => \val_i_3__17_n_0\
    );
\val_i_4__24\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => p_5_out,
      I2 => \GOL_outputs[3]\(1),
      O => val_reg_2
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^val_reg_0\(0),
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_19 is
  port (
    \GOL_outputs[3]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_0 : out STD_LOGIC;
    \col[0]\ : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_3_out : in STD_LOGIC;
    p_5_out : in STD_LOGIC;
    p_4_out : in STD_LOGIC;
    col_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 );
    val_OBUF_inst_i_1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    row_IBUF : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_OBUF_inst_i_3_0 : in STD_LOGIC;
    p_1_in : in STD_LOGIC;
    \GOL_outputs[0]_2\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_19 : entity is "GOL_cell";
end GOL_cell_19;

architecture STRUCTURE of GOL_cell_19 is
  signal \^gol_outputs[3]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \GOL_outputs[5]\ : STD_LOGIC_VECTOR ( 2 to 2 );
  signal val_OBUF_inst_i_15_n_0 : STD_LOGIC;
  signal \val_i_2__14_n_0\ : STD_LOGIC;
  signal \val_i_3__18_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__18\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \val_i_4__25\ : label is "soft_lutpair20";
begin
  \GOL_outputs[3]\(0) <= \^gol_outputs[3]\(0);
val_OBUF_inst_i_15: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => \GOL_outputs[2]\(2),
      I2 => row_IBUF(1),
      I3 => p_1_in,
      I4 => row_IBUF(0),
      I5 => \GOL_outputs[0]_2\,
      O => val_OBUF_inst_i_15_n_0
    );
val_OBUF_inst_i_3: unisim.vcomponents.MUXF8
     port map (
      I0 => \GOL_outputs[5]\(2),
      I1 => val_OBUF_inst_i_1(0),
      O => \col[0]\,
      S => col_IBUF(0)
    );
val_OBUF_inst_i_7: unisim.vcomponents.MUXF7
     port map (
      I0 => val_OBUF_inst_i_15_n_0,
      I1 => val_OBUF_inst_i_3_0,
      O => \GOL_outputs[5]\(2),
      S => row_IBUF(2)
    );
\val_i_1__18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => val_reg_3(1),
      I1 => \val_i_2__14_n_0\,
      I2 => \val_i_3__18_n_0\,
      I3 => val_reg_4,
      I4 => \GOL_outputs[2]\(0),
      I5 => p_3_out,
      O => val_reg_0
    );
\val_i_2__14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => p_5_out,
      I2 => p_4_out,
      I3 => \GOL_outputs[2]\(1),
      I4 => \GOL_outputs[2]\(2),
      I5 => val_reg_3(0),
      O => \val_i_2__14_n_0\
    );
\val_i_3__18\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => p_4_out,
      I2 => p_5_out,
      O => \val_i_3__18_n_0\
    );
\val_i_4__25\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => p_4_out,
      I2 => val_reg_3(2),
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[3]\(0),
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_2 is
  port (
    \GOL_outputs[0]_3\ : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[0]_2\ : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    p_6_in : in STD_LOGIC;
    p_2_in : in STD_LOGIC;
    p_0_in : in STD_LOGIC;
    p_1_in : in STD_LOGIC;
    p_7_in : in STD_LOGIC;
    p_8_in : in STD_LOGIC;
    \GOL_outputs[0]_1\ : in STD_LOGIC;
    \GOL_outputs[0]_4\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_2 : entity is "GOL_cell";
end GOL_cell_2;

architecture STRUCTURE of GOL_cell_2 is
  signal \^gol_outputs[0]_3\ : STD_LOGIC;
  signal \val_i_2__21_n_0\ : STD_LOGIC;
  signal \val_i_3__1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \val_i_4__8\ : label is "soft_lutpair3";
begin
  \GOL_outputs[0]_3\ <= \^gol_outputs[0]_3\;
\val_i_1__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[0]_2\,
      I1 => \val_i_2__21_n_0\,
      I2 => \val_i_3__1_n_0\,
      I3 => val_reg_3,
      I4 => p_6_in,
      I5 => p_2_in,
      O => val_reg_0
    );
\val_i_2__21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[0]_3\,
      I1 => p_0_in,
      I2 => p_1_in,
      I3 => p_7_in,
      I4 => p_8_in,
      I5 => \GOL_outputs[0]_1\,
      O => \val_i_2__21_n_0\
    );
\val_i_3__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_3\,
      I1 => p_1_in,
      I2 => p_0_in,
      O => \val_i_3__1_n_0\
    );
\val_i_4__8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_3\,
      I1 => p_1_in,
      I2 => \GOL_outputs[0]_4\,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[0]_3\,
      S => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_20 is
  port (
    val_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    \row[2]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_2_out : in STD_LOGIC;
    p_4_out : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    row_IBUF : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_OBUF_inst_i_3 : in STD_LOGIC;
    p_2_in : in STD_LOGIC;
    \GOL_outputs[0]_3\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_20 : entity is "GOL_cell";
end GOL_cell_20;

architecture STRUCTURE of GOL_cell_20 is
  signal val_OBUF_inst_i_17_n_0 : STD_LOGIC;
  signal \val_i_2__22_n_0\ : STD_LOGIC;
  signal \val_i_3__19_n_0\ : STD_LOGIC;
  signal \^val_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__19\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \val_i_4__26\ : label is "soft_lutpair21";
begin
  val_reg_0(0) <= \^val_reg_0\(0);
val_OBUF_inst_i_17: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[2]\(2),
      I2 => row_IBUF(1),
      I3 => p_2_in,
      I4 => row_IBUF(0),
      I5 => \GOL_outputs[0]_3\,
      O => val_OBUF_inst_i_17_n_0
    );
val_OBUF_inst_i_8: unisim.vcomponents.MUXF7
     port map (
      I0 => val_OBUF_inst_i_17_n_0,
      I1 => val_OBUF_inst_i_3,
      O => \row[2]\(0),
      S => row_IBUF(2)
    );
\val_i_1__19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[3]\(1),
      I1 => \val_i_2__22_n_0\,
      I2 => \val_i_3__19_n_0\,
      I3 => val_reg_4,
      I4 => \GOL_outputs[2]\(0),
      I5 => p_2_out,
      O => val_reg_1
    );
\val_i_2__22\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => p_4_out,
      I2 => p_3_out,
      I3 => \GOL_outputs[2]\(1),
      I4 => \GOL_outputs[2]\(2),
      I5 => \GOL_outputs[3]\(0),
      O => \val_i_2__22_n_0\
    );
\val_i_3__19\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => p_3_out,
      I2 => p_4_out,
      O => \val_i_3__19_n_0\
    );
\val_i_4__26\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => p_3_out,
      I2 => \GOL_outputs[3]\(2),
      O => val_reg_2
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^val_reg_0\(0),
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_21 is
  port (
    \GOL_outputs[3]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_0 : out STD_LOGIC;
    val_OBUF : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_1_out : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    p_2_out : in STD_LOGIC;
    col_IBUF : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val : in STD_LOGIC;
    val_0 : in STD_LOGIC;
    val_OBUF_inst_i_1_0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    row_IBUF : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_OBUF_inst_i_2_0 : in STD_LOGIC;
    p_3_in : in STD_LOGIC;
    \GOL_outputs[0]_4\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_21 : entity is "GOL_cell";
end GOL_cell_21;

architecture STRUCTURE of GOL_cell_21 is
  signal \^gol_outputs[3]\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \GOL_outputs[5]\ : STD_LOGIC_VECTOR ( 4 to 4 );
  signal val_OBUF_inst_i_11_n_0 : STD_LOGIC;
  signal val_OBUF_inst_i_2_n_0 : STD_LOGIC;
  signal \val_i_2__28_n_0\ : STD_LOGIC;
  signal \val_i_3__20_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__20\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \val_i_4__27\ : label is "soft_lutpair22";
begin
  \GOL_outputs[3]\(0) <= \^gol_outputs[3]\(0);
val_OBUF_inst_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => val_OBUF_inst_i_2_n_0,
      I1 => col_IBUF(2),
      I2 => val,
      I3 => col_IBUF(1),
      I4 => val_0,
      O => val_OBUF
    );
val_OBUF_inst_i_11: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => \GOL_outputs[2]\(2),
      I2 => row_IBUF(1),
      I3 => p_3_in,
      I4 => row_IBUF(0),
      I5 => \GOL_outputs[0]_4\,
      O => val_OBUF_inst_i_11_n_0
    );
val_OBUF_inst_i_2: unisim.vcomponents.MUXF8
     port map (
      I0 => \GOL_outputs[5]\(4),
      I1 => val_OBUF_inst_i_1_0(0),
      O => val_OBUF_inst_i_2_n_0,
      S => col_IBUF(0)
    );
val_OBUF_inst_i_5: unisim.vcomponents.MUXF7
     port map (
      I0 => val_OBUF_inst_i_11_n_0,
      I1 => val_OBUF_inst_i_2_0,
      O => \GOL_outputs[5]\(4),
      S => row_IBUF(2)
    );
\val_i_1__20\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => val_reg_3(1),
      I1 => \val_i_2__28_n_0\,
      I2 => \val_i_3__20_n_0\,
      I3 => val_reg_4,
      I4 => \GOL_outputs[2]\(0),
      I5 => p_1_out,
      O => val_reg_0
    );
\val_i_2__28\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => p_3_out,
      I2 => p_2_out,
      I3 => \GOL_outputs[2]\(1),
      I4 => \GOL_outputs[2]\(2),
      I5 => val_reg_3(0),
      O => \val_i_2__28_n_0\
    );
\val_i_3__20\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => p_2_out,
      I2 => p_3_out,
      O => \val_i_3__20_n_0\
    );
\val_i_4__27\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[3]\(0),
      I1 => p_2_out,
      I2 => val_reg_3(2),
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[3]\(0),
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_22 is
  port (
    val_reg_0 : out STD_LOGIC_VECTOR ( 0 to 0 );
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    \row[2]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_reg_4 : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_0_out : in STD_LOGIC;
    p_2_out : in STD_LOGIC;
    p_1_out : in STD_LOGIC;
    row_IBUF : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val_OBUF_inst_i_2 : in STD_LOGIC;
    p_4_in : in STD_LOGIC;
    \GOL_outputs[0]_5\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_22 : entity is "GOL_cell";
end GOL_cell_22;

architecture STRUCTURE of GOL_cell_22 is
  signal val_OBUF_inst_i_13_n_0 : STD_LOGIC;
  signal \val_i_2__34_n_0\ : STD_LOGIC;
  signal \val_i_3__21_n_0\ : STD_LOGIC;
  signal \^val_reg_0\ : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__21\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \val_i_4__28\ : label is "soft_lutpair23";
begin
  val_reg_0(0) <= \^val_reg_0\(0);
val_OBUF_inst_i_13: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => \GOL_outputs[2]\(2),
      I2 => row_IBUF(1),
      I3 => p_4_in,
      I4 => row_IBUF(0),
      I5 => \GOL_outputs[0]_5\,
      O => val_OBUF_inst_i_13_n_0
    );
val_OBUF_inst_i_6: unisim.vcomponents.MUXF7
     port map (
      I0 => val_OBUF_inst_i_13_n_0,
      I1 => val_OBUF_inst_i_2,
      O => \row[2]\(0),
      S => row_IBUF(2)
    );
\val_i_1__21\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[3]\(2),
      I1 => \val_i_2__34_n_0\,
      I2 => \val_i_3__21_n_0\,
      I3 => val_reg_4,
      I4 => \GOL_outputs[2]\(0),
      I5 => p_0_out,
      O => val_reg_1
    );
\val_i_2__34\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => p_2_out,
      I2 => p_1_out,
      I3 => \GOL_outputs[2]\(1),
      I4 => \GOL_outputs[2]\(2),
      I5 => \GOL_outputs[3]\(1),
      O => \val_i_2__34_n_0\
    );
\val_i_3__21\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => p_1_out,
      I2 => p_2_out,
      O => \val_i_3__21_n_0\
    );
\val_i_4__28\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^val_reg_0\(0),
      I1 => p_1_out,
      I2 => \GOL_outputs[3]\(0),
      O => val_reg_2
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^val_reg_0\(0),
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_23 is
  port (
    p_5_out : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_0_out : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_11_in : in STD_LOGIC;
    p_9_in : in STD_LOGIC;
    p_10_in : in STD_LOGIC;
    p_1_out : in STD_LOGIC;
    p_4_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_23 : entity is "GOL_cell";
end GOL_cell_23;

architecture STRUCTURE of GOL_cell_23 is
  signal \^p_5_out\ : STD_LOGIC;
  signal \val_i_2__13_n_0\ : STD_LOGIC;
  signal \val_i_3__28_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__28\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \val_i_4__29\ : label is "soft_lutpair24";
begin
  p_5_out <= \^p_5_out\;
\val_i_1__28\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_0_out,
      I1 => \val_i_2__13_n_0\,
      I2 => \val_i_3__28_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[3]\(1),
      I5 => p_11_in,
      O => val_reg_0
    );
\val_i_2__13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_5_out\,
      I1 => p_9_in,
      I2 => p_10_in,
      I3 => \GOL_outputs[3]\(2),
      I4 => \GOL_outputs[3]\(0),
      I5 => p_1_out,
      O => \val_i_2__13_n_0\
    );
\val_i_3__28\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_5_out\,
      I1 => p_10_in,
      I2 => p_9_in,
      O => \val_i_3__28_n_0\
    );
\val_i_4__29\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_5_out\,
      I1 => p_10_in,
      I2 => p_4_out,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_5_out\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_24 is
  port (
    p_4_out : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_5_out : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_6_in : in STD_LOGIC;
    p_10_in : in STD_LOGIC;
    p_11_in : in STD_LOGIC;
    p_0_out : in STD_LOGIC;
    p_3_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_24 : entity is "GOL_cell";
end GOL_cell_24;

architecture STRUCTURE of GOL_cell_24 is
  signal \^p_4_out\ : STD_LOGIC;
  signal \val_i_2__16_n_0\ : STD_LOGIC;
  signal \val_i_3__23_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__23\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \val_i_4__30\ : label is "soft_lutpair25";
begin
  p_4_out <= \^p_4_out\;
\val_i_1__23\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_5_out,
      I1 => \val_i_2__16_n_0\,
      I2 => \val_i_3__23_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[3]\(2),
      I5 => p_6_in,
      O => val_reg_0
    );
\val_i_2__16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_4_out\,
      I1 => p_10_in,
      I2 => p_11_in,
      I3 => \GOL_outputs[3]\(0),
      I4 => \GOL_outputs[3]\(1),
      I5 => p_0_out,
      O => \val_i_2__16_n_0\
    );
\val_i_3__23\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_4_out\,
      I1 => p_11_in,
      I2 => p_10_in,
      O => \val_i_3__23_n_0\
    );
\val_i_4__30\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_4_out\,
      I1 => p_11_in,
      I2 => p_3_out,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_4_out\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_25 is
  port (
    p_3_out : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_4_out : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_7_in : in STD_LOGIC;
    p_11_in : in STD_LOGIC;
    p_6_in : in STD_LOGIC;
    p_5_out : in STD_LOGIC;
    p_2_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_25 : entity is "GOL_cell";
end GOL_cell_25;

architecture STRUCTURE of GOL_cell_25 is
  signal \^p_3_out\ : STD_LOGIC;
  signal \val_i_2__2_n_0\ : STD_LOGIC;
  signal \val_i_3__24_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__24\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \val_i_4__31\ : label is "soft_lutpair26";
begin
  p_3_out <= \^p_3_out\;
\val_i_1__24\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_4_out,
      I1 => \val_i_2__2_n_0\,
      I2 => \val_i_3__24_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[3]\(0),
      I5 => p_7_in,
      O => val_reg_0
    );
\val_i_2__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_3_out\,
      I1 => p_11_in,
      I2 => p_6_in,
      I3 => \GOL_outputs[3]\(1),
      I4 => \GOL_outputs[3]\(2),
      I5 => p_5_out,
      O => \val_i_2__2_n_0\
    );
\val_i_3__24\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_3_out\,
      I1 => p_6_in,
      I2 => p_11_in,
      O => \val_i_3__24_n_0\
    );
\val_i_4__31\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_3_out\,
      I1 => p_6_in,
      I2 => p_2_out,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_3_out\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_26 is
  port (
    p_2_out : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_8_in : in STD_LOGIC;
    p_6_in : in STD_LOGIC;
    p_7_in : in STD_LOGIC;
    p_4_out : in STD_LOGIC;
    p_1_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_26 : entity is "GOL_cell";
end GOL_cell_26;

architecture STRUCTURE of GOL_cell_26 is
  signal \^p_2_out\ : STD_LOGIC;
  signal \val_i_2__17_n_0\ : STD_LOGIC;
  signal \val_i_3__25_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__25\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \val_i_4__32\ : label is "soft_lutpair27";
begin
  p_2_out <= \^p_2_out\;
\val_i_1__25\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_3_out,
      I1 => \val_i_2__17_n_0\,
      I2 => \val_i_3__25_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[3]\(0),
      I5 => p_8_in,
      O => val_reg_0
    );
\val_i_2__17\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_2_out\,
      I1 => p_6_in,
      I2 => p_7_in,
      I3 => \GOL_outputs[3]\(1),
      I4 => \GOL_outputs[3]\(2),
      I5 => p_4_out,
      O => \val_i_2__17_n_0\
    );
\val_i_3__25\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_2_out\,
      I1 => p_7_in,
      I2 => p_6_in,
      O => \val_i_3__25_n_0\
    );
\val_i_4__32\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_2_out\,
      I1 => p_7_in,
      I2 => p_1_out,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_2_out\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_27 is
  port (
    p_1_out : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_2_out : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_9_in : in STD_LOGIC;
    p_7_in : in STD_LOGIC;
    p_8_in : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    p_0_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_27 : entity is "GOL_cell";
end GOL_cell_27;

architecture STRUCTURE of GOL_cell_27 is
  signal \^p_1_out\ : STD_LOGIC;
  signal \val_i_2__23_n_0\ : STD_LOGIC;
  signal \val_i_3__26_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__26\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \val_i_4__33\ : label is "soft_lutpair28";
begin
  p_1_out <= \^p_1_out\;
\val_i_1__26\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_2_out,
      I1 => \val_i_2__23_n_0\,
      I2 => \val_i_3__26_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[3]\(0),
      I5 => p_9_in,
      O => val_reg_0
    );
\val_i_2__23\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_1_out\,
      I1 => p_7_in,
      I2 => p_8_in,
      I3 => \GOL_outputs[3]\(1),
      I4 => \GOL_outputs[3]\(2),
      I5 => p_3_out,
      O => \val_i_2__23_n_0\
    );
\val_i_3__26\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_1_out\,
      I1 => p_8_in,
      I2 => p_7_in,
      O => \val_i_3__26_n_0\
    );
\val_i_4__33\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_1_out\,
      I1 => p_8_in,
      I2 => p_0_out,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_1_out\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_28 is
  port (
    p_0_out : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_1_out : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[3]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    p_10_in : in STD_LOGIC;
    p_8_in : in STD_LOGIC;
    p_9_in : in STD_LOGIC;
    p_2_out : in STD_LOGIC;
    p_5_out : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_28 : entity is "GOL_cell";
end GOL_cell_28;

architecture STRUCTURE of GOL_cell_28 is
  signal \^p_0_out\ : STD_LOGIC;
  signal \val_i_2__29_n_0\ : STD_LOGIC;
  signal \val_i_3__27_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__27\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \val_i_4__34\ : label is "soft_lutpair29";
begin
  p_0_out <= \^p_0_out\;
\val_i_1__27\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_1_out,
      I1 => \val_i_2__29_n_0\,
      I2 => \val_i_3__27_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[3]\(0),
      I5 => p_10_in,
      O => val_reg_0
    );
\val_i_2__29\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_0_out\,
      I1 => p_8_in,
      I2 => p_9_in,
      I3 => \GOL_outputs[3]\(1),
      I4 => \GOL_outputs[3]\(2),
      I5 => p_2_out,
      O => \val_i_2__29_n_0\
    );
\val_i_3__27\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_0_out\,
      I1 => p_9_in,
      I2 => p_8_in,
      O => \val_i_3__27_n_0\
    );
\val_i_4__34\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_0_out\,
      I1 => p_9_in,
      I2 => p_5_out,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_0_out\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_29 is
  port (
    p_11_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_10_in : in STD_LOGIC;
    val_reg_4 : in STD_LOGIC;
    p_1_out : in STD_LOGIC;
    \GOL_outputs[0]_0\ : in STD_LOGIC;
    \GOL_outputs[0]_4\ : in STD_LOGIC;
    \GOL_outputs[0]_5\ : in STD_LOGIC;
    p_0_out : in STD_LOGIC;
    p_5_out : in STD_LOGIC;
    p_9_in : in STD_LOGIC;
    p_6_in : in STD_LOGIC;
    row_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_29 : entity is "GOL_cell";
end GOL_cell_29;

architecture STRUCTURE of GOL_cell_29 is
  signal \^p_11_in\ : STD_LOGIC;
  signal \val_i_2__1_n_0\ : STD_LOGIC;
  signal \val_i_3__34_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__34\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of val_i_4 : label is "soft_lutpair30";
begin
  p_11_in <= \^p_11_in\;
val_OBUF_inst_i_20: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^p_11_in\,
      I1 => row_IBUF(0),
      I2 => p_5_out,
      O => val_reg_2
    );
\val_i_1__34\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_10_in,
      I1 => \val_i_2__1_n_0\,
      I2 => \val_i_3__34_n_0\,
      I3 => val_reg_4,
      I4 => p_1_out,
      I5 => \GOL_outputs[0]_0\,
      O => val_reg_0
    );
\val_i_2__1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_11_in\,
      I1 => \GOL_outputs[0]_4\,
      I2 => \GOL_outputs[0]_5\,
      I3 => p_0_out,
      I4 => p_5_out,
      I5 => p_9_in,
      O => \val_i_2__1_n_0\
    );
\val_i_3__34\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_11_in\,
      I1 => \GOL_outputs[0]_5\,
      I2 => \GOL_outputs[0]_4\,
      O => \val_i_3__34_n_0\
    );
val_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_11_in\,
      I1 => \GOL_outputs[0]_5\,
      I2 => p_6_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^p_11_in\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_3 is
  port (
    \GOL_outputs[0]_4\ : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[0]_3\ : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    p_7_in : in STD_LOGIC;
    p_3_in : in STD_LOGIC;
    p_1_in : in STD_LOGIC;
    p_2_in : in STD_LOGIC;
    p_8_in : in STD_LOGIC;
    p_9_in : in STD_LOGIC;
    \GOL_outputs[0]_2\ : in STD_LOGIC;
    \GOL_outputs[0]_5\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_3 : entity is "GOL_cell";
end GOL_cell_3;

architecture STRUCTURE of GOL_cell_3 is
  signal \^gol_outputs[0]_4\ : STD_LOGIC;
  signal \val_i_2__27_n_0\ : STD_LOGIC;
  signal \val_i_3__2_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \val_i_4__9\ : label is "soft_lutpair4";
begin
  \GOL_outputs[0]_4\ <= \^gol_outputs[0]_4\;
\val_i_1__2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[0]_3\,
      I1 => \val_i_2__27_n_0\,
      I2 => \val_i_3__2_n_0\,
      I3 => val_reg_3,
      I4 => p_7_in,
      I5 => p_3_in,
      O => val_reg_0
    );
\val_i_2__27\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[0]_4\,
      I1 => p_1_in,
      I2 => p_2_in,
      I3 => p_8_in,
      I4 => p_9_in,
      I5 => \GOL_outputs[0]_2\,
      O => \val_i_2__27_n_0\
    );
\val_i_3__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_4\,
      I1 => p_2_in,
      I2 => p_1_in,
      O => \val_i_3__2_n_0\
    );
\val_i_4__9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_4\,
      I1 => p_2_in,
      I2 => \GOL_outputs[0]_5\,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[0]_4\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_30 is
  port (
    p_6_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_11_in : in STD_LOGIC;
    val_reg_4 : in STD_LOGIC;
    p_0_out : in STD_LOGIC;
    \GOL_outputs[0]_1\ : in STD_LOGIC;
    \GOL_outputs[0]_5\ : in STD_LOGIC;
    \GOL_outputs[0]_0\ : in STD_LOGIC;
    p_5_out : in STD_LOGIC;
    p_4_out : in STD_LOGIC;
    p_10_in : in STD_LOGIC;
    p_7_in : in STD_LOGIC;
    row_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_30 : entity is "GOL_cell";
end GOL_cell_30;

architecture STRUCTURE of GOL_cell_30 is
  signal \^p_6_in\ : STD_LOGIC;
  signal val_i_2_n_0 : STD_LOGIC;
  signal \val_i_3__29_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__29\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \val_i_4__0\ : label is "soft_lutpair31";
begin
  p_6_in <= \^p_6_in\;
val_OBUF_inst_i_22: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^p_6_in\,
      I1 => row_IBUF(0),
      I2 => p_4_out,
      O => val_reg_2
    );
\val_i_1__29\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_11_in,
      I1 => val_i_2_n_0,
      I2 => \val_i_3__29_n_0\,
      I3 => val_reg_4,
      I4 => p_0_out,
      I5 => \GOL_outputs[0]_1\,
      O => val_reg_0
    );
val_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_6_in\,
      I1 => \GOL_outputs[0]_5\,
      I2 => \GOL_outputs[0]_0\,
      I3 => p_5_out,
      I4 => p_4_out,
      I5 => p_10_in,
      O => val_i_2_n_0
    );
\val_i_3__29\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_6_in\,
      I1 => \GOL_outputs[0]_0\,
      I2 => \GOL_outputs[0]_5\,
      O => \val_i_3__29_n_0\
    );
\val_i_4__0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_6_in\,
      I1 => \GOL_outputs[0]_0\,
      I2 => p_7_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^p_6_in\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_31 is
  port (
    p_7_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_6_in : in STD_LOGIC;
    val_reg_4 : in STD_LOGIC;
    p_5_out : in STD_LOGIC;
    \GOL_outputs[0]_2\ : in STD_LOGIC;
    \GOL_outputs[0]_0\ : in STD_LOGIC;
    \GOL_outputs[0]_1\ : in STD_LOGIC;
    p_4_out : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    p_11_in : in STD_LOGIC;
    p_8_in : in STD_LOGIC;
    row_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_31 : entity is "GOL_cell";
end GOL_cell_31;

architecture STRUCTURE of GOL_cell_31 is
  signal \^p_7_in\ : STD_LOGIC;
  signal \val_i_2__7_n_0\ : STD_LOGIC;
  signal \val_i_3__30_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__30\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \val_i_4__1\ : label is "soft_lutpair32";
begin
  p_7_in <= \^p_7_in\;
val_OBUF_inst_i_16: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^p_7_in\,
      I1 => row_IBUF(0),
      I2 => p_3_out,
      O => val_reg_2
    );
\val_i_1__30\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_6_in,
      I1 => \val_i_2__7_n_0\,
      I2 => \val_i_3__30_n_0\,
      I3 => val_reg_4,
      I4 => p_5_out,
      I5 => \GOL_outputs[0]_2\,
      O => val_reg_0
    );
\val_i_2__7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_7_in\,
      I1 => \GOL_outputs[0]_0\,
      I2 => \GOL_outputs[0]_1\,
      I3 => p_4_out,
      I4 => p_3_out,
      I5 => p_11_in,
      O => \val_i_2__7_n_0\
    );
\val_i_3__30\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_7_in\,
      I1 => \GOL_outputs[0]_1\,
      I2 => \GOL_outputs[0]_0\,
      O => \val_i_3__30_n_0\
    );
\val_i_4__1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_7_in\,
      I1 => \GOL_outputs[0]_1\,
      I2 => p_8_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^p_7_in\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_32 is
  port (
    p_8_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_7_in : in STD_LOGIC;
    val_reg_4 : in STD_LOGIC;
    p_4_out : in STD_LOGIC;
    \GOL_outputs[0]_3\ : in STD_LOGIC;
    \GOL_outputs[0]_1\ : in STD_LOGIC;
    \GOL_outputs[0]_2\ : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    p_2_out : in STD_LOGIC;
    p_6_in : in STD_LOGIC;
    p_9_in : in STD_LOGIC;
    row_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_32 : entity is "GOL_cell";
end GOL_cell_32;

architecture STRUCTURE of GOL_cell_32 is
  signal \^p_8_in\ : STD_LOGIC;
  signal \val_i_2__19_n_0\ : STD_LOGIC;
  signal \val_i_3__31_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__31\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \val_i_4__2\ : label is "soft_lutpair33";
begin
  p_8_in <= \^p_8_in\;
val_OBUF_inst_i_18: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^p_8_in\,
      I1 => row_IBUF(0),
      I2 => p_2_out,
      O => val_reg_2
    );
\val_i_1__31\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_7_in,
      I1 => \val_i_2__19_n_0\,
      I2 => \val_i_3__31_n_0\,
      I3 => val_reg_4,
      I4 => p_4_out,
      I5 => \GOL_outputs[0]_3\,
      O => val_reg_0
    );
\val_i_2__19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_8_in\,
      I1 => \GOL_outputs[0]_1\,
      I2 => \GOL_outputs[0]_2\,
      I3 => p_3_out,
      I4 => p_2_out,
      I5 => p_6_in,
      O => \val_i_2__19_n_0\
    );
\val_i_3__31\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_8_in\,
      I1 => \GOL_outputs[0]_2\,
      I2 => \GOL_outputs[0]_1\,
      O => \val_i_3__31_n_0\
    );
\val_i_4__2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_8_in\,
      I1 => \GOL_outputs[0]_2\,
      I2 => p_9_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^p_8_in\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_33 is
  port (
    p_9_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_8_in : in STD_LOGIC;
    val_reg_4 : in STD_LOGIC;
    p_3_out : in STD_LOGIC;
    \GOL_outputs[0]_4\ : in STD_LOGIC;
    \GOL_outputs[0]_2\ : in STD_LOGIC;
    \GOL_outputs[0]_3\ : in STD_LOGIC;
    p_2_out : in STD_LOGIC;
    p_1_out : in STD_LOGIC;
    p_7_in : in STD_LOGIC;
    p_10_in : in STD_LOGIC;
    row_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_33 : entity is "GOL_cell";
end GOL_cell_33;

architecture STRUCTURE of GOL_cell_33 is
  signal \^p_9_in\ : STD_LOGIC;
  signal \val_i_2__25_n_0\ : STD_LOGIC;
  signal \val_i_3__32_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__32\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \val_i_4__3\ : label is "soft_lutpair34";
begin
  p_9_in <= \^p_9_in\;
val_OBUF_inst_i_12: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^p_9_in\,
      I1 => row_IBUF(0),
      I2 => p_1_out,
      O => val_reg_2
    );
\val_i_1__32\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_8_in,
      I1 => \val_i_2__25_n_0\,
      I2 => \val_i_3__32_n_0\,
      I3 => val_reg_4,
      I4 => p_3_out,
      I5 => \GOL_outputs[0]_4\,
      O => val_reg_0
    );
\val_i_2__25\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_9_in\,
      I1 => \GOL_outputs[0]_2\,
      I2 => \GOL_outputs[0]_3\,
      I3 => p_2_out,
      I4 => p_1_out,
      I5 => p_7_in,
      O => \val_i_2__25_n_0\
    );
\val_i_3__32\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_9_in\,
      I1 => \GOL_outputs[0]_3\,
      I2 => \GOL_outputs[0]_2\,
      O => \val_i_3__32_n_0\
    );
\val_i_4__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_9_in\,
      I1 => \GOL_outputs[0]_3\,
      I2 => p_10_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^p_9_in\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_34 is
  port (
    p_10_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    val_reg_2 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_9_in : in STD_LOGIC;
    val_reg_4 : in STD_LOGIC;
    p_2_out : in STD_LOGIC;
    \GOL_outputs[0]_5\ : in STD_LOGIC;
    \GOL_outputs[0]_3\ : in STD_LOGIC;
    \GOL_outputs[0]_4\ : in STD_LOGIC;
    p_1_out : in STD_LOGIC;
    p_0_out : in STD_LOGIC;
    p_8_in : in STD_LOGIC;
    p_11_in : in STD_LOGIC;
    row_IBUF : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_34 : entity is "GOL_cell";
end GOL_cell_34;

architecture STRUCTURE of GOL_cell_34 is
  signal \^p_10_in\ : STD_LOGIC;
  signal \val_i_2__31_n_0\ : STD_LOGIC;
  signal \val_i_3__33_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__33\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \val_i_4__4\ : label is "soft_lutpair35";
begin
  p_10_in <= \^p_10_in\;
val_OBUF_inst_i_14: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \^p_10_in\,
      I1 => row_IBUF(0),
      I2 => p_0_out,
      O => val_reg_2
    );
\val_i_1__33\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_9_in,
      I1 => \val_i_2__31_n_0\,
      I2 => \val_i_3__33_n_0\,
      I3 => val_reg_4,
      I4 => p_2_out,
      I5 => \GOL_outputs[0]_5\,
      O => val_reg_0
    );
\val_i_2__31\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_10_in\,
      I1 => \GOL_outputs[0]_3\,
      I2 => \GOL_outputs[0]_4\,
      I3 => p_1_out,
      I4 => p_0_out,
      I5 => p_8_in,
      O => \val_i_2__31_n_0\
    );
\val_i_3__33\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_10_in\,
      I1 => \GOL_outputs[0]_4\,
      I2 => \GOL_outputs[0]_3\,
      O => \val_i_3__33_n_0\
    );
\val_i_4__4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_10_in\,
      I1 => \GOL_outputs[0]_4\,
      I2 => p_11_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_3,
      Q => \^p_10_in\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_4 is
  port (
    \GOL_outputs[0]_5\ : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    \GOL_outputs[0]_4\ : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    p_8_in : in STD_LOGIC;
    p_4_in : in STD_LOGIC;
    p_2_in : in STD_LOGIC;
    p_3_in : in STD_LOGIC;
    p_9_in : in STD_LOGIC;
    p_10_in : in STD_LOGIC;
    \GOL_outputs[0]_3\ : in STD_LOGIC;
    \GOL_outputs[0]_0\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_4 : entity is "GOL_cell";
end GOL_cell_4;

architecture STRUCTURE of GOL_cell_4 is
  signal \^gol_outputs[0]_5\ : STD_LOGIC;
  signal \val_i_2__33_n_0\ : STD_LOGIC;
  signal \val_i_3__3_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__3\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \val_i_4__10\ : label is "soft_lutpair5";
begin
  \GOL_outputs[0]_5\ <= \^gol_outputs[0]_5\;
\val_i_1__3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => \GOL_outputs[0]_4\,
      I1 => \val_i_2__33_n_0\,
      I2 => \val_i_3__3_n_0\,
      I3 => val_reg_3,
      I4 => p_8_in,
      I5 => p_4_in,
      O => val_reg_0
    );
\val_i_2__33\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^gol_outputs[0]_5\,
      I1 => p_2_in,
      I2 => p_3_in,
      I3 => p_9_in,
      I4 => p_10_in,
      I5 => \GOL_outputs[0]_3\,
      O => \val_i_2__33_n_0\
    );
\val_i_3__3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_5\,
      I1 => p_3_in,
      I2 => p_2_in,
      O => \val_i_3__3_n_0\
    );
\val_i_4__10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^gol_outputs[0]_5\,
      I1 => p_3_in,
      I2 => \GOL_outputs[0]_0\,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^gol_outputs[0]_5\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_5 is
  port (
    p_5_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_4_in : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[0]_4\ : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GOL_outputs[0]_5\ : in STD_LOGIC;
    \GOL_outputs[0]_0\ : in STD_LOGIC;
    p_3_in : in STD_LOGIC;
    p_0_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_5 : entity is "GOL_cell";
end GOL_cell_5;

architecture STRUCTURE of GOL_cell_5 is
  signal \^p_5_in\ : STD_LOGIC;
  signal \val_i_2__11_n_0\ : STD_LOGIC;
  signal \val_i_3__10_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__10\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \val_i_4__11\ : label is "soft_lutpair6";
begin
  p_5_in <= \^p_5_in\;
\val_i_1__10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_4_in,
      I1 => \val_i_2__11_n_0\,
      I2 => \val_i_3__10_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[0]_4\,
      I5 => \GOL_outputs[2]\(0),
      O => val_reg_0
    );
\val_i_2__11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_5_in\,
      I1 => \GOL_outputs[2]\(1),
      I2 => \GOL_outputs[2]\(2),
      I3 => \GOL_outputs[0]_5\,
      I4 => \GOL_outputs[0]_0\,
      I5 => p_3_in,
      O => \val_i_2__11_n_0\
    );
\val_i_3__10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_5_in\,
      I1 => \GOL_outputs[2]\(2),
      I2 => \GOL_outputs[2]\(1),
      O => \val_i_3__10_n_0\
    );
\val_i_4__11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_5_in\,
      I1 => \GOL_outputs[2]\(2),
      I2 => p_0_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_5_in\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_6 is
  port (
    p_0_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_5_in : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[0]_5\ : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GOL_outputs[0]_0\ : in STD_LOGIC;
    \GOL_outputs[0]_1\ : in STD_LOGIC;
    p_4_in : in STD_LOGIC;
    p_1_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_6 : entity is "GOL_cell";
end GOL_cell_6;

architecture STRUCTURE of GOL_cell_6 is
  signal \^p_0_in\ : STD_LOGIC;
  signal \val_i_2__5_n_0\ : STD_LOGIC;
  signal \val_i_3__5_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__5\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \val_i_4__12\ : label is "soft_lutpair7";
begin
  p_0_in <= \^p_0_in\;
\val_i_1__5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_5_in,
      I1 => \val_i_2__5_n_0\,
      I2 => \val_i_3__5_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[0]_5\,
      I5 => \GOL_outputs[2]\(1),
      O => val_reg_0
    );
\val_i_2__5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_0_in\,
      I1 => \GOL_outputs[2]\(2),
      I2 => \GOL_outputs[2]\(0),
      I3 => \GOL_outputs[0]_0\,
      I4 => \GOL_outputs[0]_1\,
      I5 => p_4_in,
      O => \val_i_2__5_n_0\
    );
\val_i_3__5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_0_in\,
      I1 => \GOL_outputs[2]\(0),
      I2 => \GOL_outputs[2]\(2),
      O => \val_i_3__5_n_0\
    );
\val_i_4__12\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_0_in\,
      I1 => \GOL_outputs[2]\(0),
      I2 => p_1_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_0_in\,
      S => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_7 is
  port (
    p_1_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_0_in : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[0]_0\ : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GOL_outputs[0]_1\ : in STD_LOGIC;
    \GOL_outputs[0]_2\ : in STD_LOGIC;
    p_5_in : in STD_LOGIC;
    p_2_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_7 : entity is "GOL_cell";
end GOL_cell_7;

architecture STRUCTURE of GOL_cell_7 is
  signal \^p_1_in\ : STD_LOGIC;
  signal \val_i_2__4_n_0\ : STD_LOGIC;
  signal \val_i_3__6_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__6\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \val_i_4__13\ : label is "soft_lutpair8";
begin
  p_1_in <= \^p_1_in\;
\val_i_1__6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_0_in,
      I1 => \val_i_2__4_n_0\,
      I2 => \val_i_3__6_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[0]_0\,
      I5 => \GOL_outputs[2]\(2),
      O => val_reg_0
    );
\val_i_2__4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_1_in\,
      I1 => \GOL_outputs[2]\(0),
      I2 => \GOL_outputs[2]\(1),
      I3 => \GOL_outputs[0]_1\,
      I4 => \GOL_outputs[0]_2\,
      I5 => p_5_in,
      O => \val_i_2__4_n_0\
    );
\val_i_3__6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_1_in\,
      I1 => \GOL_outputs[2]\(1),
      I2 => \GOL_outputs[2]\(0),
      O => \val_i_3__6_n_0\
    );
\val_i_4__13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_1_in\,
      I1 => \GOL_outputs[2]\(1),
      I2 => p_2_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_1_in\,
      S => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_8 is
  port (
    p_2_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_1_in : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[0]_1\ : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GOL_outputs[0]_2\ : in STD_LOGIC;
    \GOL_outputs[0]_3\ : in STD_LOGIC;
    p_0_in : in STD_LOGIC;
    p_3_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_8 : entity is "GOL_cell";
end GOL_cell_8;

architecture STRUCTURE of GOL_cell_8 is
  signal \^p_2_in\ : STD_LOGIC;
  signal \val_i_2__18_n_0\ : STD_LOGIC;
  signal \val_i_3__7_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__7\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \val_i_4__14\ : label is "soft_lutpair9";
begin
  p_2_in <= \^p_2_in\;
\val_i_1__7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_1_in,
      I1 => \val_i_2__18_n_0\,
      I2 => \val_i_3__7_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[0]_1\,
      I5 => \GOL_outputs[2]\(2),
      O => val_reg_0
    );
\val_i_2__18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_2_in\,
      I1 => \GOL_outputs[2]\(0),
      I2 => \GOL_outputs[2]\(1),
      I3 => \GOL_outputs[0]_2\,
      I4 => \GOL_outputs[0]_3\,
      I5 => p_0_in,
      O => \val_i_2__18_n_0\
    );
\val_i_3__7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_2_in\,
      I1 => \GOL_outputs[2]\(1),
      I2 => \GOL_outputs[2]\(0),
      O => \val_i_3__7_n_0\
    );
\val_i_4__14\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_2_in\,
      I1 => \GOL_outputs[2]\(1),
      I2 => p_3_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_2_in\,
      R => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL_cell_9 is
  port (
    p_3_in : out STD_LOGIC;
    val_reg_0 : out STD_LOGIC;
    val_reg_1 : out STD_LOGIC;
    rst_IBUF : in STD_LOGIC;
    val_reg_2 : in STD_LOGIC;
    clk_IBUF_BUFG : in STD_LOGIC;
    p_2_in : in STD_LOGIC;
    val_reg_3 : in STD_LOGIC;
    \GOL_outputs[0]_2\ : in STD_LOGIC;
    \GOL_outputs[2]\ : in STD_LOGIC_VECTOR ( 2 downto 0 );
    \GOL_outputs[0]_3\ : in STD_LOGIC;
    \GOL_outputs[0]_4\ : in STD_LOGIC;
    p_1_in : in STD_LOGIC;
    p_4_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of GOL_cell_9 : entity is "GOL_cell";
end GOL_cell_9;

architecture STRUCTURE of GOL_cell_9 is
  signal \^p_3_in\ : STD_LOGIC;
  signal \val_i_2__24_n_0\ : STD_LOGIC;
  signal \val_i_3__8_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \val_i_3__8\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \val_i_4__15\ : label is "soft_lutpair10";
begin
  p_3_in <= \^p_3_in\;
\val_i_1__8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8332322C322C2CC8"
    )
        port map (
      I0 => p_2_in,
      I1 => \val_i_2__24_n_0\,
      I2 => \val_i_3__8_n_0\,
      I3 => val_reg_3,
      I4 => \GOL_outputs[0]_2\,
      I5 => \GOL_outputs[2]\(2),
      O => val_reg_0
    );
\val_i_2__24\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"171717E817E8E8E8"
    )
        port map (
      I0 => \^p_3_in\,
      I1 => \GOL_outputs[2]\(0),
      I2 => \GOL_outputs[2]\(1),
      I3 => \GOL_outputs[0]_3\,
      I4 => \GOL_outputs[0]_4\,
      I5 => p_1_in,
      O => \val_i_2__24_n_0\
    );
\val_i_3__8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_3_in\,
      I1 => \GOL_outputs[2]\(1),
      I2 => \GOL_outputs[2]\(0),
      O => \val_i_3__8_n_0\
    );
\val_i_4__15\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"96"
    )
        port map (
      I0 => \^p_3_in\,
      I1 => \GOL_outputs[2]\(1),
      I2 => p_4_in,
      O => val_reg_1
    );
val_reg: unisim.vcomponents.FDSE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => val_reg_2,
      Q => \^p_3_in\,
      S => rst_IBUF
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GOL is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    row : in STD_LOGIC_VECTOR ( 2 downto 0 );
    col : in STD_LOGIC_VECTOR ( 2 downto 0 );
    val : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of GOL : entity is true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of GOL : entity is "84ebf627";
  attribute h : integer;
  attribute h of GOL : entity is 6;
  attribute w : integer;
  attribute w of GOL : entity is 6;
end GOL;

architecture STRUCTURE of GOL is
  signal \GOL_outputs[0]_0\ : STD_LOGIC;
  signal \GOL_outputs[0]_1\ : STD_LOGIC;
  signal \GOL_outputs[0]_2\ : STD_LOGIC;
  signal \GOL_outputs[0]_3\ : STD_LOGIC;
  signal \GOL_outputs[0]_4\ : STD_LOGIC;
  signal \GOL_outputs[0]_5\ : STD_LOGIC;
  signal \GOL_outputs[2]\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \GOL_outputs[3]\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal \GOL_outputs[5]\ : STD_LOGIC_VECTOR ( 5 downto 1 );
  signal clk_IBUF : STD_LOGIC;
  signal clk_IBUF_BUFG : STD_LOGIC;
  signal col_IBUF : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal p_0_in : STD_LOGIC;
  signal p_0_out : STD_LOGIC;
  signal p_10_in : STD_LOGIC;
  signal p_11_in : STD_LOGIC;
  signal p_1_in : STD_LOGIC;
  signal p_1_out : STD_LOGIC;
  signal p_2_in : STD_LOGIC;
  signal p_2_out : STD_LOGIC;
  signal p_3_in : STD_LOGIC;
  signal p_3_out : STD_LOGIC;
  signal p_4_in : STD_LOGIC;
  signal p_4_out : STD_LOGIC;
  signal p_5_in : STD_LOGIC;
  signal p_5_out : STD_LOGIC;
  signal p_6_in : STD_LOGIC;
  signal p_7_in : STD_LOGIC;
  signal p_8_in : STD_LOGIC;
  signal p_9_in : STD_LOGIC;
  signal row_IBUF : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \rows[0].cols[0].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[0].cols[0].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[0].cols[1].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[0].cols[1].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[0].cols[2].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[0].cols[2].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[0].cols[3].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[0].cols[3].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[0].cols[4].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[0].cols[4].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[0].cols[5].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[0].cols[5].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[1].cols[0].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[1].cols[0].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[1].cols[1].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[1].cols[1].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[1].cols[2].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[1].cols[2].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[1].cols[3].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[1].cols[3].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[1].cols[4].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[1].cols[4].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[1].cols[5].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[1].cols[5].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[2].cols[0].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[2].cols[0].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[2].cols[1].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[2].cols[1].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[2].cols[2].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[2].cols[2].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[2].cols[3].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[2].cols[3].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[2].cols[4].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[2].cols[4].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[2].cols[5].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[2].cols[5].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[3].cols[0].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[3].cols[0].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[3].cols[0].gol_cell_inst_n_3\ : STD_LOGIC;
  signal \rows[3].cols[1].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[3].cols[1].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[3].cols[2].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[3].cols[2].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[3].cols[2].gol_cell_inst_n_3\ : STD_LOGIC;
  signal \rows[3].cols[3].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[3].cols[3].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[3].cols[4].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[3].cols[4].gol_cell_inst_n_3\ : STD_LOGIC;
  signal \rows[3].cols[5].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[3].cols[5].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[4].cols[0].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[4].cols[0].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[4].cols[1].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[4].cols[1].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[4].cols[2].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[4].cols[2].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[4].cols[3].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[4].cols[3].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[4].cols[4].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[4].cols[4].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[4].cols[5].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[4].cols[5].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[5].cols[0].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[5].cols[0].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[5].cols[0].gol_cell_inst_n_3\ : STD_LOGIC;
  signal \rows[5].cols[1].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[5].cols[1].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[5].cols[1].gol_cell_inst_n_3\ : STD_LOGIC;
  signal \rows[5].cols[2].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[5].cols[2].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[5].cols[2].gol_cell_inst_n_3\ : STD_LOGIC;
  signal \rows[5].cols[3].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[5].cols[3].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[5].cols[3].gol_cell_inst_n_3\ : STD_LOGIC;
  signal \rows[5].cols[4].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[5].cols[4].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[5].cols[4].gol_cell_inst_n_3\ : STD_LOGIC;
  signal \rows[5].cols[5].gol_cell_inst_n_1\ : STD_LOGIC;
  signal \rows[5].cols[5].gol_cell_inst_n_2\ : STD_LOGIC;
  signal \rows[5].cols[5].gol_cell_inst_n_3\ : STD_LOGIC;
  signal rst_IBUF : STD_LOGIC;
  signal val_OBUF : STD_LOGIC;
begin
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
\col_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => col(0),
      O => col_IBUF(0)
    );
\col_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => col(1),
      O => col_IBUF(1)
    );
\col_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => col(2),
      O => col_IBUF(2)
    );
\row_IBUF[0]_inst\: unisim.vcomponents.IBUF
     port map (
      I => row(0),
      O => row_IBUF(0)
    );
\row_IBUF[1]_inst\: unisim.vcomponents.IBUF
     port map (
      I => row(1),
      O => row_IBUF(1)
    );
\row_IBUF[2]_inst\: unisim.vcomponents.IBUF
     port map (
      I => row(2),
      O => row_IBUF(2)
    );
\rows[0].cols[0].gol_cell_inst\: entity work.GOL_cell
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_10_in => p_10_in,
      p_11_in => p_11_in,
      p_3_in => p_3_in,
      p_4_in => p_4_in,
      p_5_in => p_5_in,
      p_9_in => p_9_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[0].cols[0].gol_cell_inst_n_1\,
      val_reg_1 => \rows[0].cols[0].gol_cell_inst_n_2\,
      val_reg_2 => \rows[0].cols[1].gol_cell_inst_n_1\,
      val_reg_3 => \rows[5].cols[5].gol_cell_inst_n_2\
    );
\rows[0].cols[1].gol_cell_inst\: entity work.GOL_cell_0
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_10_in => p_10_in,
      p_11_in => p_11_in,
      p_4_in => p_4_in,
      p_5_in => p_5_in,
      p_6_in => p_6_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[0].cols[1].gol_cell_inst_n_1\,
      val_reg_1 => \rows[0].cols[1].gol_cell_inst_n_2\,
      val_reg_2 => \rows[0].cols[2].gol_cell_inst_n_1\,
      val_reg_3 => \rows[5].cols[0].gol_cell_inst_n_2\
    );
\rows[0].cols[2].gol_cell_inst\: entity work.GOL_cell_1
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_11_in => p_11_in,
      p_1_in => p_1_in,
      p_5_in => p_5_in,
      p_6_in => p_6_in,
      p_7_in => p_7_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[0].cols[2].gol_cell_inst_n_1\,
      val_reg_1 => \rows[0].cols[2].gol_cell_inst_n_2\,
      val_reg_2 => \rows[0].cols[3].gol_cell_inst_n_1\,
      val_reg_3 => \rows[5].cols[1].gol_cell_inst_n_2\
    );
\rows[0].cols[3].gol_cell_inst\: entity work.GOL_cell_2
     port map (
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_1_in => p_1_in,
      p_2_in => p_2_in,
      p_6_in => p_6_in,
      p_7_in => p_7_in,
      p_8_in => p_8_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[0].cols[3].gol_cell_inst_n_1\,
      val_reg_1 => \rows[0].cols[3].gol_cell_inst_n_2\,
      val_reg_2 => \rows[0].cols[4].gol_cell_inst_n_1\,
      val_reg_3 => \rows[5].cols[2].gol_cell_inst_n_2\
    );
\rows[0].cols[4].gol_cell_inst\: entity work.GOL_cell_3
     port map (
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_1_in => p_1_in,
      p_2_in => p_2_in,
      p_3_in => p_3_in,
      p_7_in => p_7_in,
      p_8_in => p_8_in,
      p_9_in => p_9_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[0].cols[4].gol_cell_inst_n_1\,
      val_reg_1 => \rows[0].cols[4].gol_cell_inst_n_2\,
      val_reg_2 => \rows[0].cols[5].gol_cell_inst_n_1\,
      val_reg_3 => \rows[5].cols[3].gol_cell_inst_n_2\
    );
\rows[0].cols[5].gol_cell_inst\: entity work.GOL_cell_4
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_10_in => p_10_in,
      p_2_in => p_2_in,
      p_3_in => p_3_in,
      p_4_in => p_4_in,
      p_8_in => p_8_in,
      p_9_in => p_9_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[0].cols[5].gol_cell_inst_n_1\,
      val_reg_1 => \rows[0].cols[5].gol_cell_inst_n_2\,
      val_reg_2 => \rows[0].cols[0].gol_cell_inst_n_1\,
      val_reg_3 => \rows[5].cols[4].gol_cell_inst_n_2\
    );
\rows[1].cols[0].gol_cell_inst\: entity work.GOL_cell_5
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      \GOL_outputs[2]\(2 downto 1) => \GOL_outputs[2]\(5 downto 4),
      \GOL_outputs[2]\(0) => \GOL_outputs[2]\(0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_3_in => p_3_in,
      p_4_in => p_4_in,
      p_5_in => p_5_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[1].cols[0].gol_cell_inst_n_1\,
      val_reg_1 => \rows[1].cols[0].gol_cell_inst_n_2\,
      val_reg_2 => \rows[1].cols[1].gol_cell_inst_n_1\,
      val_reg_3 => \rows[0].cols[5].gol_cell_inst_n_2\
    );
\rows[1].cols[1].gol_cell_inst\: entity work.GOL_cell_6
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      \GOL_outputs[2]\(2) => \GOL_outputs[2]\(5),
      \GOL_outputs[2]\(1 downto 0) => \GOL_outputs[2]\(1 downto 0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_1_in => p_1_in,
      p_4_in => p_4_in,
      p_5_in => p_5_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[1].cols[1].gol_cell_inst_n_1\,
      val_reg_1 => \rows[1].cols[1].gol_cell_inst_n_2\,
      val_reg_2 => \rows[1].cols[2].gol_cell_inst_n_1\,
      val_reg_3 => \rows[0].cols[0].gol_cell_inst_n_2\
    );
\rows[1].cols[2].gol_cell_inst\: entity work.GOL_cell_7
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      \GOL_outputs[2]\(2 downto 0) => \GOL_outputs[2]\(2 downto 0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_1_in => p_1_in,
      p_2_in => p_2_in,
      p_5_in => p_5_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[1].cols[2].gol_cell_inst_n_1\,
      val_reg_1 => \rows[1].cols[2].gol_cell_inst_n_2\,
      val_reg_2 => \rows[1].cols[3].gol_cell_inst_n_1\,
      val_reg_3 => \rows[0].cols[1].gol_cell_inst_n_2\
    );
\rows[1].cols[3].gol_cell_inst\: entity work.GOL_cell_8
     port map (
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      \GOL_outputs[2]\(2 downto 0) => \GOL_outputs[2]\(3 downto 1),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_1_in => p_1_in,
      p_2_in => p_2_in,
      p_3_in => p_3_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[1].cols[3].gol_cell_inst_n_1\,
      val_reg_1 => \rows[1].cols[3].gol_cell_inst_n_2\,
      val_reg_2 => \rows[1].cols[4].gol_cell_inst_n_1\,
      val_reg_3 => \rows[0].cols[2].gol_cell_inst_n_2\
    );
\rows[1].cols[4].gol_cell_inst\: entity work.GOL_cell_9
     port map (
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      \GOL_outputs[2]\(2 downto 0) => \GOL_outputs[2]\(4 downto 2),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_1_in => p_1_in,
      p_2_in => p_2_in,
      p_3_in => p_3_in,
      p_4_in => p_4_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[1].cols[4].gol_cell_inst_n_1\,
      val_reg_1 => \rows[1].cols[4].gol_cell_inst_n_2\,
      val_reg_2 => \rows[1].cols[5].gol_cell_inst_n_1\,
      val_reg_3 => \rows[0].cols[3].gol_cell_inst_n_2\
    );
\rows[1].cols[5].gol_cell_inst\: entity work.GOL_cell_10
     port map (
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      \GOL_outputs[2]\(2 downto 0) => \GOL_outputs[2]\(5 downto 3),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_2_in => p_2_in,
      p_3_in => p_3_in,
      p_4_in => p_4_in,
      p_5_in => p_5_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[1].cols[5].gol_cell_inst_n_1\,
      val_reg_1 => \rows[1].cols[5].gol_cell_inst_n_2\,
      val_reg_2 => \rows[1].cols[0].gol_cell_inst_n_1\,
      val_reg_3 => \rows[0].cols[4].gol_cell_inst_n_2\
    );
\rows[2].cols[0].gol_cell_inst\: entity work.GOL_cell_11
     port map (
      \GOL_outputs[2]\(0) => \GOL_outputs[2]\(0),
      \GOL_outputs[3]\(2 downto 1) => \GOL_outputs[3]\(5 downto 4),
      \GOL_outputs[3]\(0) => \GOL_outputs[3]\(0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_3_in => p_3_in,
      p_4_in => p_4_in,
      p_5_in => p_5_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[2].cols[0].gol_cell_inst_n_1\,
      val_reg_1 => \rows[2].cols[0].gol_cell_inst_n_2\,
      val_reg_2 => \rows[2].cols[1].gol_cell_inst_n_1\,
      val_reg_3(2 downto 1) => \GOL_outputs[2]\(5 downto 4),
      val_reg_3(0) => \GOL_outputs[2]\(1),
      val_reg_4 => \rows[1].cols[5].gol_cell_inst_n_2\
    );
\rows[2].cols[1].gol_cell_inst\: entity work.GOL_cell_12
     port map (
      \GOL_outputs[2]\(2) => \GOL_outputs[2]\(5),
      \GOL_outputs[2]\(1) => \GOL_outputs[2]\(2),
      \GOL_outputs[2]\(0) => \GOL_outputs[2]\(0),
      \GOL_outputs[3]\(2) => \GOL_outputs[3]\(5),
      \GOL_outputs[3]\(1 downto 0) => \GOL_outputs[3]\(1 downto 0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_4_in => p_4_in,
      p_5_in => p_5_in,
      rst_IBUF => rst_IBUF,
      val_reg_0(0) => \GOL_outputs[2]\(1),
      val_reg_1 => \rows[2].cols[1].gol_cell_inst_n_1\,
      val_reg_2 => \rows[2].cols[1].gol_cell_inst_n_2\,
      val_reg_3 => \rows[2].cols[2].gol_cell_inst_n_1\,
      val_reg_4 => \rows[1].cols[0].gol_cell_inst_n_2\
    );
\rows[2].cols[2].gol_cell_inst\: entity work.GOL_cell_13
     port map (
      \GOL_outputs[2]\(0) => \GOL_outputs[2]\(2),
      \GOL_outputs[3]\(2 downto 0) => \GOL_outputs[3]\(2 downto 0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_1_in => p_1_in,
      p_5_in => p_5_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[2].cols[2].gol_cell_inst_n_1\,
      val_reg_1 => \rows[2].cols[2].gol_cell_inst_n_2\,
      val_reg_2 => \rows[2].cols[3].gol_cell_inst_n_1\,
      val_reg_3(2) => \GOL_outputs[2]\(3),
      val_reg_3(1 downto 0) => \GOL_outputs[2]\(1 downto 0),
      val_reg_4 => \rows[1].cols[1].gol_cell_inst_n_2\
    );
\rows[2].cols[3].gol_cell_inst\: entity work.GOL_cell_14
     port map (
      \GOL_outputs[2]\(2) => \GOL_outputs[2]\(4),
      \GOL_outputs[2]\(1 downto 0) => \GOL_outputs[2]\(2 downto 1),
      \GOL_outputs[3]\(2 downto 0) => \GOL_outputs[3]\(3 downto 1),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_1_in => p_1_in,
      p_2_in => p_2_in,
      rst_IBUF => rst_IBUF,
      val_reg_0(0) => \GOL_outputs[2]\(3),
      val_reg_1 => \rows[2].cols[3].gol_cell_inst_n_1\,
      val_reg_2 => \rows[2].cols[3].gol_cell_inst_n_2\,
      val_reg_3 => \rows[2].cols[4].gol_cell_inst_n_1\,
      val_reg_4 => \rows[1].cols[2].gol_cell_inst_n_2\
    );
\rows[2].cols[4].gol_cell_inst\: entity work.GOL_cell_15
     port map (
      \GOL_outputs[2]\(0) => \GOL_outputs[2]\(4),
      \GOL_outputs[3]\(2 downto 0) => \GOL_outputs[3]\(4 downto 2),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_1_in => p_1_in,
      p_2_in => p_2_in,
      p_3_in => p_3_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[2].cols[4].gol_cell_inst_n_1\,
      val_reg_1 => \rows[2].cols[4].gol_cell_inst_n_2\,
      val_reg_2 => \rows[2].cols[5].gol_cell_inst_n_1\,
      val_reg_3(2) => \GOL_outputs[2]\(5),
      val_reg_3(1 downto 0) => \GOL_outputs[2]\(3 downto 2),
      val_reg_4 => \rows[1].cols[3].gol_cell_inst_n_2\
    );
\rows[2].cols[5].gol_cell_inst\: entity work.GOL_cell_16
     port map (
      \GOL_outputs[2]\(2 downto 1) => \GOL_outputs[2]\(4 downto 3),
      \GOL_outputs[2]\(0) => \GOL_outputs[2]\(0),
      \GOL_outputs[3]\(2 downto 0) => \GOL_outputs[3]\(5 downto 3),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_2_in => p_2_in,
      p_3_in => p_3_in,
      p_4_in => p_4_in,
      rst_IBUF => rst_IBUF,
      val_reg_0(0) => \GOL_outputs[2]\(5),
      val_reg_1 => \rows[2].cols[5].gol_cell_inst_n_1\,
      val_reg_2 => \rows[2].cols[5].gol_cell_inst_n_2\,
      val_reg_3 => \rows[2].cols[0].gol_cell_inst_n_1\,
      val_reg_4 => \rows[1].cols[4].gol_cell_inst_n_2\
    );
\rows[3].cols[0].gol_cell_inst\: entity work.GOL_cell_17
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[2]\(2 downto 1) => \GOL_outputs[2]\(5 downto 4),
      \GOL_outputs[2]\(0) => \GOL_outputs[2]\(0),
      \GOL_outputs[3]\(0) => \GOL_outputs[3]\(0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      \col[0]\ => \rows[3].cols[0].gol_cell_inst_n_2\,
      col_IBUF(0) => col_IBUF(0),
      p_0_out => p_0_out,
      p_1_out => p_1_out,
      p_5_in => p_5_in,
      p_5_out => p_5_out,
      row_IBUF(2 downto 0) => row_IBUF(2 downto 0),
      rst_IBUF => rst_IBUF,
      val_OBUF_inst_i_1(0) => \GOL_outputs[5]\(1),
      val_OBUF_inst_i_4_0 => \rows[5].cols[0].gol_cell_inst_n_3\,
      val_reg_0 => \rows[3].cols[0].gol_cell_inst_n_1\,
      val_reg_1 => \rows[3].cols[0].gol_cell_inst_n_3\,
      val_reg_2 => \rows[3].cols[1].gol_cell_inst_n_1\,
      val_reg_3(2 downto 1) => \GOL_outputs[3]\(5 downto 4),
      val_reg_3(0) => \GOL_outputs[3]\(1),
      val_reg_4 => \rows[2].cols[5].gol_cell_inst_n_2\
    );
\rows[3].cols[1].gol_cell_inst\: entity work.GOL_cell_18
     port map (
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[2]\(2) => \GOL_outputs[2]\(5),
      \GOL_outputs[2]\(1 downto 0) => \GOL_outputs[2]\(1 downto 0),
      \GOL_outputs[3]\(2) => \GOL_outputs[3]\(5),
      \GOL_outputs[3]\(1) => \GOL_outputs[3]\(2),
      \GOL_outputs[3]\(0) => \GOL_outputs[3]\(0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_in => p_0_in,
      p_0_out => p_0_out,
      p_4_out => p_4_out,
      p_5_out => p_5_out,
      \row[2]\(0) => \GOL_outputs[5]\(1),
      row_IBUF(2 downto 0) => row_IBUF(2 downto 0),
      rst_IBUF => rst_IBUF,
      val_OBUF_inst_i_4 => \rows[5].cols[1].gol_cell_inst_n_3\,
      val_reg_0(0) => \GOL_outputs[3]\(1),
      val_reg_1 => \rows[3].cols[1].gol_cell_inst_n_1\,
      val_reg_2 => \rows[3].cols[1].gol_cell_inst_n_2\,
      val_reg_3 => \rows[3].cols[2].gol_cell_inst_n_1\,
      val_reg_4 => \rows[2].cols[0].gol_cell_inst_n_2\
    );
\rows[3].cols[2].gol_cell_inst\: entity work.GOL_cell_19
     port map (
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      \GOL_outputs[2]\(2 downto 0) => \GOL_outputs[2]\(2 downto 0),
      \GOL_outputs[3]\(0) => \GOL_outputs[3]\(2),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      \col[0]\ => \rows[3].cols[2].gol_cell_inst_n_2\,
      col_IBUF(0) => col_IBUF(0),
      p_1_in => p_1_in,
      p_3_out => p_3_out,
      p_4_out => p_4_out,
      p_5_out => p_5_out,
      row_IBUF(2 downto 0) => row_IBUF(2 downto 0),
      rst_IBUF => rst_IBUF,
      val_OBUF_inst_i_1(0) => \GOL_outputs[5]\(3),
      val_OBUF_inst_i_3_0 => \rows[5].cols[2].gol_cell_inst_n_3\,
      val_reg_0 => \rows[3].cols[2].gol_cell_inst_n_1\,
      val_reg_1 => \rows[3].cols[2].gol_cell_inst_n_3\,
      val_reg_2 => \rows[3].cols[3].gol_cell_inst_n_1\,
      val_reg_3(2) => \GOL_outputs[3]\(3),
      val_reg_3(1 downto 0) => \GOL_outputs[3]\(1 downto 0),
      val_reg_4 => \rows[2].cols[1].gol_cell_inst_n_2\
    );
\rows[3].cols[3].gol_cell_inst\: entity work.GOL_cell_20
     port map (
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      \GOL_outputs[2]\(2 downto 0) => \GOL_outputs[2]\(3 downto 1),
      \GOL_outputs[3]\(2) => \GOL_outputs[3]\(4),
      \GOL_outputs[3]\(1 downto 0) => \GOL_outputs[3]\(2 downto 1),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_2_in => p_2_in,
      p_2_out => p_2_out,
      p_3_out => p_3_out,
      p_4_out => p_4_out,
      \row[2]\(0) => \GOL_outputs[5]\(3),
      row_IBUF(2 downto 0) => row_IBUF(2 downto 0),
      rst_IBUF => rst_IBUF,
      val_OBUF_inst_i_3 => \rows[5].cols[3].gol_cell_inst_n_3\,
      val_reg_0(0) => \GOL_outputs[3]\(3),
      val_reg_1 => \rows[3].cols[3].gol_cell_inst_n_1\,
      val_reg_2 => \rows[3].cols[3].gol_cell_inst_n_2\,
      val_reg_3 => \rows[3].cols[4].gol_cell_inst_n_1\,
      val_reg_4 => \rows[2].cols[2].gol_cell_inst_n_2\
    );
\rows[3].cols[4].gol_cell_inst\: entity work.GOL_cell_21
     port map (
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      \GOL_outputs[2]\(2 downto 0) => \GOL_outputs[2]\(4 downto 2),
      \GOL_outputs[3]\(0) => \GOL_outputs[3]\(4),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      col_IBUF(2 downto 0) => col_IBUF(2 downto 0),
      p_1_out => p_1_out,
      p_2_out => p_2_out,
      p_3_in => p_3_in,
      p_3_out => p_3_out,
      row_IBUF(2 downto 0) => row_IBUF(2 downto 0),
      rst_IBUF => rst_IBUF,
      val => \rows[3].cols[2].gol_cell_inst_n_2\,
      val_0 => \rows[3].cols[0].gol_cell_inst_n_2\,
      val_OBUF => val_OBUF,
      val_OBUF_inst_i_1_0(0) => \GOL_outputs[5]\(5),
      val_OBUF_inst_i_2_0 => \rows[5].cols[4].gol_cell_inst_n_3\,
      val_reg_0 => \rows[3].cols[4].gol_cell_inst_n_1\,
      val_reg_1 => \rows[3].cols[4].gol_cell_inst_n_3\,
      val_reg_2 => \rows[3].cols[5].gol_cell_inst_n_1\,
      val_reg_3(2) => \GOL_outputs[3]\(5),
      val_reg_3(1 downto 0) => \GOL_outputs[3]\(3 downto 2),
      val_reg_4 => \rows[2].cols[3].gol_cell_inst_n_2\
    );
\rows[3].cols[5].gol_cell_inst\: entity work.GOL_cell_22
     port map (
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      \GOL_outputs[2]\(2 downto 0) => \GOL_outputs[2]\(5 downto 3),
      \GOL_outputs[3]\(2 downto 1) => \GOL_outputs[3]\(4 downto 3),
      \GOL_outputs[3]\(0) => \GOL_outputs[3]\(0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_out => p_0_out,
      p_1_out => p_1_out,
      p_2_out => p_2_out,
      p_4_in => p_4_in,
      \row[2]\(0) => \GOL_outputs[5]\(5),
      row_IBUF(2 downto 0) => row_IBUF(2 downto 0),
      rst_IBUF => rst_IBUF,
      val_OBUF_inst_i_2 => \rows[5].cols[5].gol_cell_inst_n_3\,
      val_reg_0(0) => \GOL_outputs[3]\(5),
      val_reg_1 => \rows[3].cols[5].gol_cell_inst_n_1\,
      val_reg_2 => \rows[3].cols[5].gol_cell_inst_n_2\,
      val_reg_3 => \rows[3].cols[0].gol_cell_inst_n_1\,
      val_reg_4 => \rows[2].cols[4].gol_cell_inst_n_2\
    );
\rows[4].cols[0].gol_cell_inst\: entity work.GOL_cell_23
     port map (
      \GOL_outputs[3]\(2 downto 1) => \GOL_outputs[3]\(5 downto 4),
      \GOL_outputs[3]\(0) => \GOL_outputs[3]\(0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_out => p_0_out,
      p_10_in => p_10_in,
      p_11_in => p_11_in,
      p_1_out => p_1_out,
      p_4_out => p_4_out,
      p_5_out => p_5_out,
      p_9_in => p_9_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[4].cols[0].gol_cell_inst_n_1\,
      val_reg_1 => \rows[4].cols[0].gol_cell_inst_n_2\,
      val_reg_2 => \rows[4].cols[1].gol_cell_inst_n_1\,
      val_reg_3 => \rows[3].cols[5].gol_cell_inst_n_2\
    );
\rows[4].cols[1].gol_cell_inst\: entity work.GOL_cell_24
     port map (
      \GOL_outputs[3]\(2) => \GOL_outputs[3]\(5),
      \GOL_outputs[3]\(1 downto 0) => \GOL_outputs[3]\(1 downto 0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_out => p_0_out,
      p_10_in => p_10_in,
      p_11_in => p_11_in,
      p_3_out => p_3_out,
      p_4_out => p_4_out,
      p_5_out => p_5_out,
      p_6_in => p_6_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[4].cols[1].gol_cell_inst_n_1\,
      val_reg_1 => \rows[4].cols[1].gol_cell_inst_n_2\,
      val_reg_2 => \rows[4].cols[2].gol_cell_inst_n_1\,
      val_reg_3 => \rows[3].cols[0].gol_cell_inst_n_3\
    );
\rows[4].cols[2].gol_cell_inst\: entity work.GOL_cell_25
     port map (
      \GOL_outputs[3]\(2 downto 0) => \GOL_outputs[3]\(2 downto 0),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_11_in => p_11_in,
      p_2_out => p_2_out,
      p_3_out => p_3_out,
      p_4_out => p_4_out,
      p_5_out => p_5_out,
      p_6_in => p_6_in,
      p_7_in => p_7_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[4].cols[2].gol_cell_inst_n_1\,
      val_reg_1 => \rows[4].cols[2].gol_cell_inst_n_2\,
      val_reg_2 => \rows[4].cols[3].gol_cell_inst_n_1\,
      val_reg_3 => \rows[3].cols[1].gol_cell_inst_n_2\
    );
\rows[4].cols[3].gol_cell_inst\: entity work.GOL_cell_26
     port map (
      \GOL_outputs[3]\(2 downto 0) => \GOL_outputs[3]\(3 downto 1),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_1_out => p_1_out,
      p_2_out => p_2_out,
      p_3_out => p_3_out,
      p_4_out => p_4_out,
      p_6_in => p_6_in,
      p_7_in => p_7_in,
      p_8_in => p_8_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[4].cols[3].gol_cell_inst_n_1\,
      val_reg_1 => \rows[4].cols[3].gol_cell_inst_n_2\,
      val_reg_2 => \rows[4].cols[4].gol_cell_inst_n_1\,
      val_reg_3 => \rows[3].cols[2].gol_cell_inst_n_3\
    );
\rows[4].cols[4].gol_cell_inst\: entity work.GOL_cell_27
     port map (
      \GOL_outputs[3]\(2 downto 0) => \GOL_outputs[3]\(4 downto 2),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_out => p_0_out,
      p_1_out => p_1_out,
      p_2_out => p_2_out,
      p_3_out => p_3_out,
      p_7_in => p_7_in,
      p_8_in => p_8_in,
      p_9_in => p_9_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[4].cols[4].gol_cell_inst_n_1\,
      val_reg_1 => \rows[4].cols[4].gol_cell_inst_n_2\,
      val_reg_2 => \rows[4].cols[5].gol_cell_inst_n_1\,
      val_reg_3 => \rows[3].cols[3].gol_cell_inst_n_2\
    );
\rows[4].cols[5].gol_cell_inst\: entity work.GOL_cell_28
     port map (
      \GOL_outputs[3]\(2 downto 0) => \GOL_outputs[3]\(5 downto 3),
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_out => p_0_out,
      p_10_in => p_10_in,
      p_1_out => p_1_out,
      p_2_out => p_2_out,
      p_5_out => p_5_out,
      p_8_in => p_8_in,
      p_9_in => p_9_in,
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[4].cols[5].gol_cell_inst_n_1\,
      val_reg_1 => \rows[4].cols[5].gol_cell_inst_n_2\,
      val_reg_2 => \rows[4].cols[0].gol_cell_inst_n_1\,
      val_reg_3 => \rows[3].cols[4].gol_cell_inst_n_3\
    );
\rows[5].cols[0].gol_cell_inst\: entity work.GOL_cell_29
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_out => p_0_out,
      p_10_in => p_10_in,
      p_11_in => p_11_in,
      p_1_out => p_1_out,
      p_5_out => p_5_out,
      p_6_in => p_6_in,
      p_9_in => p_9_in,
      row_IBUF(0) => row_IBUF(0),
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[5].cols[0].gol_cell_inst_n_1\,
      val_reg_1 => \rows[5].cols[0].gol_cell_inst_n_2\,
      val_reg_2 => \rows[5].cols[0].gol_cell_inst_n_3\,
      val_reg_3 => \rows[5].cols[1].gol_cell_inst_n_1\,
      val_reg_4 => \rows[4].cols[5].gol_cell_inst_n_2\
    );
\rows[5].cols[1].gol_cell_inst\: entity work.GOL_cell_30
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_out => p_0_out,
      p_10_in => p_10_in,
      p_11_in => p_11_in,
      p_4_out => p_4_out,
      p_5_out => p_5_out,
      p_6_in => p_6_in,
      p_7_in => p_7_in,
      row_IBUF(0) => row_IBUF(0),
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[5].cols[1].gol_cell_inst_n_1\,
      val_reg_1 => \rows[5].cols[1].gol_cell_inst_n_2\,
      val_reg_2 => \rows[5].cols[1].gol_cell_inst_n_3\,
      val_reg_3 => \rows[5].cols[2].gol_cell_inst_n_1\,
      val_reg_4 => \rows[4].cols[0].gol_cell_inst_n_2\
    );
\rows[5].cols[2].gol_cell_inst\: entity work.GOL_cell_31
     port map (
      \GOL_outputs[0]_0\ => \GOL_outputs[0]_0\,
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_11_in => p_11_in,
      p_3_out => p_3_out,
      p_4_out => p_4_out,
      p_5_out => p_5_out,
      p_6_in => p_6_in,
      p_7_in => p_7_in,
      p_8_in => p_8_in,
      row_IBUF(0) => row_IBUF(0),
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[5].cols[2].gol_cell_inst_n_1\,
      val_reg_1 => \rows[5].cols[2].gol_cell_inst_n_2\,
      val_reg_2 => \rows[5].cols[2].gol_cell_inst_n_3\,
      val_reg_3 => \rows[5].cols[3].gol_cell_inst_n_1\,
      val_reg_4 => \rows[4].cols[1].gol_cell_inst_n_2\
    );
\rows[5].cols[3].gol_cell_inst\: entity work.GOL_cell_32
     port map (
      \GOL_outputs[0]_1\ => \GOL_outputs[0]_1\,
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_2_out => p_2_out,
      p_3_out => p_3_out,
      p_4_out => p_4_out,
      p_6_in => p_6_in,
      p_7_in => p_7_in,
      p_8_in => p_8_in,
      p_9_in => p_9_in,
      row_IBUF(0) => row_IBUF(0),
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[5].cols[3].gol_cell_inst_n_1\,
      val_reg_1 => \rows[5].cols[3].gol_cell_inst_n_2\,
      val_reg_2 => \rows[5].cols[3].gol_cell_inst_n_3\,
      val_reg_3 => \rows[5].cols[4].gol_cell_inst_n_1\,
      val_reg_4 => \rows[4].cols[2].gol_cell_inst_n_2\
    );
\rows[5].cols[4].gol_cell_inst\: entity work.GOL_cell_33
     port map (
      \GOL_outputs[0]_2\ => \GOL_outputs[0]_2\,
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_10_in => p_10_in,
      p_1_out => p_1_out,
      p_2_out => p_2_out,
      p_3_out => p_3_out,
      p_7_in => p_7_in,
      p_8_in => p_8_in,
      p_9_in => p_9_in,
      row_IBUF(0) => row_IBUF(0),
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[5].cols[4].gol_cell_inst_n_1\,
      val_reg_1 => \rows[5].cols[4].gol_cell_inst_n_2\,
      val_reg_2 => \rows[5].cols[4].gol_cell_inst_n_3\,
      val_reg_3 => \rows[5].cols[5].gol_cell_inst_n_1\,
      val_reg_4 => \rows[4].cols[3].gol_cell_inst_n_2\
    );
\rows[5].cols[5].gol_cell_inst\: entity work.GOL_cell_34
     port map (
      \GOL_outputs[0]_3\ => \GOL_outputs[0]_3\,
      \GOL_outputs[0]_4\ => \GOL_outputs[0]_4\,
      \GOL_outputs[0]_5\ => \GOL_outputs[0]_5\,
      clk_IBUF_BUFG => clk_IBUF_BUFG,
      p_0_out => p_0_out,
      p_10_in => p_10_in,
      p_11_in => p_11_in,
      p_1_out => p_1_out,
      p_2_out => p_2_out,
      p_8_in => p_8_in,
      p_9_in => p_9_in,
      row_IBUF(0) => row_IBUF(0),
      rst_IBUF => rst_IBUF,
      val_reg_0 => \rows[5].cols[5].gol_cell_inst_n_1\,
      val_reg_1 => \rows[5].cols[5].gol_cell_inst_n_2\,
      val_reg_2 => \rows[5].cols[5].gol_cell_inst_n_3\,
      val_reg_3 => \rows[5].cols[0].gol_cell_inst_n_1\,
      val_reg_4 => \rows[4].cols[4].gol_cell_inst_n_2\
    );
rst_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => rst,
      O => rst_IBUF
    );
val_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => val_OBUF,
      O => val
    );
end STRUCTURE;

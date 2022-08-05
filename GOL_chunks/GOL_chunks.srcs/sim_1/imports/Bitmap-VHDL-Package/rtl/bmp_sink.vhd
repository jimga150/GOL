-------------------------------------------------------------------------------
-- File       : bmp_sink.vhd
-- Author     : mr-kenhoff
-------------------------------------------------------------------------------
-- Description:
--      Takes a data stream and saves it to a bitmap image

-- Target: Simulator
-- Dependencies: bmp_pkg.vhd
-------------------------------------------------------------------------------
--MIT License

--Copyright (c) 2017 mr-kenhoff

--Permission is hereby granted, free of charge, to any person obtaining a copy
--of this software and associated documentation files (the "Software"), to deal
--in the Software without restriction, including without limitation the rights
--to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--copies of the Software, and to permit persons to whom the Software is
--furnished to do so, subject to the following conditions:

--The above copyright notice and this permission notice shall be included in all
--copies or substantial portions of the Software.

--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--SOFTWARE.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.bmp_pkg.all;

entity bmp_sink is
    generic (
        FILENAME    : string;
        SEQUENCE    : string := "TRUE"
    );
    port (
        clk_i       : in    std_logic;
        rst_i       : in    std_logic;

        val_i       : in    std_logic;
        dat_i       : in    std_logic_vector(23 downto 0);
        rdy_o       : out   std_logic := '1';
        eol_i       : in    std_logic;
        eof_i       : in    std_logic;

        halt_i      : in    std_logic
    );
end entity;

architecture behavioural of bmp_sink is

    signal x    : natural := 0;
    signal y    : natural := 0;
    signal iteration    : integer := 0;

begin

    rdy_o <= not halt_i when rising_edge(clk_i);



    sink_process : process( clk_i )
        variable sink_bmp : bmp_ptr;
        variable sink_pix : bmp_pix;
        variable is_bmp_created : boolean := false;
        variable is_bmp_saved : boolean := false;
    begin

        -- Create bitmap on startup
        if is_bmp_created = false then
            sink_bmp := new bmp;
            is_bmp_created := true;
        end if;

        if rising_edge( clk_i ) then
            if rst_i = '1' then
                x <= 0;
                y <= 0;
            else
                if val_i = '1' and halt_i = '0' then
                    sink_pix.r := dat_i(23 downto 16);
                    sink_pix.g := dat_i(15 downto 8);
                    sink_pix.b := dat_i(7 downto 0);
                    
                    bmp_set_pix( sink_bmp, x, y, sink_pix );
                    
                    if eol_i = '1' then
                        x <= 0;
                        if eof_i = '1' then
                            y <= 0;
                            -- Frame completed. Save to bitmap..
                            if SEQUENCE = "FALSE" then
                                if is_bmp_saved = false then
                                    bmp_save( sink_bmp, FILENAME & ".bmp" );
                                    is_bmp_saved := true;
                                end if;
                            elsif SEQUENCE = "TRUE" then
                                bmp_save( sink_bmp, FILENAME & "_" & INTEGER'IMAGE(iteration) & ".bmp" );
                                is_bmp_saved := true;
                            end if;
                            iteration <= iteration + 1;
                        else
                            y <= y + 1;
                        end if;
                    else
                        x <= x + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;


end architecture;


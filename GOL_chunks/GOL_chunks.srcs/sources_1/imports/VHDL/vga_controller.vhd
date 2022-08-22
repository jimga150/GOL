--------------------------------------------------------------------------------
--
--   FileName:         vga_controller.vhd
--   Dependencies:     none
--   Design Software:  Quartus II 64-bit Version 12.1 Build 177 SJ Full Version
--
--   HDL CODE IS PROVIDED "AS IS."  DIGI-KEY EXPRESSLY DISCLAIMS ANY
--   WARRANTY OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
--   PARTICULAR PURPOSE, OR NON-INFRINGEMENT. IN NO EVENT SHALL DIGI-KEY
--   BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR CONSEQUENTIAL
--   DAMAGES, LOST PROFITS OR LOST DATA, HARM TO YOUR EQUIPMENT, COST OF
--   PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
--   BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF),
--   ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER SIMILAR COSTS.
--
--   Version History
--   Version 1.0 05/10/2013 Scott Larson
--     Initial Public Release
--   Version 1.1 03/07/2018 Scott Larson
--     Corrected two minor "off-by-one" errors
--    
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity vga_controller is
    generic(
        h_pixels	:	integer := 1680;		--horiztonal display width in pixels
        h_fp	 	:	integer := 104;		--horiztonal front porch width in pixels
        h_pulse 	:	integer := 184;    	--horiztonal sync pulse width in pixels --TODO: g
        h_bp	 	:	integer := 288;		--horiztonal back porch width in pixels
        h_pol		:	std_logic := '0';		--horizontal sync pulse polarity (1 = positive, 0 = negative)
        v_pixels	:	integer := 1050;		--vertical display width in rows
        v_fp	 	:	integer := 1;			--vertical front porch width in rows
        v_pulse 	:	integer := 3;			--vertical sync pulse width in rows
        v_bp	 	:	integer := 33;			--vertical back porch width in rows
        v_pol		:	std_logic := '1'   --vertical sync pulse polarity (1 = positive, 0 = negative)
    );	
    port(
        pixel_clk	:	in		std_logic;	--pixel clock at frequency of VGA mode being used
        reset_n		:	in		std_logic;	--active low asycnchronous reset
        h_sync		:	out	std_logic;	--horiztonal sync pulse
        v_sync		:	out	std_logic;	--vertical sync pulse
        disp_ena	:	out	std_logic;	--display enable ('1' = display time, '0' = blanking time)
        column		:	out	integer range 0 to h_pixels - 1;		--horizontal pixel coordinate
        row			:	out	integer range 0 to v_pixels - 1;		--vertical pixel coordinate
        n_blank		:	out	std_logic;	--direct blacking output to DAC
        n_sync		:	out	std_logic     --sync-on-green output to DAC
    ); 
end vga_controller;

architecture behavior of vga_controller is
    constant c_h_period	: integer := h_pulse + h_bp + h_pixels + h_fp;  --total number of pixel clocks in a row
    constant c_v_period	: integer := v_pulse + v_bp + v_pixels + v_fp;  --total number of rows in column
    
    signal s_h_count : integer range 0 to c_h_period - 1 := 0;  --horizontal counter (counts the columns)
    signal s_v_count : integer range 0 to c_v_period - 1 := 0;  --vertical counter (counts the rows)
    
    --high on the cycle where s_h_count = c_h_period - 1
    signal s_h_count_is_max : std_logic := '0';
    signal s_v_count_is_max : std_logic := '0';
    
    signal s1_h_sync : std_logic := '0';
    signal s1_v_sync : std_logic := '0';
    
    signal s1_h_active : std_logic := '0';
    signal s1_v_active : std_logic := '0';
    
    signal s2_h_sync : std_logic := '0';
    signal s2_v_sync : std_logic := '0';
    
    signal s2_col : integer range 0 to h_pixels - 1 := 0;
    signal s2_row : integer range 0 to v_pixels - 1 := 0;
    
    signal s2_disp_en : std_logic := '0';
    
begin

    h_sync <= s2_h_sync;
    v_sync <= s2_v_sync;
    
    disp_ena <= s2_disp_en;
    
    column <= s2_col;
    row <= s2_row;
    
    n_blank <= '1';  --no direct blanking
    n_sync <= '0';   --no sync on green
    
    process(pixel_clk) is begin
        if (rising_edge(pixel_clk)) then
            
            s_h_count <= s_h_count + 1;
            
            s_h_count_is_max <= '0';
            if (s_h_count = c_h_period - 2) then
                s_h_count_is_max <= '1';
            end if;
            
            if (s_h_count_is_max = '1') then
            
                s_h_count <= 0;
                
                s_v_count <= s_v_count + 1;
                
                s_v_count_is_max <= '0';
                if (s_v_count = c_v_period - 2) then
                    s_v_count_is_max <= '1';
                end if;
                
                if (s_v_count_is_max = '1') then
                    s_v_count <= 0;
                end if;
            end if;
                   
            
            if (s_h_count = h_pixels - 1) then
                s1_h_active <= '0'; --TODO: s1 is actually s0
            end if;
            
            if (s_h_count = h_pixels + h_fp - 1) then
                s1_h_sync <= h_pol;
            end if;
            
            if (s_h_count = h_pixels + h_fp + h_pulse - 1) then
                s1_h_sync <= not h_pol;
            end if;
            
            if (s_h_count_is_max = '1') then
            
                s1_h_active <= '1';
                
                if (s_v_count = v_pixels - 1) then
                    s1_v_active <= '0';
                end if;
                
                if (s_v_count = v_pixels + v_fp - 1) then
                    s1_v_sync <= v_pol;
                end if;
                
                if (s_v_count = v_pixels + v_fp + v_pulse - 1) then
                    s1_v_sync <= not v_pol;
                end if;
                
                if (s_v_count_is_max = '1') then
                    s1_v_active <= '1';
                end if;
                
            end if;
            
            
            s2_h_sync <= s1_h_sync;
            s2_v_sync <= s1_v_sync;
            
            if (s1_h_active = '1') then
                s2_col <= s_h_count;
            end if;
            
            if (s1_v_active = '1') then
                s2_row <= s_v_count;
            end if;
            
            s2_disp_en <= s1_v_active and s1_h_active;
            
            
            if(reset_n = '0') then
            
                s_h_count <= 0;
                s_v_count <= 0;
                
                s_h_count_is_max <= '0';
                s_v_count_is_max <= '0';
                
                s1_h_sync <= not h_pol;
                s1_v_sync <= not v_pol;
                s1_h_active <= '0';
                s1_v_active <= '0';
                
                s2_h_sync <= not h_pol;
                s2_v_sync <= not v_pol;
                s2_col <= 0;
                s2_row <= 0;
                s2_disp_en <= '0';
                
            end if;
            
        end if;
    end process;
    
end behavior;

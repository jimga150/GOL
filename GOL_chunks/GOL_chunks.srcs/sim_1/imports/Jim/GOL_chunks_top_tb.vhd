----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/16/2022 17:40:00
-- Design Name: GOL_chunks_top_tb
-- Module Name: GOL_chunks_top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: Created with VHDL Test Bench Template Generator
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.GOL_pkg.all;
use work.bmp_pkg.all;

entity GOL_chunks_top_tb is
end GOL_chunks_top_tb;

architecture Behavioral of GOL_chunks_top_tb is
    
    --Clocks
    signal i_clk_100mhz : std_logic := '0';
    
    --Resets
    signal i_rst_btn : std_logic := '1';
    
    --Inputs
    signal i_frame_go_btn : std_logic := '1';
    signal i_frame_step_btn : std_logic := '0';
    
    --Outputs
    signal o_h_sync : std_logic;
    signal o_v_sync : std_logic;
    signal o_pixel_slv : std_logic_vector(11 downto 0);
    
    --Clock Periods
    constant i_clk_100mhz_period : time := 10 ns;
    
    constant c_num_frames : integer := 100;
    
    signal s_r : integer;
    signal s_c : integer;
    
    signal s_vga_clk : std_logic;
    
begin
    
    UUT: entity work.GOL_chunks_top
    port map(
        i_clk_100mhz => i_clk_100mhz,
        i_rst_btn => i_rst_btn,
        o_vga_clk => s_vga_clk,
        i_frame_go_btn => i_frame_go_btn,
        i_frame_step_btn => i_frame_step_btn,
        o_h_sync => o_h_sync,
        o_v_sync => o_v_sync,
        o_pixel_slv => o_pixel_slv
    );
    
    --Clock Drivers
    i_clk_100mhz <= not i_clk_100mhz after i_clk_100mhz_period/2;
    
    stim_proc: process is
        --copied from vga_controller.vhd
        constant c_h_pulse 	:	INTEGER := 184;    	--horiztonal sync pulse width in pixels
		constant c_h_bp	 	:	INTEGER := 288;		--horiztonal back porch width in pixels
		constant c_h_pixels	:	INTEGER := 1680;		--horiztonal display width in pixels
		constant c_h_fp	 	:	INTEGER := 104;		--horiztonal front porch width in pixels
		constant c_h_pol	:	STD_LOGIC := '0';		--horizontal sync pulse polarity (1 = positive, 0 = negative)
		constant c_v_pulse 	:	INTEGER := 3;			--vertical sync pulse width in rows
		constant c_v_bp	 	:	INTEGER := 33;			--vertical back porch width in rows
		constant c_v_pixels	:	INTEGER := 1050;		--vertical display width in rows
		constant c_v_fp	 	:	INTEGER := 1;			--vertical front porch width in rows
		constant c_v_pol	:	STD_LOGIC := '1';	--vertical sync pulse polarity (1 = positive, 0 = negative)
		
		constant c_h_line_cycles : integer := c_h_pulse + c_h_bp + c_h_pixels + c_h_fp;
		constant c_v_line_cycles : integer := c_v_pulse + c_v_bp + c_v_pixels + c_v_fp;
		constant c_v_pulse_cycles : integer := c_v_pulse*c_h_line_cycles;
		constant c_v_bp_cycles : integer := c_v_bp*c_h_line_cycles;
		constant c_v_pixels_cycles : integer := c_v_pixels*c_h_line_cycles;
		constant c_v_fp_cycles : integer := c_v_fp*c_h_line_cycles;
		
        variable v_bmp_ptr : bmp_ptr := new bmp;
        variable v_bmp_is_init : boolean := false;
        constant c_bmp_pix_0 : bmp_pix := (others => (others => '0'));
        constant c_bmp_pix_1 : bmp_pix := (others => (others => '1'));
        variable v_bmp_pix : bmp_pix;
        
    begin
    
        if (not v_bmp_is_init) then
            v_bmp_ptr.meta.width := c_field_num_cell_cols;
            v_bmp_ptr.meta.height := c_field_num_cell_rows;
            v_bmp_is_init := true;
        end if;
        
        wait for 1100 us;
        
        i_rst_btn <= '0';
                
        --Insert stimuli here
        for i in 0 to c_num_frames loop
        
            
            if (i = 3) then
                i_frame_go_btn <= '0';
            end if;
            
            if (i = 4) then
                i_frame_step_btn <= '1';
            end if;
            
            if (i = 5) then
                i_frame_go_btn <= '1';
                i_frame_step_btn <= '0';
            end if;
        
            wait until o_v_sync = c_v_pol;
            
            for cnt in 1 to c_v_pulse_cycles loop
                wait until falling_edge(s_vga_clk);
            end loop;
            for cnt in 1 to c_v_bp_cycles loop
                wait until falling_edge(s_vga_clk);
            end loop;
            
            for r in 0 to c_v_pixels-1 loop
            
                s_r <= r;
                                
                for c in 0 to c_h_pixels-1 loop
                
                    s_c <= c;
                
                    v_bmp_pix := c_bmp_pix_0;
                    if (o_pixel_slv(0) = '1') then 
                        v_bmp_pix := c_bmp_pix_1;
                    end if;
                    bmp_set_pix(v_bmp_ptr, c, r, v_bmp_pix);
                    
                    wait until falling_edge(s_vga_clk);
                    
                end loop;
                
                wait until o_h_sync = c_h_pol;

                for cnt in 1 to c_h_pulse loop
                    wait until falling_edge(s_vga_clk);
                end loop;
                for cnt in 1 to c_h_bp loop
                    wait until falling_edge(s_vga_clk);
                end loop;
                
            end loop;
            
            bmp_save(v_bmp_ptr, c_project_path & "\GOL_steps\GOL_step_" & integer'image(i) & ".bmp");
            
        end loop;
        
        assert false report "End Simulation" severity failure;
        
        -- Not strictly necessary, but prevents process from looping 
        -- if the above assert statement is removed
        wait;
        
    end process;
    
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/02/2020 12:05:53 PM
-- Design Name: 
-- Module Name: GOL_top - Structural
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

entity GOL_top is
    port(
        sys_clk_100mhz, sys_arstn : in std_logic;
        
        cs, mosi, sclk : out std_logic;
        cd, miso : in std_logic;
        
--        hsync, vsync : out std_logic;
--        pixel_vect_out : out std_logic_vector(11 downto 0);
        
        sd_read_done, sd_error, sd_busy, sd_reset : out std_logic;
        sd_error_code : out std_logic_vector(7 downto 0)
    );
end GOL_top;

architecture Structural of GOL_top is

    signal arst : std_logic;

    signal clk_100mhz, sd_clk_50mhz, pixel_clk, vga_arstn, vga_rst, sd_rst, sys_rst : std_logic;
    signal vga_arstn_vect, vga_rst_vect, sd_rst_vect, sys_rst_vect : std_logic_vector(0 downto 0);
    
    signal sd_aw_addr, sd_aw_addr_wordaligned, sd_wd_data, vga_ar_addr, vga_ar_addr_wordaligned, vga_rd_data : std_logic_vector(31 downto 0);
    signal sd_aw_ready, sd_aw_valid, sd_wr_ready, sd_wr_valid, sd_wd_ready, sd_wd_valid : std_logic;
    signal vga_ar_ready, vga_ar_valid, vga_rd_ready, vga_rd_valid : std_logic;
    signal sd_wr_resp : std_logic_vector(1 downto 0);
        
    signal sd_rd_mult, sd_data_valid, sd_data_ready : std_logic;
    signal sd_data : std_logic_vector(7 downto 0);
    signal sd_block_addr : std_logic_vector(31 downto 0);
    
    signal pixel : std_logic;

begin

    arst <= not sys_arstn;
    sd_reset <= arst;

    vga_arstn <= vga_arstn_vect(0);
    vga_rst <= vga_rst_vect(0);
    sd_rst <= sd_rst_vect(0);
    sys_rst <= sys_rst_vect(0);
    
    sd_aw_addr_wordaligned(31 downto 2) <= sd_aw_addr(29 downto 0);
    sd_aw_addr_wordaligned(1 downto 0) <= (others => '0');
    
    vga_ar_addr_wordaligned(31 downto 2) <= vga_ar_addr(29 downto 0);
    vga_ar_addr_wordaligned(1 downto 0) <= (others => '0');

    tri_axi_mem: entity work.BRAM_AXI_MULT_wrapper
    port map(
        sys_clock => sys_clk_100mhz,
        reset => sys_arstn,
        
        clk_100mhz_out => clk_100mhz,
        clk_50mhz_out => sd_clk_50mhz,
        pixel_clk_out => pixel_clk,
        
        vga_arstn => vga_arstn_vect,
        vga_rst => vga_rst_vect,
        sd_rst => sd_rst_vect,
        sys_rst => sys_rst_vect,
        
        S_AXI_0_awaddr => sd_aw_addr_wordaligned,
        S_AXI_0_awready => sd_aw_ready,
        S_AXI_0_awvalid => sd_aw_valid,
        
        S_AXI_0_bresp => sd_wr_resp,
        S_AXI_0_bready => sd_wr_ready,
        S_AXI_0_bvalid => sd_wr_valid,
        
        S_AXI_0_wdata => sd_wd_data,
        S_AXI_0_wready => sd_wd_ready,
        S_AXI_0_wvalid => sd_wd_valid,
        
        
        S_AXI_1_araddr => vga_ar_addr_wordaligned,
        S_AXI_1_arready => vga_ar_ready,
        S_AXI_1_arvalid => vga_ar_valid,
        
        S_AXI_1_rdata => vga_rd_data,
        S_AXI_1_rready => vga_rd_ready,
        S_AXI_1_rvalid => vga_rd_valid
    );
    
    sd_controller: entity work.sd_controller_sy2002
    port map(
        clk => sd_clk_50mhz,
        reset => arst,
        card_present => cd,
        
        cs => cs,
        miso => miso,
        mosi => mosi,
        sclk => sclk,
        
        rd_multiple => sd_rd_mult,
        dout => sd_data,
        dout_avail => sd_data_valid,
        dout_taken => sd_data_ready,
        
        addr => sd_block_addr,
        
        sd_error => sd_error,
        sd_busy => sd_busy,
        sd_error_code => sd_error_code
    );
    
    sd_sm : entity work.sd_readout
    port map(
        clk => sd_clk_50mhz,
        rst => sd_rst,
        
        sd_rd_multiple => sd_rd_mult, 
        sd_ready => sd_data_ready,
        sd_error => '0',
        sd_valid => sd_data_valid,
        sd_din => sd_data,
        sd_block_addr => sd_block_addr,
        
        wa_addr => sd_aw_addr,
        wa_valid => sd_aw_valid,
        wa_ready => sd_aw_ready,
        
        wd_data => sd_wd_data,
        wd_valid => sd_wd_valid,
        wd_ready => sd_wd_ready,
        
        wr_resp => sd_wr_resp,
        wr_ready => sd_wr_ready,
        wr_valid => sd_wr_valid,
        
        done_flag => sd_read_done
    );
    
--    readout_module: entity work.GOL_readout_module
--    port map(
--        clk_100mhz => clk_100mhz,
--        pixel_clk => pixel_clk,
--        rst_100mhz => sys_rst,
--        vga_arstn => vga_arstn,
        
--        frame_parity => '0',
        
--        ar_valid => vga_ar_valid,
--        ar_ready => vga_ar_ready,
--        ar_addr => vga_ar_addr,
        
--        rd_valid => vga_rd_valid,
--        rd_ready => vga_rd_ready,
--        rd_data => vga_rd_data,
        
--        h_sync => hsync, 
--        v_sync => vsync, 
--        pixel => pixel
--    );
    
--    pixel_vect_connect: for i in 0 to 11 generate
--        pixel_vect_out(i) <= pixel;
--    end generate;

end Structural;

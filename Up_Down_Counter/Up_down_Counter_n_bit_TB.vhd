----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2025 21:28:10
-- Design Name: 
-- Module Name: Up_down_Counter_n_bit_TB - Behavioral
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

entity Up_down_Counter_n_bit_TB is
--  Port ( );
end Up_down_Counter_n_bit_TB;

architecture Behavioral of Up_down_Counter_n_bit_TB is

    -- Component Declaration
    component Up_down_Counter_n_bit is
        generic(
            WIDTH: Natural := 8
        );
        Port (
            clk       : in  STD_LOGIC;
            rst       : in  STD_LOGIC;
            en        : in  STD_LOGIC;
            dir       : in  STD_LOGIC;
            count_out : out STD_LOGIC_VECTOR ((WIDTH-1) downto 0)
        );
    end component;

    -- Signals
    constant WIDTH : natural := 4;
    signal clk       : STD_LOGIC := '0';
    signal rst       : STD_LOGIC := '0';
    signal en        : STD_LOGIC := '0';
    signal dir       : STD_LOGIC := '0';
    signal count_out : STD_LOGIC_VECTOR ((WIDTH-1) downto 0);

begin

    -- Instantiate the counter
    uut: Up_down_Counter_n_bit
        generic map ( WIDTH => WIDTH )
        port map (
            clk       => clk,
            rst       => rst,
            en        => en,
            dir       => dir,
            count_out => count_out
        );

    -- Clock generation: 10ns period
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Test process
    stim_proc: process
    begin
        -- Initial reset
        rst <= '1';
        en <= '0';
        wait for 10 ns;
        rst <= '0';

        -- Count up
        en <= '1';
        dir <= '0'; -- up
        wait for 100 ns;

        -- Hold
        en <= '0';
        wait for 40 ns;

        -- Count down
        en <= '1';
        dir <= '1'; -- down
        wait for 70 ns;
        
         -- Hold
        en <= '0';
        wait for 40 ns;
        
        -- Reset again
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        -- Final count up
        en <=  '1';
        dir <= '0';
        wait for 150 ns;

        wait;
    end process;

end Behavioral;
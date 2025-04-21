----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2025 21:04:24
-- Design Name: 
-- Module Name: Up_down_Counter_n_bit - Behavioral
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

entity Up_down_Counter_n_bit is
    generic(
        WIDTH: Natural := 8
    );
    Port ( clk       : in STD_LOGIC;
           rst       : in STD_LOGIC;
           en        : in STD_LOGIC;
           dir       : in STD_LOGIC;
           count_out : out STD_LOGIC_VECTOR ((WIDTH-1) downto 0));
end Up_down_Counter_n_bit;

architecture Behavioral of Up_down_Counter_n_bit is
signal count_reg : unsigned ((WIDTH-1) downto 0);
begin

count_proc: process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            count_reg <= (others => '0');
        elsif en = '1' then
            case dir is
               when '0' => count_reg <= count_reg + 1;
               when '1' => count_reg <= count_reg - 1;
               when others => count_reg <= (others => '0');
            end case;
        end if;
    end if;
end process count_proc;
count_out <= std_logic_vector(count_reg);
end Behavioral;

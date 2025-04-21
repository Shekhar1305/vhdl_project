----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2025 22:23:09
-- Design Name: 
-- Module Name: shift_reg_n_bit - Behavioral
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

entity uni_shift_reg_n_bit is
 generic ( N : integer := 4 );
  port (
    clk           : in  std_logic;
    rst           : in  std_logic;
    en            : in  std_logic;
    load          : in  std_logic;
    dir           : in  std_logic;
    ser_data_in   : in  std_logic;
    load_data     : in  std_logic_vector(N-1 downto 0);
    ser_data_out  : out std_logic;
    par_data_out  : out std_logic_vector(N-1 downto 0)
  );
end uni_shift_reg_n_bit;

architecture Behavioral of uni_shift_reg_n_bit is
signal int_reg : std_logic_vector(N-1 downto 0);
begin

shift_proc: process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            int_reg <= (others => '0');
        elsif en = '1' then
            if load = '1' then
                int_reg <= load_data;
            else
                if dir = '0' then
                    int_reg <= int_reg(N-2 downto 0) & ser_data_in;
                else
                    int_reg <= ser_data_in & int_reg(N-1 downto 1);
                end if;
            end if;
        end if;
   end if;
end process shift_proc;
par_data_out <= int_reg;
ser_data_out <= int_reg(N-1) when dir = '0' else int_reg(0);
end Behavioral;

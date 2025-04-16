----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2025 21:49:19
-- Design Name: 
-- Module Name: reg_bank_m_n_bit - Behavioral
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
use IEEE.math_real.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity reg_bank_m_n_bit is
    generic (
        WIDTH: natural:= 32; -- number of register in the bank
        DEPTH: natural:= 4
    );
    Port ( clk : in STD_LOGIC; -- clock signal
           rst : in STD_LOGIC; -- active high rst
           en  : in STD_LOGIC; -- active high enable
           we : in STD_LOGIC; -- Write enable
           addr : in STD_LOGIC_VECTOR ( integer(ceil(log2(Real(DEPTH)))) -1 downto 0); -- address to read and write location
           wr_data_in : in STD_LOGIC_VECTOR (WIDTH-1 downto 0); --write data input
           rd_data_out : out STD_LOGIC_VECTOR (WIDTH-1 downto 0)); -- read data outut
end reg_bank_8_n_bit;


architecture Behavioral of reg_bank_m_n_bit is
type mem is array ( 0 to DEPTH-1) of std_logic_vector(WIDTH -1 downto 0); -- Memory type declaration
signal mem_reg: mem := (others => (others => '0')); -- Signal type mem declaration
signal data_out: std_logic_vector(WIDTH -1 downto 0);
begin

mem_proc: process(clk)
variable idx: natural;
begin
    idx := TO_INTEGER(unsigned(addr)); -- convert the address to natural for indexing;
    if rising_edge(clk) then
        if rst = '1' then
            mem_reg <= (others => (others => '0'));
            data_out <= (others => '0');
        elsif en = '1' then
            if we = '1' then
               mem_reg(idx) <=  wr_data_in;
            else
               data_out <=  mem_reg(idx);
            end if;
    end if;
    end if;
end process mem_proc;
rd_data_out <= data_out;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2025 21:45:23
-- Design Name: 
-- Module Name: ALU_Basic - Behavioral
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

entity ALU_Basic is
    generic(
           WIDTH: Natural := 4
    );
    Port ( clk          : in STD_LOGIC;
           rst          : in STD_LOGIC;
           en           : in STD_LOGIC;
           A            : in STD_LOGIC_VECTOR ((WIDTH - 1) downto 0);
           B            : in STD_LOGIC_VECTOR ((WIDTH - 1) downto 0);
           opcode       : in STD_LOGIC_VECTOR (2 downto 0);
           result       : out STD_LOGIC_VECTOR ((WIDTH - 1) downto 0);
           zero         : out STD_LOGIC;
           overf        : out STD_LOGIC
           );
end ALU_Basic;

architecture Behavioral of ALU_Basic is
signal result_reg: STD_LOGIC_VECTOR ((WIDTH - 1) downto 0) := (others => '0');
signal overf_reg : std_logic;

function or_reduct(inp_reg : in std_logic_vector) return std_logic is
  variable ret_res : std_logic := '0';  -- Null slv vector will also return '1'
begin
  for i in inp_reg'range loop
    ret_res := ret_res or inp_reg(i);
  end loop;
  return not ret_res;
end function;
begin



ALU_proc: process( clk )
variable A_sig, B_sig, R_sig : signed ((WIDTH - 1) downto 0);
begin
    if rising_edge(clk) then
        if rst = '1' then
            result_reg <= (others => '0');
            overf_reg <= '0';
        elsif en = '1' then
            A_sig := signed(A);
            B_sig := signed(B);
            case opcode is
                when "000" => 
                              R_sig := A_sig + B_sig;
                              result_reg <= std_logic_vector(R_sig) ;
                              if (A_sig(WIDTH-1) = B_sig(WIDTH-1)) and (R_sig(WIDTH-1) /= A_sig(WIDTH-1))  then
                                overf_reg <= '1';
                              else 
                                overf_reg <= '0';
                             end if;
                when "001" => R_sig := A_sig - B_sig;
                              result_reg <= std_logic_vector(R_sig) ;
                              if (A_sig(WIDTH-1) = B_sig(WIDTH-1)) and (R_sig(WIDTH-1) /= A_sig(WIDTH-1))  then
                                overf_reg <= '1';
                              else 
                                overf_reg <= '0';
                             end if;
                when "010" => result_reg <= A AND B;
                              overf_reg <= '0';
                when "011" => result_reg <= A OR B;
                              overf_reg <= '0';
                when "100" => result_reg <= A XOR B;
                              overf_reg <= '0';
                when "101" => result_reg <= NOT A;
                              overf_reg <= '0';
                when "110" => 
                              R_sig := A_sig + 1;
                              result_reg <= std_logic_vector(R_sig) ;
                              if (A_sig(WIDTH-1) = '0') and (R_sig(WIDTH-1) = '1')  then
                                overf_reg <= '1';
                              else 
                                overf_reg <= '0';
                             end if;
                when "111" => 
                             R_sig := A_sig - 1;
                              result_reg <= std_logic_vector(R_sig) ;
                              if (A_sig(WIDTH-1) = '1') and (R_sig(WIDTH-1) = '0')  then
                                overf_reg <= '1';
                              else 
                                overf_reg <= '0';
                             end if;
                when others => result_reg <= (others => '0');
                               overf_reg <= '0';
            end case;
       end if;
    end if;
end process ALU_proc;

result <= result_reg;
zero <= or_reduct(result_reg);
overf <= overf_reg ;
end Behavioral;

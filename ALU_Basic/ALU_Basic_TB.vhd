----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.04.2025 22:57:25
-- Design Name: 
-- Module Name: ALU_Basic_TB - Behavioral
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

entity ALU_Basic_TB is
--  Port ( );
end ALU_Basic_TB;

architecture Behavioral of ALU_Basic_TB is

    constant WIDTH : natural := 4;

    signal clk     : std_logic := '0';
    signal rst     : std_logic;
    signal en      : std_logic;
    signal A, B    : std_logic_vector(WIDTH-1 downto 0);
    signal opcode  : std_logic_vector(2 downto 0);
    signal result  : std_logic_vector(WIDTH-1 downto 0);
    signal zero    : std_logic;
    signal overf   : std_logic;

    -- Clock generation
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the ALU
    uut: entity work.ALU_Basic
        generic map (WIDTH => WIDTH)
        port map (
            clk     => clk,
            rst     => rst,
            en      => en,
            A       => A,
            B       => B,
            opcode  => opcode,
            result  => result,
            zero    => zero,
            overf   => overf
        );

    -- Clock process
    clk_process : process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Stimulus
    stim_proc: process
    begin
        rst <= '1';
        en  <= '0';
        A   <= "0000";
        B   <= "0000";
        opcode <= "000";
        wait for 20 ns;

        rst <= '0';
        en  <= '1';

        -- ADD:  3 + 2 = 5
        A <= "0011";  -- 3
        B <= "0010";  -- 2
        opcode <= "000";
        wait for clk_period;

        -- SUB:  3 - 5 = -2 (overflow check)
        A <= "0011";  -- 3
        B <= "0101";  -- 5
        opcode <= "001";
        wait for clk_period;

        -- AND
        A <= "1010";
        B <= "1100";
        opcode <= "010";
        wait for clk_period;

        -- OR
        opcode <= "011";
        wait for clk_period;

        -- XOR
        opcode <= "100";
        wait for clk_period;

        -- NOT
        opcode <= "101";
        wait for clk_period;

        -- INC
        opcode <= "110";
        wait for clk_period;

        -- DEC
        opcode <= "111";
        wait for clk_period;

        en <= '0';
        wait;

    end process;

end Behavioral;


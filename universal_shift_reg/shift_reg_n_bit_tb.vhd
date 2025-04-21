library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_reg_n_bit_tb is
end shift_reg_n_bit_tb;

architecture Behavioral of shift_reg_n_bit_tb is

  -- Parameters
  constant N : integer := 4;

  -- Component declaration
  component uni_shift_reg_n_bit is
    generic (
      N : integer := 4
    );
    port (
      clk       : in  std_logic;
      rst       : in  std_logic;
      en        : in  std_logic;
      load      : in  std_logic;
      dir       : in  std_logic;
      data_in   : in  std_logic;
      load_data : in  std_logic_vector(N-1 downto 0);
      data_out  : out std_logic;
      q         : out std_logic_vector(N-1 downto 0)
    );
  end component;

  -- Signals
  signal clk       : std_logic := '0';
  signal rst       : std_logic := '0';
  signal en        : std_logic := '0';
  signal load      : std_logic := '0';
  signal dir       : std_logic := '0';
  signal data_in   : std_logic := '0';
  signal load_data : std_logic_vector(N-1 downto 0) := (others => '0');
  signal data_out  : std_logic;
  signal q         : std_logic_vector(N-1 downto 0);

  -- Clock generation
  constant clk_period : time := 10 ns;
  begin
    clk_process : process
    begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
    end process;

  -- DUT instantiation
  uut: uni_shift_reg_n_bit
    generic map(N => N)
    port map (
      clk       => clk,
      rst       => rst,
      en        => en,
      load      => load,
      dir       => dir,
      data_in   => data_in,
      load_data => load_data,
      data_out  => data_out,
      q         => q
    );

  -- Test sequence
  stim_proc: process
  begin
    -- Reset
    rst <= '1';
    wait for 2 * clk_period;
    rst <= '0';

    -- Load data
    en <= '1';
    load <= '0';
    load_data <= "1010";
    wait for clk_period;

    load <= '0';

    -- Shift left with serial input
    dir <= '0';
    data_in <= '1';
    wait for clk_period * 4;

    -- Shift right with different input
    dir <= '1';
    data_in <= '0';
    wait for clk_period * 4;

    -- Disable enable signal
    en <= '0';
    wait for clk_period * 2;

    -- Done
    wait;
  end process;

end Behavioral;

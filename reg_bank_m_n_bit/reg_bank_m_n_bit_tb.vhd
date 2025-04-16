library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.ALL;

entity reg_bank_m_n_bit_tb is
end reg_bank_m_n_bit_tb;

architecture Behavioral of reg_bank_m_n_bit_tb is
    constant WIDTH : integer := 8;
    constant DEPTH : integer := 16;
    constant ADDR_WIDTH : integer := integer(ceil(log2(real(DEPTH))));

    signal clk         : std_logic := '0';
    signal rst         : std_logic := '0';
    signal en          : std_logic := '0';
    signal we          : std_logic := '0';
    signal addr        : std_logic_vector(ADDR_WIDTH-1 downto 0) := (others => '0');
    signal wr_data_in  : std_logic_vector(WIDTH-1 downto 0) := (others => '0');
    signal rd_data_out : std_logic_vector(WIDTH-1 downto 0);

    -- Clock generation
    constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.reg_bank_m_n_bit
        generic map (
            WIDTH => WIDTH,
            DEPTH => DEPTH
        )
        port map (
            clk => clk,
            rst => rst,
            en => en,
            we => we,
            addr => addr,
            wr_data_in => wr_data_in,
            rd_data_out => rd_data_out
        );

    -- Clock process
    clk_process: process
    begin
        while true loop
            clk <= '0'; wait for CLK_PERIOD/2;
            clk <= '1'; wait for CLK_PERIOD/2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset
        rst <= '1';
        wait for CLK_PERIOD;
        rst <= '0';
        wait for CLK_PERIOD;

        -- Write to address 3
        en <= '1'; we <= '1';
        addr <= std_logic_vector(to_unsigned(3, ADDR_WIDTH));
        wr_data_in <= x"AA";
        wait for CLK_PERIOD;

        -- Write to address 7
        addr <= std_logic_vector(to_unsigned(7, ADDR_WIDTH));
        wr_data_in <= x"55";
        wait for CLK_PERIOD;

        -- Read from address 3
        we <= '0';
        addr <= std_logic_vector(to_unsigned(3, ADDR_WIDTH));
        wait for CLK_PERIOD;

        -- Read from address 7
        addr <= std_logic_vector(to_unsigned(7, ADDR_WIDTH));
        wait for CLK_PERIOD;

        -- Read with enable OFF
        en <= '0';
        wait for CLK_PERIOD;

        -- Re-enable and write again
        en <= '1'; we <= '1';
        addr <= std_logic_vector(to_unsigned(5, ADDR_WIDTH));
        wr_data_in <= x"F0";
        wait for CLK_PERIOD;

        -- Read from address 5
        we <= '0';
        addr <= std_logic_vector(to_unsigned(5, ADDR_WIDTH));
        wait for CLK_PERIOD;

        wait;
    end process;

end Behavioral;

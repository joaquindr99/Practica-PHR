library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity biestableT is
    port(T: in std_logic;
         clk: in std_logic;
         Q: out std_logic);
end biestableT;
 
architecture Behavioral of biestableT is
    
    signal tmp: std_logic := '0';
    begin
        process (clk)
            begin
                if clk'event and clk='1' then
                    if T='0' then
                        tmp <= tmp;
                elsif T='1' then
                    tmp <= not (tmp);
                    end if;
                end if;
        end process;
    Q <= tmp;
    
end Behavioral;
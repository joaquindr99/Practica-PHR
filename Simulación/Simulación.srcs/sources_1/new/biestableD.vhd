library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;

entity biestableD is
  port(d,rst,clk: in std_logic;
        q, noq: out std_logic);
end  biestableD;

architecture behavioral of biestableD is

begin
    process (clk, rst)
        begin
            if (rst='1') then
                q<='0';
                noq <= '1';
            else
                if(clk='1' and clk'event) then
                    if (d='0') then
                        q<='0'; noq <= '1';
                    else 
                        q<='1'; noq <= '0';
                    end if;
                end if;
            end if;
end process;

end behavioral;
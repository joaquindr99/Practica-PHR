library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity deco3a8 is
    Port (A: in STD_LOGIC_VECTOR (2 downto 0);
          X: out STD_LOGIC_VECTOR (7 downto 0);
          E: in STD_LOGIC);
end deco3a8;

architecture Behavioral of deco3a8 is

begin
process (A, E)
begin
    if (E = '1') then 
        case A is
            when "000" => X <= "11111110";
            when "001" => X <= "11111101";
            when "010" => X <= "11111011";
            when "011" => X <= "11110111";
            when "100" => X <= "11101111";
            when "101" => X <= "11011111";
            when "110" => X <= "10111111";
            when "111" => X <= "01111111";
            when others => X <= "11111111";
        end case;
    end if;
end process;

end Behavioral;
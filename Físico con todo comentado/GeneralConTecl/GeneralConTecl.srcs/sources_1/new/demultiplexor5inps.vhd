library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity demultiplexor5inps is
port(S: in std_logic_vector(2 downto 0);
	 I: in std_logic_vector(3 downto 0);
	 O4: out std_logic_vector(3 downto 0);	
     O3: out std_logic_vector(3 downto 0);
	 O2: out std_logic_vector(3 downto 0);
	 O1: out std_logic_vector(3 downto 0);
	 O0: out std_logic_vector(3 downto 0));
end demultiplexor5inps;

architecture Behavioral of demultiplexor5inps is

begin
 process(S, I)
    begin
        case S is
	    when "000" =>   O0 <= I; O1 <= "0000"; O2 <= "0000"; O3 <= "0000"; O4 <= "0000";
	    when "001" =>	O1 <= I; O0 <= "0000"; O2 <= "0000"; O3 <= "0000"; O4 <= "0000";
	    when "010" =>	O2 <= I; O0 <= "0000"; O1 <= "0000"; O3 <= "0000"; O4 <= "0000";
	    when "011" =>	O3 <= I; O0 <= "0000"; O1 <= "0000"; O2 <= "0000"; O4 <= "0000";
	    when "100" =>	O4 <= I; O0 <= "0000"; O1 <= "0000"; O2 <= "0000"; O3 <= "0000";
	    when others =>	O0 <= "ZZZZ";
	end case;
    end process;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparador is
  Port (A,B:in std_logic_vector(3 downto 0);
         Z: out std_logic);
end comparador;

architecture Behavioral of comparador is
begin
z<='0' when (A=B) else
   '1' ;

end Behavioral;
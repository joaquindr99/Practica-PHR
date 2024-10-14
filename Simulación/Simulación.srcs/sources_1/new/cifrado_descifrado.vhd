library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cifrado_descifrado is
 Port (a: in std_logic_vector(3 downto 0);
       m: in std_logic_vector(3 downto 0);
       b: in std_logic_vector(3 downto 0);
       c: out std_logic_vector(3 downto 0);
       ele: in std_logic);
end cifrado_descifrado;

architecture Behavioral of cifrado_descifrado is

signal aux: std_logic_vector(7 downto 0);
signal a_inv: std_logic_vector(3 downto 0);

begin
    
    a_inv <= "0001" when a = "0001" else
    "0011" when a = "1011" else
    "0101" when a = "1101" else
    "0111" when a = "0111" else
    "1001" when a = "1001" else
    "1011" when a = "0011" else
    "1101" when a = "0101" else
    "1111" when a = "1111";

aux <= (a * m) + b when ele = '1' else (a_inv * m) - b;
c <= aux(3 downto 0);
       
end Behavioral;
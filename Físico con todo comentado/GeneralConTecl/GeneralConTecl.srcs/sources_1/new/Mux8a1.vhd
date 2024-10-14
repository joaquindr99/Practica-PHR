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

entity multiplexor is
port (I0: in std_logic_vector(3 downto 0); -- Entradas de datos
      I1: in std_logic_vector(3 downto 0);
      I2: in std_logic_vector(3 downto 0);
      I3: in std_logic_vector(3 downto 0);
      I4: in std_logic_vector(3 downto 0);
      I5: in std_logic_vector(3 downto 0);
      I6: in std_logic_vector(3 downto 0);
      I7: in std_logic_vector(3 downto 0);
      S: in std_logic_vector(2 downto 0); -- Entradas de selección
      Z: out std_logic_vector(3 downto 0));-- SALIDA 
end multiplexor;

architecture Behavioral of multiplexor is

begin
    process (I0, I1, I2, I3, I4, I5, I6, I7, S)
        begin
            case S is
                when "000" => Z <= I0;
                when "001" => Z <= I1;
                when "010" => Z <= I2;
                when "011" => Z <= I3;
                when "100" => Z <= I4;
                when "101" => Z <= I5;
                when "110" => Z <= I6;
                when "111" => Z <= I7;
                when others => Z <= I7;
            end case;
    end process;
        
end Behavioral;
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
 Port (a: in std_logic_vector(3 downto 0);  --Constante de multiplicación para el cifrado
       m: in std_logic_vector(3 downto 0);  --Tecla introducida para ser des/cifrada
       b: in std_logic_vector(3 downto 0);  --Constante de desplazamiento para des/cifrar
       c: out std_logic_vector(3 downto 0);  --Tecla de salida ya modificada
       ele: in std_logic);  --Selector para cifrar o descifrar
end cifrado_descifrado;

architecture Behavioral of cifrado_descifrado is

signal a_inv: std_logic_vector(3 downto 0);  --Inversa de a para el descifrado
signal aux: std_logic_vector(7 downto 0);  --Señal auxiliar de el doble de grande para poder guardar un resultado de multiplicar a * m

begin
aux <= (a * m) + b when ele = '1' else a_inv*(m-b);  --Operación de multiplicar por a o por a inversa y desplazar hacia alante o atrás dependiendo de 'ele'
c <= aux(3 downto 0);  --Asignación de esa operación a c
    
    a_inv <= "0001" when a = "0001" else  --Cuando a es 1, a inversa es 1
    "0011" when a = "1011" else  --Cuando a es 1, a inversa es 1
    "0101" when a = "1101" else  --Cuando a es D, a inversa es 5
    "0111" when a = "0111" else  --Cuando a es 7, a inversa es 7
    "1001" when a = "1001" else  --Cuando a es 9, a inversa es 9
    "1011" when a = "0011" else  --Cuando a es 3, a inversa es B
    "1101" when a = "0101" else  --Cuando a es 5, a inversa es D
    "1111" when a = "1111";  --Cuando a es F, a inversa es F
    
end Behavioral;
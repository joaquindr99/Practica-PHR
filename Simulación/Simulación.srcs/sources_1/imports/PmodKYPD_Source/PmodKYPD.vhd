library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PmodKYPD is
    Port (clk: in  std_logic;
		  fila: in  std_logic_vector(3 downto 0);
		  col: out std_logic_vector(3 downto 0);
          tecla: out std_logic_vector(3 downto 0));
end PmodKYPD;

architecture Behavioral of PmodKYPD is

component Decoder is
	Port (clk: in std_logic;
          fila: in std_logic_vector(3 downto 0);
		  col: out std_logic_vector(3 downto 0);
          DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;


begin
	
	C0: Decoder port map (clk => clk, fila => fila, col => col, DecodeOut => tecla);

end Behavioral;
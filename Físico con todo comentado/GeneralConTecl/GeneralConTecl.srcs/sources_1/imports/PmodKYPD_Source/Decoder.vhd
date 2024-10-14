library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Decoder is
    Port (clk: in std_logic;
          fila: in std_logic_vector(3 downto 0);
		  col: out std_logic_vector(3 downto 0);
          DecodeOut: out std_logic_vector(3 downto 0));
end Decoder;

architecture Behavioral of Decoder is

signal sclk: std_logic_vector(19 downto 0);
begin
	process(clk)
		begin 
		if clk'event and clk = '1' then
			-- 1ms
			if sclk = "00011000011010100000" then 
				--C1
				col<= "0111";
				sclk <= sclk+1;
			-- checkea los pines de fila
			elsif sclk = "00011000011010101000" then	
				--R1
				if fila = "0111" then
					DecodeOut <= "1101"; --A
				--R2
				elsif fila = "1011" then
					DecodeOut <= "1100"; --B
				--R3
				elsif fila = "1101" then
					DecodeOut <= "1011"; --C
				--R4
				elsif fila = "1110" then
					DecodeOut <= "1010"; --D
				end if;
				sclk <= sclk+1;
			-- 2ms
			elsif sclk = "00110000110101000000" then	
				--C2
				col<= "1011";
				sclk <= sclk+1;
			-- checkea los pines de fila
			elsif sclk = "00110000110101001000" then	
				--R1
				if fila = "0111" then		
					DecodeOut <= "1110"; --E
				--R2
				elsif fila = "1011" then
					DecodeOut <= "1001"; --9
				--R3
				elsif fila = "1101" then
					DecodeOut <= "0110"; --6
				--R4
				elsif fila = "1110" then
					DecodeOut <= "0011"; --3
				end if;
				sclk <= sclk+1;	
			--3ms
			elsif sclk = "01001001001111100000" then 
				--C3
				col<= "1101";
				sclk <= sclk+1;
			-- checkea los pines de fila
			elsif sclk = "01001001001111101000" then 
				--R1
				if fila = "0111" then
					DecodeOut <= "1111"; --F	
				--R2
				elsif fila = "1011" then
					DecodeOut <= "1000"; --8
				--R3
				elsif fila = "1101" then
					DecodeOut <= "0101"; --5
				--R4
				elsif fila = "1110" then
					DecodeOut <= "0010"; --2
				end if;
				sclk <= sclk+1;
			--4ms
			elsif sclk = "01100001101010000000" then 			
				--C4
				col<= "1110";
				sclk <= sclk+1;
			-- checkea los pines de fila
			elsif sclk = "01100001101010001000" then 
				--R1
				if fila = "0111" then
					DecodeOut <= "0000"; --0
				--R2
				elsif fila = "1011" then
					DecodeOut <= "0111"; --7
				--R3
				elsif fila = "1101" then
					DecodeOut <= "0100"; --4
				--R4
				elsif fila = "1110" then
					DecodeOut <= "0001"; --1
				end if;
				sclk <= "00000000000000000000";	
			else
				sclk <= sclk+1;	
			end if;
		end if;
	end process;
							 
end Behavioral;
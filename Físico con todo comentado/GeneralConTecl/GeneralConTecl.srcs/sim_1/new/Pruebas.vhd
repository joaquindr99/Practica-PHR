----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.05.2022 11:09:40
-- Design Name: 
-- Module Name: Pruebas - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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

entity Pruebas is
end Pruebas;

architecture Behavioral of Pruebas is

component master is
   
    Port (clk: in std_logic;
        tecla: in std_logic_vector(3 downto 0);
        sw_act: in std_logic;
        sw_elec: in std_logic;
        sw_resetear: in std_logic;
        sw_pulsa: in std_logic;
        led_cifro_descifro: out std_logic;
        led_fin_proceso: out std_logic;
        salidas: out std_logic_vector(6 downto 0));

end component;

component reg4bit is
  Port (load: in std_logic;
        inp: in std_logic_vector(3 downto 0);
        clk: in std_logic;
        clr: in std_logic;
        q: out std_logic_vector(3 downto 0));
end component;

    signal clock: std_logic;
    signal input: std_logic_vector(3 downto 0);
    signal elec, rst, actu: std_logic;
    signal salida: std_logic_vector(3 downto 0);
    --signal output: std_logic_vector(6 downto 0);
    --signal cifrar_descifrar, fin_proceso: std_logic;
    --signal puls: std_logic;

begin

    --prue: reg4bit port map (elec, input, clock, rst, salida); --Prueba del registro

    --circuito: master port map (clock, input, actu, elec, rst, puls, cifrar_descifrar, fin_proceso, output);  --Prueba general
    
    input <= "1111" after 20 ns, "0001" after 40 ns, "1111" after 60 ns, "1010" after 80 ns, "1100" after 100 ns, "0000" after 120 ns, "1011" after 140 ns;
    --puls <= '0' after 0 ns, '1' after 21 ns, '0' after 31 ns, '1' after 46 ns, '0' after 51 ns, '1' after 66 ns, '0' after 71 ns, '1' after 86 ns, '0' after 91 ns, '1' after 106 ns, '0' after 111 ns, '1' after 126 ns, '0' after 131 ns, '1' after 146 ns, '0' after 151 ns; 
    elec <= '0' after 0 ns, '1' after 11 ns; -- '0' after 100 ns, '1' after 200 ns, '0' after 300 ns, '1' after 400 ns, '0' after 500 ns;
    rst <= '0' after 0 ns, '1' after 10 ns, '0' after 15 ns;
    --actu <= '0' after 0 ns, '1' after 200 ns;
    
    process
        begin
            clock <= '0';
            wait for 2.5 ns;
            clock <= '1';
            wait for 2.5 ns;
    end process;

end Behavioral;
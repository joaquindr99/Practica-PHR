----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2022 18:09:40
-- Design Name: 
-- Module Name: 4bit register - Behavioral
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

entity reg4bit is
  Port (load: in std_logic;
        inp: in std_logic_vector(3 downto 0);
        clk: in std_logic;
        clr: in std_logic;
        q: out std_logic_vector(3 downto 0));
end reg4bit;

architecture Behavioral of reg4bit is

signal auxclk: std_logic := '0';


begin

process(clk, clr)
begin
        if (clr = '1') then
            q <= "0000";
        else
            if (auxclk = '0' AND clk = '1') then
                    auxclk <= clk;
                    if load = '1' then
                            q <= inp;
                    end if;
            elsif auxclk = '1' AND clk = '0' then
                    auxclk <= clk;
            end if;
        end if;
end process;

end Behavioral;
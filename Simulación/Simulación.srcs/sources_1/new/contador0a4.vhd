--4 BIT BINARY COUNTER
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity contador0a4 is 
port(clk: in std_logic;
     reset: in std_logic;
     enable: in std_logic;
     count: out std_logic_vector(2 downto 0));
end contador0a4;
 
architecture behavior of contador0a4 is
      
  signal pre_count: std_logic_vector(2 downto 0);
  begin
    process(clk, enable, reset)
    begin
      if reset = '1' then
        pre_count <= "000";
      elsif (clk='1' and clk'event) then
        if enable = '1' and pre_count < "100" then
          pre_count <= pre_count + "1";
        end if;
      end if;
    end process;  
    count <= pre_count;
    
end behavior;
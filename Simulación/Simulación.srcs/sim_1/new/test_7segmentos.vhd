LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
 
ENTITY tb_seg IS
END tb_seg;
 
ARCHITECTURE behavior OF tb_seg IS 

    COMPONENT to_7seg
    PORT(A: IN  std_logic_vector(3 downto 0);
         seg7 : OUT  std_logic_vector(6 downto 0));
    END COMPONENT;
   
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal seg7 : std_logic_vector(6 downto 0);
 
BEGIN
 
    -- Instantiate the Unit Under Test (UUT)
   uut: to_7seg PORT MAP (
          A => A,
          seg7 => seg7
        );

  -- Stimulus process
   stim_proc: process
   begin        
        for i in 0 to 15 loop
            A <= conv_std_logic_vector(i,4);
            wait for 50 ns;
        end loop;
      wait;
   end process;

END;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.05.2022 12:37:10
-- Design Name: 
-- Module Name: General - Behavioral
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

entity General is
  Port (Reset: in std_logic;
        act: in std_logic;
        ele: in std_logic;
        puls: in std_logic;
        inp: in std_logic_vector(3 downto 0);
        clk: in std_logic;
        led_cif_desc: out std_logic;
        led_fin_proc: out std_logic;
        out0, out1, out2, out3, out4: out std_logic_vector(3 downto 0));
end General;

architecture Behavioral of General is

    signal ou0, ou1, ou2, ou3, ou4, ou5, ou6: std_logic_vector(3 downto 0); --salidas para el primer demux
    signal count0, count1, count2, countMux: std_logic_vector(2 downto 0); --salida contadores para multiplexores y demultiplexores
    signal zout, auxReg: std_logic_vector(3 downto 0); --salida multiplexor
    signal cif_descif: std_logic_vector(3 downto 0); --salida circuito que cifra y descifra
    signal outt0, outt1, outt2, outt3, outt4: std_logic_vector(3 downto 0); --salidas para el segundo demux
    signal loadRegA, loadRegB, loadReg0, loadReg1, loadReg2, loadReg3, loadReg4: std_logic; --loads para los registros de entrada
    signal loadRegOut0, loadRegOut1, loadRegOut2, loadRegOut3, loadRegOut4: std_logic; --loads para los registros de salida
    signal qIna, qInb, qIn0, qIn1, qIn2, qIn3, qIn4: std_logic_vector(3 downto 0); --salidas registros de entrada
    signal clkBies, NoclkBies, clkMux, clkDemux, clkBies2, NoclkBies2: std_logic; -- clks con biestables
    signal retardadoAct, NoretardadoAct, retardoActMas, NoretardoActMas: std_logic;
    
    component demultiplexor is
    port (S: in std_logic_vector(2 downto 0);
          I: in std_logic_vector(3 downto 0);
          O0: out std_logic_vector(3 downto 0);
          O1: out std_logic_vector(3 downto 0);
          O2: out std_logic_vector(3 downto 0);
          O3: out std_logic_vector(3 downto 0);
          O4: out std_logic_vector(3 downto 0);
          O5: out std_logic_vector(3 downto 0);
          O6: out std_logic_vector(3 downto 0)
    );
    end component;
    
    component demultiplexor5inps is
    port (S: in std_logic_vector(2 downto 0);
          I: in std_logic_vector(3 downto 0);
          O0: out std_logic_vector(3 downto 0);
          O1: out std_logic_vector(3 downto 0);
          O2: out std_logic_vector(3 downto 0);
          O3: out std_logic_vector(3 downto 0);
          O4: out std_logic_vector(3 downto 0)
    );
    end component;
    
    component cifrado_descifrado is
    port (a: in std_logic_vector(3 downto 0);
          m: in std_logic_vector(3 downto 0);
          b: in std_logic_vector(3 downto 0);
          c: out std_logic_vector(3 downto 0);
          ele: in std_logic
    );
    end component;

    component counter is
    port (clk: in std_logic;
          reset: in std_logic;
          enable: in std_logic;
          count: out std_logic_vector(2 downto 0)
    );
    end component;
    
    component contador0a4 is
    port (clk: in std_logic;
          reset: in std_logic;
          enable: in std_logic;
          count: out std_logic_vector(2 downto 0)
    );
    end component;
    
    component multiplexor is
    port (I0: in std_logic_vector(3 downto 0);
          I1: in std_logic_vector(3 downto 0);
          I2: in std_logic_vector(3 downto 0);
          I3: in std_logic_vector(3 downto 0);
          I4: in std_logic_vector(3 downto 0);
          I5: in std_logic_vector(3 downto 0);
          I6: in std_logic_vector(3 downto 0);
          I7: in std_logic_vector(3 downto 0);
          S: in std_logic_vector(2 downto 0);
          Z: out std_logic_vector(3 downto 0)
     );
    end component;
    
    component reg4bit is
    Port (load: in std_logic;
          inp: in std_logic_vector(3 downto 0);
          clk: in std_logic;
          clr: in std_logic;
          q: out std_logic_vector(3 downto 0)
    );
    end component;
    
    component reg4bitPreLoad is
    Port (load: in std_logic;
        inp: in std_logic_vector(3 downto 0);
        preload: in std_logic_vector(3 downto 0);
        clk: in std_logic;
        clr: in std_logic;
        q: out std_logic_vector(3 downto 0)
        );
     end component;
     
     component biestableD is
     port(d,rst,clk: in std_logic;
          q, noq: out std_logic
     );
     end component;
     
     component biestableT is
     Port (T: in std_logic;
           clk: in std_logic;
           Q: out std_logic);
	 end component;

begin

    led_cif_desc <= ele; --led para indicar si cifra (encendido) o descifra (apagado)
    led_fin_proc <=  count1(2); --led para indicar que se ha cifrado o descifrado el mensaje
    
    loadRegA <= (NOT count0(2) AND NOT count0(1) AND NOT count0(0));
    loadRegB <= (NOT count0(2) AND NOT count0(1) AND count0(0));
    loadReg0 <= (NOT count0(2) AND count0(1) AND NOT count0(0));
    loadReg1 <= (NOT count0(2) AND count0(1) AND count0(0));
    loadReg2 <= (count0(2) AND NOT count0(1) AND NOT count0(0));
    loadReg3 <= (count0(2) AND NOT count0(1) AND count0(0));
    loadReg4 <= (count0(2) AND count0(1) AND NOT count0(0));
    
    loadRegOut0 <= (NOT count2(2) AND NOT count2(1) AND NOT count2(0));
    loadRegOut1 <= (NOT count2(2) AND NOT count2(1) AND count2(0));
    loadRegOut2 <= (NOT count2(2) AND count2(1) AND NOT count2(0));
    loadRegOut3 <= (NOT count2(2) AND count2(1) AND count2(0));
    loadRegOut4 <= (count2(2) AND NOT count2(1) AND NOT count2(0));

    DEMUX1: demultiplexor port map
        (S => count0,
         I => inp,
         O0 => ou0,
         O1 => ou1,
         O2 => ou2,
         O3 => ou3,
         O4 => ou4,
         O5 => ou5,
         O6 => ou6);
         
    BIEST1: biestableD port map
        (d => puls,
         rst => Reset,
         clk => clk,
         q => clkBies,
         noq => NoclkBies);
         
    CONT0: counter port map
        (clk => clkBies,
         reset => Reset,
         enable => '1',
         count => count0);
         
    REGa: reg4bit port map
        (load => loadRegA,
         inp => ou0,
         clk => puls,
         clr => Reset,
         q => qIna);
        
    REGb: reg4bit port map
        (load => loadRegB,
         inp => ou1,
         clk => puls,
         clr => Reset,
         q => qInb); 
         
    REGin0: reg4bit port map
        (load => loadReg0,
         inp => ou2,
         clk => puls,
         clr => Reset,
         q => qIn0); 
        
    REGin1: reg4bit port map
        (load => loadReg1,
         inp => ou3,
         clk => puls,
         clr => Reset,
         q => qIn1);
        
    REGin2: reg4bit port map
        (load => loadReg2,
         inp => ou4,
         clk => puls,
         clr => Reset,
         q => qIn2);
        
    REGin3: reg4bit port map
        (load => loadReg3,
         inp => ou5,
         clk => puls,
         clr => Reset,
         q => qIn3);
        
    REGin4: reg4bit port map
        (load => loadReg4,
         inp => ou6,
         clk => puls,
         clr => Reset,
         q => qIn4);         
        
    MUX1: multiplexor port map
        (I0 => qIn0,
         I1 => qIn1,
         I2 => qIn2,
         I3 => qIn3,
         I4 => qIn4,
         I5 => "0000",  --entrada no utilizada
         I6 => "0000",  --entrada no utilizada
         I7 => "0000",  --entrada no utilizada
         S => count1,
         Z => zout);
        
    BIEST2: biestableT port map
        (T => '1',
         clk => clk,
         Q => clkMux);
        
    CONT1: contador0a4 port map
        (clk => clkMux,
         reset => Reset,
         enable => retardadoAct,
         count => count1);
         
    CD: cifrado_descifrado port map
        (a => qIna,
         m => zout,
         b => qInb,
         c => cif_descif,
         ele => ele);   
         
    BIEST3: biestableT port map
        (T => '1',
         clk => clk,
         Q => clkDemux);
         
    BIEST4: biestableD port map
        (d => clkDemux,
         rst => Reset,
         clk => clk,
         q => clkBies2,
         noq => NoclkBies2);
         
         
    BIEST5: biestableD port map
        (d => act,
         rst => Reset,
         clk => clkBies2,
         q => retardoActMas,
         noq => NoretardoActMas);
         
    BIEST6: biestableD port map
        (d => retardoActMas,
         rst => Reset,
         clk => clkBies2,
         q => retardadoAct,
         noq => NoretardadoAct);

    CONT2: contador0a4 port map
        (clk => NoclkBies2,
         reset => Reset,
         enable => retardadoAct,
         count => count2);
         
    DEMUX2: demultiplexor5inps port map
        (S => count2,
         I => cif_descif,
         O0 => outt0,
         O1 => outt1,
         O2 => outt2,
         O3 => outt3,
         O4 => outt4);   
        
    REGout0: reg4bit port map
        (load => loadRegOut0,
         inp => outt0,
         clk => clk,
         clr => Reset,
         q => out0);
        
    REGout1: reg4bit port map
        (load => loadRegOut1,
         inp => outt1,
         clk => clk,
         clr => Reset,
         q => out1);
        
    REGout2: reg4bit port map
        (load => loadRegOut2,
         inp => outt2,
         clk => clk,
         clr => Reset,
         q => out2);
        
    REGout3: reg4bit port map
        (load => loadRegOut3,
         inp => outt3,
         clk => clk,
         clr => Reset,
         q => out3);
        
    REGout4: reg4bit port map
        (load => loadRegOut4,
         inp => outt4,
         clk => clk,
         clr => Reset,
         q => out4);
         
end Behavioral;
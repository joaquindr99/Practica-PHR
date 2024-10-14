----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.05.2022 18:26:41
-- Design Name: 
-- Module Name: master - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity master is
  Port (clk: in std_logic;
        tecla: in std_logic_vector(3 downto 0); --tecla para simulaci�n ya que el teclado no se puede simular
        --entradaFil: in std_logic_vector(3 downto 0);
        --entradaCol: out std_logic_vector(3 downto 0); 
        sw_act: in std_logic;
        sw_elec: in std_logic;
        sw_resetear: in std_logic;
        sw_pulsa: in std_logic;
        led_cifro_descifro: out std_logic;
        led_fin_proceso: out std_logic;
        salida: out std_logic_vector(3 downto 0)); --salida tecla cifrada
        --salidas: out std_logic_vector(6 downto 0);
        --dec: out std_logic_vector(7 downto 0));
end master;

architecture Behavioral of master is

    signal inpu: std_logic_vector(3 downto 0);
    signal outpu0, outpu1, outpu2, outpu3, outpu4: std_logic_vector(3 downto 0);
    signal count3: std_logic_vector(2 downto 0);
    signal salidamux: std_logic_vector(3 downto 0);

    component PmodKYPD is
        Port (clk: in  std_logic;
		      fila: in  std_logic_vector(3 downto 0);
		      col: out std_logic_vector(3 downto 0);
              tecla: out std_logic_vector(3 downto 0));
        end component;
    
    component General is
        Port (Reset: in std_logic;
              act: in std_logic;
              ele: in std_logic;
              puls: in std_logic;
              inp: in std_logic_vector(3 downto 0);
              clk: in std_logic;
              led_cif_desc: out std_logic;
              led_fin_proc: out std_logic;
              out0, out1, out2, out3, out4: out std_logic_vector(3 downto 0));
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
              Z: out std_logic_vector(3 downto 0));
        end component;
        
    component contador0a4rep is
        port (clk: in std_logic;
              reset: in std_logic;
              enable: in std_logic;
              count: out std_logic_vector(2 downto 0));
        end component;
        
    component to_7seg is
        Port (A: in  STD_LOGIC_VECTOR (3 downto 0);
              seg7: out  STD_LOGIC_VECTOR (6 downto 0));
        end component;
       
    component deco3a8 is
        Port (A: in  STD_LOGIC_VECTOR (2 downto 0);
              X: out STD_LOGIC_VECTOR (7 downto 0);
              E: in  STD_LOGIC);
        end component;

begin
      
    --TECLADO: PmodKYPD port map   --comentado ya que estamos simulando la tecla con una entrada tecla
        --(clk => clk,
         --fila => entradaFil,
         --col => entradaCol,
         --tecla => inpu);  
         
    CIRCUITO: General port map
        (Reset => sw_resetear,
         act => sw_act,
         ele => sw_elec,
         puls => sw_pulsa,
         inp => tecla, --Opci�n simular teclado
         --inp => inpu, --Opci�n conectar teclado
         clk => clk,
         led_cif_desc => led_cifro_descifro,
         led_fin_proc => led_fin_proceso,
         out0 => outpu0,
         out1 => outpu1,
         out2 => outpu2,
         out3 => outpu3,
         out4 => outpu4);
         
    CONT3: contador0a4rep port map
        (clk => clk,
         reset => sw_resetear,
         enable => sw_act,
         count => count3);
         
    MUX2: multiplexor port map
        (I0 => outpu0,
         I1 => outpu1,
         I2 => outpu2,
         I3 => outpu3,
         I4 => outpu4,
         I5 => "0000",  --entrada no utilizada
         I6 => "0000",  --entrada no utilizada
         I7 => "0000",  --entrada no utilizada
         S => count3,
         --Z => salidaMux, --salida para convertir a 7 seg
         Z => salida); --salida para simulaci�n
         
    --DECO: deco3a8 port map  --Comentado ya que para la simulaci�n es mas visual un d�gito de salida en hexadecimal que los 7 segmentos
        --(A => count3,
         --X => dec,
         --E => sw_act);
         
    --PANTALLA: to_7seg port map  ----Comentado ya que para la simulaci�n es mas visual un d�gito de salida en hexadecimal que los 7 segmentos
        --(A => salidamux,
        --seg7 => salidas);
        
end Behavioral;
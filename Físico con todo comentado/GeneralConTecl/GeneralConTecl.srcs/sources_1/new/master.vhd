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

entity master is  --ESQUEMA DEL CIRCUITO EN UNA ILUSTRACIÓN ADJUNTADA EN LA MEMORIA DEL PROYECTO
  Port (clk: in std_logic;  --Reloj del sistema
        entradaFil: in std_logic_vector(3 downto 0);  --Filas del teclado
        entradaCol: out std_logic_vector(3 downto 0);  --Columnas del teclado
        sw_act: in std_logic;  --Switch que activa la operación de cifrado o descifrado
        sw_elec: in std_logic;  --Switch que elige si cifrar '1' o descifrar '0'
        sw_resetear: in std_logic;  --Switch que resetea el sistema
        sw_pulsa: in std_logic;  --Switch que almacena la última tecla pulsada en el registro correspondiente (1ª en regA, 2ª en regB, 3ª en regIn0, 4ª en regIn1, etc.)
        led_cifro_descifro: out std_logic;  --Led que indica si se cifra o descifra
        led_fin_proceso: out std_logic;  --Led que se enciende cuando finaliza el proceso
        salidas: out std_logic_vector(6 downto 0);  --Salida que indica que segmentos encender en las pantallas de 7 segmentos
        dec: out std_logic_vector(7 downto 0));  --Salida de un decodificador que selecciona la pantalla que recibe salida
end master;

architecture Behavioral of master is

    signal inpu: std_logic_vector(3 downto 0);  --Señal que almacena la tecla pulsada
    signal outpu0, outpu1, outpu2, outpu3, outpu4: std_logic_vector(3 downto 0);  --Señales que guardan el contenido de los registros de salida (dígitos ya des/cifrados)
    signal count3: std_logic_vector(2 downto 0);  --Señal de contador que selecciona que dígito sale y por cual de las pantallas
    signal salidamux: std_logic_vector(3 downto 0);  --Salida del multiplexor con el dígito ya des/cifrado

    component PmodKYPD is  --Component teclado
        Port (clk: in  std_logic;
		      fila: in  std_logic_vector(3 downto 0);
		      col: out std_logic_vector(3 downto 0);
              tecla: out std_logic_vector(3 downto 0));
        end component;
    
    component General is  --                        Circuito general que se encarga de recibir las teclas pulsadas por teclado, las
        Port (Reset: in std_logic;  --              almacena en registros, asigna a cada dígito su función (a, b, m0, m1, m2, m3 y m4),
              act: in std_logic;  --                hace la operación de cifrar o descifrar, los guarda ya modificados en registros de salida
              ele: in std_logic;  --                y los devuelve como salidas del propio circuito.
              puls: in std_logic;
              inp: in std_logic_vector(3 downto 0);
              clk: in std_logic;
              led_cif_desc: out std_logic;
              led_fin_proc: out std_logic;
              out0, out1, out2, out3, out4: out std_logic_vector(3 downto 0));
        end component;
        
    component multiplexor is  --Multiplexor 8 a 1
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
        
    component contador0a4rep is  --Contador 0 a 4 en bucle
        port (clk: in std_logic;
              reset: in std_logic;
              enable: in std_logic;
              count: out std_logic_vector(2 downto 0));
        end component;
        
    component to_7seg is  --Component que convierte hexadecimal a 7 segmentos
        Port (A: in  STD_LOGIC_VECTOR (3 downto 0);
              seg7: out  STD_LOGIC_VECTOR (6 downto 0));
        end component;
       
    component deco3a8 is  --decodificador 3 a 8
        Port (A: in  STD_LOGIC_VECTOR (2 downto 0);
              X: out STD_LOGIC_VECTOR (7 downto 0);
              E: in  STD_LOGIC);
        end component;

begin
      
    TECLADO: PmodKYPD port map
        (clk => clk,
         fila => entradaFil,
         col => entradaCol,
         tecla => inpu);  
         
    CIRCUITO: General port map
        (Reset => sw_resetear,
         act => sw_act,
         ele => sw_elec,
         puls => sw_pulsa,
         inp => inpu,
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
         Z => salidamux);
         
    DECO: deco3a8 port map
        (A => count3,
         X => dec,  --Selector de pantalla que recibe dígito
         E => sw_act);
         
    PANTALLA: to_7seg port map
        (A => salidamux,
        seg7 => salidas);  --Dígito hexadecimal representado en pantalla
        
end Behavioral;
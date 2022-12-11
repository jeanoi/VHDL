

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee. numeric_std.all;

ENTITY MACHINE IS
  PORT(
    clk: IN STD_LOGIC; --Clock
    rst: IN STD_LOGIC; --Reset
    M: IN STD_LOGIC; --Moeda Inserida
    VM: IN UNSIGNED (6 DOWNTO 0); --Valor da moeda
    IMPRIME: IN STD_LOGIC; --Requisocao para imprimir
    BILHETE: OUT STD_LOGIC; --Bilhete impresso 
    CANCELA: IN STD_LOGIC; --Requisicao para cancelar
    DEVOLVE: OUT STD_LOGIC; --Dinheiro devolvido
    ERRO: OUT STD_LOGIC; --Sinalizacao de erro
    TMOEDAS: OUT UNSIGNED (9 DOWNTO 0) := (OTHERS => '0'); --Total de moedas
    TTEMPO: OUT UNSIGNED (9 DOWNTO 0) := (OTHERS => '0') --Total de tempo
    );
END MACHINE;

ARCHITECTURE FUNCT OF MACHINE IS

--Sinais auxiliares
SIGNAL TTEMPO_AUX: UNSIGNED (9 DOWNTO 0) := (OTHERS => '0');
SIGNAL TMOEDAS_AUX: UNSIGNED (9 DOWNTO 0) := (OTHERS => '0');
SIGNAL TMOEDAS_SOM: UNSIGNED (9 DOWNTO 0) := (OTHERS => '0');
SIGNAL aux1: UNSIGNED(9 DOWNTO 0) := "0001100100";
SIGNAL aux6: UNSIGNED(9 DOWNTO 0) := "1001011000";
SIGNAL X: STD_LOGIC;
SIGNAL Y: STD_LOGIC;
SIGNAL clr: STD_LOGIC;
SIGNAL ld: STD_LOGIC;
SIGNAL ld_reg: STD_LOGIC;


TYPE estados IS (iniciar, aguardar, somar, test1, test2, err, devolver, aprovado); --Estados
SIGNAL estado : estados;


BEGIN

--Logica de sequencia de estados
PROCESS (clk, rst, M, IMPRIME, CANCELA, X, Y)
  BEGIN
    
  IF rising_edge (clk) THEN
    
    
    CASE estado IS -- Logica de mudanca de estados
      
    WHEN iniciar =>
      IF (rst = '1') THEN
      estado <= iniciar;
      END IF;  
      
      IF(rst = '0') THEN
        estado <= aguardar;
      END IF;
      
                
      WHEN aguardar =>
        
        IF (M = '0' AND IMPRIME = '0' AND CANCELA = '0') THEN
          estado <= aguardar;
        END IF;
        
        IF (M = '1' AND IMPRIME = '0' AND CANCELA = '0') THEN 
          estado <= somar;
        END IF;
        
        IF (M = '0' AND IMPRIME = '1' AND CANCELA = '0') THEN
          estado <= test2;
        END IF;
        
        IF (M = '0' AND IMPRIME = '0' AND CANCELA = '1') THEN
          estado <= devolver;
        END IF;
  
        
       WHEN somar =>
        estado <= test1;
        
       
        
       WHEN test1 =>
        IF (X = '1') THEN
          estado <= devolver;
        END IF;
      
        IF (X = '0') THEN 
        estado <= aguardar;
        END IF;  
        
       
      
      WHEN test2 =>
        
         IF (Y = '0') THEN
           estado <= err;
         END IF;
         
         IF (Y = '1') THEN
           estado <= aprovado;
         END IF;
         
         
    
    WHEN err =>
      estado <= devolver;
      

    
    WHEN devolver =>
      estado <= iniciar;
      
      
    WHEN aprovado =>
      estado <= iniciar;
       
      
  END CASE;
END IF;
END PROCESS;



--Comparador
X <= '1' WHEN (TMOEDAS_AUX > aux6) ELSE
     '0' WHEN TMOEDAS_AUX <= aux6;
     
Y <= '1' WHEN (TMOEDAS_AUX >= aux1) ELSE
     '0' WHEN TMOEDAS_AUX < aux1;



--Somador TMOEDAS
PROCESS(clr, ld, clk, rst)
  BEGIN
    IF rst = '1' THEN 
      TMOEDAS_SOM <= (OTHERS => '0');
    ELSIF (rising_edge(clk)) THEN
      IF clr = '1' THEN
        TMOEDAS_SOM <= (OTHERS => '0');
      ELSIF ld = '1' THEN 
        TMOEDAS_SOM <= TMOEDAS_SOM + VM;
      END IF;
    END IF;
  END PROCESS;
  
  
--Registrador TMOEDAS
PROCESS(clr, ld, clk, rst)
  BEGIN
    IF rst = '1' THEN 
      TMOEDAS_AUX <= (OTHERS => '0');
    ELSIF (rising_edge(clk)) THEN
      IF clr = '1' THEN
        TMOEDAS_AUX <= (OTHERS => '0');
      ELSIF ld_reg = '1' THEN 
        TMOEDAS_AUX <= TMOEDAS_SOM;
      END IF;
    END IF;
  END PROCESS;
  
  
--Registrador TTEMPO
PROCESS(clr, ld, clk, rst)
  BEGIN
    IF rst = '1' THEN 
      TTEMPO <= (OTHERS => '0');
    ELSIF (rising_edge(clk)) THEN
      IF clr = '1' THEN
        TTEMPO <= (OTHERS => '0');
      ELSIF ld_reg = '1' THEN 
        TTEMPO <= TTEMPO_AUX;
      END IF;
    END IF;
  END PROCESS;

--Geracao do sinal de clear
WITH estado SELECT 
  clr <= '1' WHEN iniciar,
         '0' WHEN OTHERS;


--Geracao do sinal de load 
WITH estado SELECT
  ld <= '1' WHEN somar,
        '0' WHEN OTHERS;

--Geracao do sinal BILHETE
WITH estado SELECT
  BILHETE <= '1' WHEN aprovado,
             '0' WHEN OTHERS;
             
--Geracao do sinal DEVOLVE
WITH estado SELECT
  DEVOLVE <= '1' WHEN devolver,
             '0' WHEN OTHERS;

--Geracao do sinal ERRO
WITH estado SELECT
  ERRO <= '1' WHEN err,
          '0' WHEN OTHERS;

--Geracao do sinal ERRO
WITH estado SELECT
  ld_reg <= '1' WHEN aguardar,
            '0' WHEN OTHERS;

--Geracao do sinal TMOEDAS
TMOEDAS <= TMOEDAS_AUX;

--Bit ShifterTMOEDAS_AUX
TTEMPO_AUX <= shift_right(unsigned(TMOEDAS_SOM), 2);


END FUNCT;

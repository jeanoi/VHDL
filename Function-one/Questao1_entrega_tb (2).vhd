--Questao 1, Testbench


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Q1_TB IS
END Q1_TB;

ARCHITECTURE funct_tb OF Q1_TB IS

COMPONENT Q1 
  PORT(
    A: IN STD_LOGIC; -- Variavel de entrada
    BCD: IN STD_LOGIC_VECTOR (2 DOWNTO 0); --Variavel de selecao
    Z: OUT STD_LOGIC; -- Variavel de saida
    E: IN STD_LOGIC -- Enable
  );
END COMPONENT;

SIGNAL Atb: STD_LOGIC := '1';
SIGNAL BCDtb: STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
SIGNAL Ztb: STD_LOGIC;
SIGNAL Etb: STD_LOGIC := '1';

BEGIN
  
DUT: Q1 PORT MAP(Atb, BCDtb(2 DOWNTO 0), Ztb, Etb);


Etb <= '0' after 10000 ns; --Criacao do sinal Enable


Atb <= '0' after 10 ns;--Criacao do sinal de entrada

PROCESS --Criacao de todas as entradas BCD possiveis
  BEGIN
    WAIT FOR 100 ns;
    FOR j in 0 TO 7 LOOP
      BCDtb <= BCDtb+1;
    END LOOP;
  END PROCESS;


END funct_tb;

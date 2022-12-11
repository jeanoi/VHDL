

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee. numeric_std.all;

ENTITY Q2 IS
  PORT(
    X: IN STD_LOGIC := '0'; --Variavel de selecao
    Z: OUT STD_LOGIC := '0'; --Variável de saída
    clk: IN STD_LOGIC; --Clock
    rst: IN STD_LOGIC := '0' --Reset
    );
END Q2;

ARCHITECTURE funct OF Q2 IS

TYPE estados IS (A,B,C,D,E,F,G,H); --Estados
SIGNAL estado: estados;
SIGNAL D1: STD_LOGIC; --Entradas Flip-Flop
SIGNAL D2: STD_LOGIC;
SIGNAL D3: STD_LOGIC;
SIGNAL Q3: STD_LOGIC := '1'; --Saidas Flip-Flop
SIGNAL Q2: STD_LOGIC := '1';
SIGNAL Q1: STD_LOGIC := '1';
SIGNAL FLIP: UNSIGNED (2 DOWNTO 0) := "000"; --Representacao dos 3 Flip-Flops em uma unica saida

BEGIN


PROCESS(CLK, D1, D2, D3, rst) --Flip Flop D
  BEGIN
    
    IF (rst = '1') THEN 
      Q1 <= '0';
      Q2 <= '0';
      Q3 <= '0';
    
  ELSIF rising_edge(clk) THEN
      Q1 <= D1;
      Q2 <= D2;
      Q3 <= D3;
    END IF;
  END PROCESS;
  
FLIP(0) <= Q1;
FLIP(1) <= Q2;
FLIP(2) <= Q3;
Z <= ((NOT Q2 AND Q1) OR (Q3 AND Q2 AND NOT Q1) OR (X AND Q3 AND Q2) OR (X AND Q2 AND NOT Q1)); 



--Equacoes booleanas
D3 <= ((NOT X AND NOT Q1) OR (NOT Q2 AND NOT X AND NOT Q3) OR (NOT Q2 AND Q1 AND X AND Q3) OR (Q2 AND Q1 AND X AND NOT Q3)
       OR (Q2 AND NOT Q1 AND X AND Q3));
       
D2 <= ((NOT X AND NOT Q2 AND Q1) OR (NOT Q3 AND Q2 AND NOT Q1) OR (NOT X AND Q3) OR (X AND NOT Q2 AND NOT Q1) OR
       (X AND NOT Q3 AND Q2));
       
D1 <= ((NOT X AND NOT Q3) OR (NOT X AND Q2 AND NOT Q1) OR (Q2 AND X AND NOT Q3));



WITH FLIP SELECT
    
    estado <= A WHEN "000",
              B WHEN "001",
              C WHEN "010",
              D WHEN "011",
              E WHEN "100",
              F WHEN "101",
              G WHEN "110",
              H WHEN OTHERS;
     

END funct;


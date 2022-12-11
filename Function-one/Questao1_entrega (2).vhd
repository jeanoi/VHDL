

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL; --Biblioteca Padrao

ENTITY Q1 IS
  PORT(
    A: IN STD_LOGIC; -- Variavel de entrada
    BCD: IN STD_LOGIC_VECTOR (2 DOWNTO 0); --Variavel de selecao
    Z: OUT STD_LOGIC; -- Variavel de saida
    E: IN STD_LOGIC -- Enable
  );
END Q1;

ARCHITECTURE funct OF Q1 IS

SIGNAL AUX: STD_LOGIC; -- Sinal auxiliar
BEGIN

WITH BCD SELECT -- Logica de escolha da saida
 AUX <=  '0' WHEN "000",
         '1' WHEN "011",
      NOT A  WHEN "001",
      NOT A  WHEN "100",
      NOT A  WHEN "111",
          A WHEN OTHERS;

WITH E SELECT -- Logica para funcionamento do Enable 
 Z <=  AUX WHEN '1',
      '0' WHEN OTHERS;

END funct;

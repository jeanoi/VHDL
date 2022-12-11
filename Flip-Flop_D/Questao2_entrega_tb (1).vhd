LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee. numeric_std.all;


ENTITY Q2_tb IS 
END Q2_tb;

ARCHITECTURE testbench OF Q2_tb IS

COMPONENT Q2 IS
  PORT(
    X: IN STD_LOGIC; --Variavel de selecao
    Z: OUT STD_LOGIC; --Variável de saída
    clk: IN STD_LOGIC; --Clock
    rst: IN STD_LOGIC := '0' --Reset
    );
END COMPONENT;


SIGNAL Xtb : STD_LOGIC := '1';
SIGNAL Ztb : STD_LOGIC;
SIGNAL clktb : STD_LOGIC := '0';
SIGNAL rsttb : STD_LOGIC := '0';


BEGIN


DUT: Q2 PORT MAP(Xtb, Ztb, clktb, rsttb);

PROCESS(clktb)
  BEGIN
    clktb <= not clktb after 20 ns; -- 25 MHz
  END PROCESS;

rsttb <= '0' after 10 ns, '1' after 10000 ns;

END testbench;


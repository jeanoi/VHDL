LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee. numeric_std.all;

ENTITY Q3_tb IS
END Q3_tb;

ARCHITECTURE testbench OF Q3_tb IS

COMPONENT MACHINE
  PORT(
    clk: IN STD_LOGIC;
    rst: IN STD_LOGIC;
    M: IN STD_LOGIC;
    VM: IN UNSIGNED (6 DOWNTO 0);
    IMPRIME: IN STD_LOGIC;
    BILHETE: OUT STD_LOGIC;
    CANCELA: IN STD_LOGIC;
    DEVOLVE: OUT STD_LOGIC;
    ERRO: OUT STD_LOGIC;
    TMOEDAS: OUT UNSIGNED (9 DOWNTO 0);
    TTEMPO: OUT UNSIGNED (9 DOWNTO 0)
    );
END COMPONENT;

SIGNAL clktb : STD_LOGIC := '0';
SIGNAL rsttb: STD_LOGIC := '0';
SIGNAL Mtb: STD_LOGIC := '0';
SIGNAL VMtb: UNSIGNED(6 DOWNTO 0) := "0000000";
SIGNAL IMPRIMEtb: STD_LOGIC := '0';
SIGNAL BILHETEtb: STD_LOGIC;
SIGNAL CANCELAtb: STD_LOGIC := '0';
SIGNAL DEVOLVEtb: STD_LOGIC;
SIGNAL ERROtb: STD_LOGIC;
SIGNAL TMOEDAStb: UNSIGNED (9 DOWNTO 0):= "0000000000";
SIGNAL TTEMPOtb: UNSIGNED (9 DOWNTO 0);


BEGIN

NEWC: MACHINE PORT MAP(clktb, rsttb, Mtb, VMtb, IMPRIMEtb, BILHETEtb, CANCELAtb, DEVOLVEtb, ERROtb, TMOEDAStb, TTEMPOtb);


process(clktb) --Geracao do sinal de clock
  begin
    clktb <= not clktb after 10 ns; -- 25MHz
  End process;
    --Geracao do sinal de Reset
    rsttb <= '1' after 1500 ns; 
    --Geracao das moedas sendo inseridas
    Mtb <= '1' after 85 ns, '0' after 95 ns, '1' after 285 ns, '0' after 295 ns, '1' after 385 ns, '0' after 395 ns,
    '1' after 625 ns, '0' after 635 ns, '1' after 725 ns, '0' after 735 ns, '1' after 825 ns, '0' after 835 ns, '1' after 905 ns, '0' after 915 ns,
    '1' after 1005 ns, '0' after 1015 ns, '1' after 1085 ns, '0' after 1095 ns, '1' after 1205 ns, '0' after 1215 ns, '1' after 1305 ns, '0' after 1315 ns, '1' after 1405 ns, '0' after 1415 ns;
    --Geracao do valor das moedas inseridas
    VMtb <= "0000101" after 85 ns, "0000000" after 230 ns, "1100100" after 285 ns,"0000000" after 550 ns, "1100100" after 625 ns, "1100100" after 725 ns, "1100100" after 825 ns;
    --Geracao da requisicao para imprimir
    IMPRIMEtb <= '1' after 165 ns, '0' after 175 ns, '1' after 465 ns, '0' after 475 ns;
    --Geracao da requisicao para cancelar
    CANCELAtb <= '1' after 1465 ns, '0' after 1475 ns;


END testbench;


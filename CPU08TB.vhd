library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- declaração das portas de i/o, sinais e tipos

entity cpu_tb is
end cpu_tb;

architecture cpu_arch of cpu_tb is

component cpu is
port(clk: in std_logic; -- clock geral
      rst: in std_logic; -- sinal de reset
      din: in std_logic_vector( 7 downto 0 ); -- vetor de entrada de dados da ram
      rw: out std_logic; -- sinal de escrita/leitura na ram
      addr: out std_logic_vector( 4 downto 0 ); -- endereçamento da ram
      dout: out std_logic_vector( 7 downto 0 ) -- saída de dados para a ram
      );

end component;


component RAM is
port(CLK		                : in std_logic;
	RST		               : in std_logic;
	RAMADDR              : in   std_logic_vector (4 downto 0);
     RAMDATAIN            : in   std_logic_vector (7 downto 0);
     WRITERAM             : in   std_logic;
     RAMDATAOUT           : out  std_logic_vector (7 downto 0));
end component;

signal	CLK		           :  std_logic;
signal	RST		           :  std_logic;
signal	RAMADDR              :  std_logic_vector (4 downto 0);
signal     RAMDATAIN            :  std_logic_vector (7 downto 0);
signal     WRITERAM             :  std_logic;
signal     RAMDATAOUT           :  std_logic_vector (7 downto 0);

begin
  
U1: CPU port map( clk=> CLK,
      rst=> RST, -- sinal de reset
      din => RAMDATAOUT,-- vetor de entrada de dados da ram
      rw => WRITERAM, -- sinal de escrita/leitura na ram
      addr => RAMADDR,-- endereçamento da ram
      dout=> RAMDATAIN -- saída de dados para a ram
      );

U2: RAm port map(clk=> CLK,
      		 rst=> RST, -- sinal de reset
			 RAMADDR => RAMADDR,
			 RAMDATAIN => RAMDATAIN,
			 WRITERAM => WRITERAM,
			 RAMDATAOUT => RAMDATAOUT);



Process
begin
	CLK<='1';
	wait for 50 ns;
	CLK<= '0';
	wait for 50 ns;
end process;


Process
begin
	RST<='1';
	wait for 300 ns;
	RST<= '0';
	wait for 3 ms;
end process;

end;





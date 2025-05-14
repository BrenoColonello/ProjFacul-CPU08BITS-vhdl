library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- declara��o das portas de i/o, sinais e tipos

entity cpu is

port(clk: in std_logic; -- clock geral
      rst: in std_logic; -- sinal de reset
      din: in std_logic_vector( 7 downto 0 ); -- vetor de entrada de dados da ram
      rw: out std_logic; -- sinal de escrita/leitura na ram
      addr: out std_logic_vector( 4 downto 0 ); -- endere�amento da ram
      dout: out std_logic_vector( 7 downto 0 ) -- sa�da de dados para a ram
      );

end cpu;

architecture cpu_arch of cpu is

-- estados da cpu
type estado is ( reset1, reset2, busca, executa, movad, movbd, resultado );

signal estado_atual: estado;

signal sdout,  -- alimenta a entrada da ram
        reg_inst1,  -- registrador de instru��o 1
        reg_inst2,  -- registrador de instru��o 2
        rega,  -- alimenta��o da ula (registrador a)
        regb,  -- alimenta��o da ula (registrador b)
        reg_ula: -- armazena resultados de opera��es da ula
        std_logic_vector( 7 downto 0 );

signal pc: std_logic_vector( 4 downto 0 );  -- contador de programa


-- sinais que indicam qual instru��o deve ser executada
signal inst_movad, inst_movbd: std_logic;
signal inst_add, inst_sub, inst_and, inst_or: std_logic;

begin

-- decodifica��o da instru��o (trecho concorrente)

inst_movad <= '1' when reg_inst1( 7 downto 0 ) = "00000011" else '0';
inst_movbd <= '1' when reg_inst1( 7 downto 0 ) = "00000111" else '0';
inst_add <= '1' when reg_inst1( 7 downto 4 ) = "0001" else '0';
inst_sub <= '1' when reg_inst1( 7 downto 4 ) = "0010" else '0';
inst_and <= '1' when reg_inst1( 7 downto 4 ) = "0011" else '0';
inst_or <= '1' when reg_inst1( 7 downto 4 ) = "0100" else '0';

addr <= pc;
dout <= sdout;

-- busca e execu��o
process( clk, rst )

begin

	if rst = '1' then
		estado_atual <= reset1;
	elsif clk'event and clk='1' then
		rw <= '0';
		case estado_atual is
			-- inicializa registradores
			when reset1 =>
			      reg_inst1 <= "00000000";
			      reg_inst2 <= "00000000";
			      rega <= "00000000";
			      regb <= "00000000";
			      reg_ula <= "00000000";
			      sdout <= "00000000";
			      estado_atual <= reset2;

			-- inicializa pc (contador de programa)
			when reset2 =>
			      pc <= "00000";
			      estado_atual <= busca;

			-- busca instru��o apontada por pc
			when busca =>
			      reg_inst1 <= din;
			      pc <= pc + 1;
			      estado_atual <= executa;

			-- analisa sinais resultantes da decodifica��o do opcode e executa
			-- opera��o ou parte dela
			when executa =>
			      if inst_movad = '1' then
			      	reg_inst2 <= din;
				estado_atual <= movad;
			     elsif inst_movbd = '1' then
			     	reg_inst2 <= din;
			     	estado_atual <= movbd;
			     elsif inst_add = '1' then
			     	reg_ula <= rega + regb;
			     	estado_atual <= resultado;
			     elsif inst_sub = '1' then
			     	reg_ula <= rega - regb;
			     	estado_atual <= resultado;
			     elsif inst_and = '1' then
			     	reg_ula <= rega and regb;
			     	estado_atual <= resultado;
			     elsif inst_or = '1' then
			     	reg_ula <= rega or regb;
			     	estado_atual <= resultado;
			     end if;

-- parte final da execu��o da instru��o mov a dado
			when movad =>
				rega <= reg_inst2;
				pc <= pc + "00001";
				estado_atual <= busca;

-- parte final da execu��o da instru��o mov b dado
			when movbd =>
				regb <= reg_inst2;
				pc <= pc + "00001";
				estado_atual <= busca;

-- parte final da execu��o das instru��es l�gicas e aritm�ticas da ula
			when resultado =>
				rega <= reg_ula;
				estado_atual <= busca;

			when others => estado_atual <= busca;
			end case;
		end if;
	end process;
end cpu_arch;

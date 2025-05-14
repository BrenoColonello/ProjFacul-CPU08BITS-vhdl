
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RAM is
port( CLK		                : in std_logic;
	RST		               : in std_logic;
	RAMADDR              : in   std_logic_vector (4 downto 0);
      RAMDATAIN            : in   std_logic_vector (7 downto 0);
      WRITERAM             : in   std_logic;

      RAMDATAOUT           : out  std_logic_vector (7 downto 0));
end RAM;

architecture rtl of RAM is

	type BLOCK1_ARRAY is array (31 downto 0) of std_logic_vector(7 downto 0);
	signal	BLOCK1	: BLOCK1_ARRAY ;
	signal first  : boolean:= true;
begin

	process (CLK, RST)
	begin
     if RST ='1' then
         first <= true; 
	elsif Clk'event and Clk = '1' then
			if first then
			   for i in 0 to 31 loop
			     BLOCK1 (i) <= (others=>'0');
			   end loop;
			   first <= false;
			end if;
  
			     BLOCK1 (0) <= "00000011"; --MOVEAD
			     BLOCK1 (1) <= "00001110"; --0E
			     BLOCK1 (2) <= "00000111"; --MOVEBD
			     BLOCK1 (3) <= "00000001"; --01
			     BLOCK1 (4) <= "00010000"; --ADD
	  
			
    	   if WRITERAM = '1' then
	        BLOCK1(to_integer(unsigned(RAMADDR))) <= RAMDATAIN; -- 			                  RAMDATAOUT <= BLOCK1(to_integer(unsigned(RAMADDR(6 downto 0)))-32);                			   
        end if;
		end if;
	end process;

           RAMDATAOUT <= BLOCK1(to_integer(unsigned(RAMADDR)));                			   

end;

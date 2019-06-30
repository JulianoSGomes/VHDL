library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY controle_agua is
   Port ( 
		i_RST  : IN STD_LOGIC;
		
		i_NV   : IN STD_LOGIC;
		i_TEMP : IN STD_LOGIC;
	
		o_NV   : OUT STD_LOGIC;
		o_TEMP : OUT STD_LOGIC
 	);
	END controle_agua;
	
architecture behavioral of controle_agua is
	
	BEGIN
	U_CAFETEIRA : PROCESS (i_NV, i_RST, i_TEMP) BEGIN
		IF (i_RST = '1') THEN
			o_NV   <= '0';
			o_TEMP <= '0';
		ELSE
			IF (i_NV = '1') THEN
				o_NV <= '1';
			ELSE
				o_NV <= '0';
			END IF;
			
			IF (i_TEMP = '1') THEN
				o_TEMP <= '1';
			ELSE
				o_TEMP <= '0';
			END IF;
		END IF;
	END PROCESS;
end behavioral;
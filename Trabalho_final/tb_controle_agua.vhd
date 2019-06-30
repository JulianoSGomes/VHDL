LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL;


ENTITY tb_controle_agua IS

END tb_controle_agua;

ARCHITECTURE behavioral of tb_controle_agua IS

	COMPONENT controle_agua is
		Port ( 
			i_RST  : IN STD_LOGIC;
			
			i_NV   : IN STD_LOGIC;
			i_TEMP : IN STD_LOGIC;
		
			o_NV   : OUT STD_LOGIC;
			o_TEMP : OUT STD_LOGIC
		);
	END COMPONENT controle_agua;

	
		SIGNAL w_RST      :  STD_LOGIC;
	
		SIGNAL w_NV     :  STD_LOGIC;
		SIGNAL w_TEMP    :  STD_LOGIC;
		SIGNAL wo_NV    :  STD_LOGIC;
		SIGNAL wo_TEMP  :  STD_LOGIC;
		
		

	BEGIN 
	UUT : controle_agua
	PORT MAP(
    
		i_RST  => w_RST,      
	
		i_NV => w_NV,     
		i_TEMP => w_TEMP,     
		
		o_NV => wo_NV,     
		o_TEMP => wo_TEMP    

	);

			
	PROCESS	BEGIN
		w_RST <= '0';
		WAIT FOR 20 NS;
		w_RST <= '1';
		WAIT;
	END PROCESS;
	
	PROCESS 
		BEGIN 
			WAIT FOR 30 NS;
			w_NV <= '1';
			WAIT FOR 4 NS;
			w_TEMP <= '1';
			WAIT FOR 4 NS;
			w_NV <= '0';
			WAIT FOR 5 NS;
			w_TEMP <= '0';
			WAIT;
	END PROCESS;
			
			
END behavioral;
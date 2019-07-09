LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL;


ENTITY tb_contador IS

END tb_contador;

ARCHITECTURE behavioral of tb_contador IS

	COMPONENT contador IS 
		Generic(
			p_DATA_WIDTH  	 : INTEGER := 5	
		);
		
		PORT(
			i_CLK      : IN STD_LOGIC; 
			i_RST      : IN STD_LOGIC;
			i_EN		  : IN STD_LOGIC;
			
			i_DATA 	  : IN STD_LOGIC_VECTOR(p_DATA_WIDTH downto 0);
			o_DATA  	  : OUT STD_LOGIC
		);
		
	END  COMPONENT contador;
	
	
	SIGNAL w_CLK     : STD_LOGIC;
	SIGNAL w_RST     : STD_LOGIC;
	SIGNAL w_EN   : STD_LOGIC;

	SIGNAL w_DATA_IN : STD_LOGIC_VECTOR(5 downto 0);
	SIGNAL w_DATA_OUT : STD_LOGIC;
	
	
	BEGIN 
	
	UUT : contador
		PORT MAP(
			i_CLK      => w_CLK, 
			i_RST      => w_RST,	
			i_EN    	  => w_EN,
			i_DATA  	  => w_DATA_IN,
			o_DATA     => w_DATA_OUT
		);
		
		
	PROCESS 	BEGIN
			w_CLK <= '1';
			WAIT FOR 1 NS;
			w_CLK <= '0';
			WAIT FOR 1 NS;
	END PROCESS;
	
	PROCESS	BEGIN
		w_RST <= '0';
		WAIT FOR 20 NS;
		w_RST <= '1';
		WAIT FOR 50 NS;
		w_RST <= '0';
		WAIT FOR  1 NS;
		w_RST <= '1';
		WAIT;
	END PROCESS;
	
	PROCESS 
		BEGIN 
			w_DATA_IN <= "000101";
			w_EN <= '0';
			WAIT FOR 10 NS;
			w_EN <= '1';
			WAIT;
	END PROCESS;
			
			
END behavioral;
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL;


ENTITY tb_conversor_bcd IS

	GENERIC(
		t_IN : integer := 10;
		t_OUT : integer := 8
	);

END tb_conversor_bcd;

ARCHITECTURE behavioral of tb_conversor_bcd IS

	COMPONENT conversor_bcd IS
	
	GENERIC(
		t_IN : integer := 10;
		t_OUT : integer := 8
	);
	
	PORT(
		i_D    : IN STD_LOGIC_VECTOR (t_IN - 1 DOWNTO 0);
		o_Q    : OUT STD_LOGIC_VECTOR (t_OUT - 1 DOWNTO 0)
		);
	
	END COMPONENT conversor_bcd;

	
		SIGNAL w_D  :  STD_LOGIC_VECTOR (t_IN - 1 DOWNTO 0);
	
		SIGNAL w_Q  :  STD_LOGIC_VECTOR (t_OUT - 1 DOWNTO 0);
		

	BEGIN 
	UUT : conversor_bcd
	PORT MAP(
    
		i_D  => w_D,      
	
		o_Q  => w_Q
	);

			
	
	PROCESS 
		BEGIN 
			w_D <= "0000000001";
			WAIT FOR 5 NS;
			w_D <= "0000001011";
			WAIT FOR 4 NS;
			w_D <= "0000000111";
			WAIT FOR 5 NS;
			w_D <= "0000000100";
			WAIT;
	END PROCESS;
			
			
END behavioral;
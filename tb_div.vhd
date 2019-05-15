library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
     
entity tb_div is 
	GENERIC(
		p_DATA_WIDTH : INTEGER := 31
	);
end tb_div; 
   
   
architecture Behavioral of tb_div is 

	component div
	PORT
	(
		denom		   : IN STD_LOGIC_VECTOR  (p_DATA_WIDTH DOWNTO 0);
		numer		   : IN STD_LOGIC_VECTOR  (p_DATA_WIDTH DOWNTO 0);
		quotient		: OUT STD_LOGIC_VECTOR (p_DATA_WIDTH DOWNTO 0);
		remain		: OUT STD_LOGIC_VECTOR (p_DATA_WIDTH DOWNTO 0)
	);
	end component;
   
	SIGNAL w_DENOM 	:  STD_LOGIC_VECTOR (p_DATA_WIDTH DOWNTO 0);
	SIGNAL w_NUMER		:  STD_LOGIC_VECTOR (p_DATA_WIDTH DOWNTO 0);
	SIGNAL w_RESULT	:  STD_LOGIC_VECTOR (p_DATA_WIDTH DOWNTO 0);
	SIGNAL w_REMAIN	:  STD_LOGIC_VECTOR (p_DATA_WIDTH DOWNTO 0);
	
	SIGNAL w_cem : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL w_mult : STD_LOGIC_VECTOR (31 DOWNTO 0);

	BEGIN 

	w_cem  <= "01100100";
	
	div_inst : div
		PORT MAP (
			denom	 	 => w_DENOM,
			numer	 	 => W_NUMER,
			quotient	 => W_RESULT,
			remain	 => W_REMAIN
	);

	
--	PROCESS 
--	BEGIN 
--		w_CLK <= '0';
--		WAIT FOR 20 NS;
--		w_CLK <= '1';
--		WAIT FOR 20 NS;
--	END PROCESS;	
	
--	PROCESS 
--	BEGIN 
--		w_RST <= '1';
--		WAIT FOR 100 NS;
--		w_RST <= '0';
--		WAIT;
--	END PROCESS;
	

	
	PROCESS 
	BEGIN
		WAIT FOR 10 NS;
		w_NUMER  <=  "000000000000000000000101" * w_cem;
		w_DENOM	<=  "00000000000000000000000000001100";
		wait;
	END PROCESS;
end Behavioral;            

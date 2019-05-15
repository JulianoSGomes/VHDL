library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
     
entity tb_RAM is 
	Generic(
			p_ADD_WIDTH    : INTEGER := 6; 
			p_DATA_WIDTH   : INTEGER := 10 
	);
end tb_RAM; 
   
   
architecture Behavioral of tb_RAM is 

	COMPONENT RAM is 
	  Generic ( 
			p_ADD_WIDTH    : INTEGER := 6; 
			p_DATA_WIDTH   : INTEGER := 10 
	  ); 
	  Port ( 
			i_CLK	   	: in STD_LOGIC; 
			i_RST	   	: in STD_LOGIC; 
			i_WE	   	: in STD_LOGIC; 
			i_EN 	   	: in STD_LOGIC; 
			i_ADDRESS 	: in STD_LOGIC_VECTOR  ((p_ADD_WIDTH-1) downto 0); 
			i_DIN     	: in STD_LOGIC_VECTOR  ((p_DATA_WIDTH-1) downto 0);
			o_DOUT    	: out STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0) 
	  ); 
	end COMPONENT; 
   
 
	SIGNAL w_WE      : STD_LOGIC;
	SIGNAL w_CLK     : STD_LOGIC;
	SIGNAL w_RST     : STD_LOGIC;
	SIGNAL w_EN      : STD_LOGIC;
	SIGNAL w_ADDRESS : STD_LOGIC_VECTOR  ((p_ADD_WIDTH-1) downto 0); 
	SIGNAL w_DIN     : STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
	SIGNAL w_DOUT    : STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
	
	BEGIN 
	
	U01 : RAM 
	 Generic Map(
		p_ADD_WIDTH => p_ADD_WIDTH,
		p_DATA_WIDTH  => p_DATA_WIDTH
	 )
    Port Map ( 
		i_CLK     =>  w_CLK,
		i_RST     =>  w_RST,
		i_WE      =>  w_WE,
		i_EN      =>  w_EN,
		i_DIN     =>  w_DIN,
		i_ADDRESS =>  w_ADDRESS,
		o_DOUT    =>  w_DOUT

	 );
	
	PROCESS 
	BEGIN 
		w_CLK <= '0';
		WAIT FOR 20 NS;
		w_CLK <= '1';
		WAIT FOR 20 NS;
	END PROCESS;	
	
	PROCESS 
	BEGIN 
		w_RST <= '1';
		WAIT FOR 100 NS;
		w_RST <= '0';
		WAIT;
	END PROCESS;
	

	
	PROCESS 
	BEGIN
		WAIT FOR 100 NS;
			w_EN <= '0';
			w_WE <= '0';
			w_ADDRESS <= "000000";
			w_DIN <= "0000000001";
		WAIT FOR 50 NS;
		
			w_ADDRESS <= "000001";
		WAIT FOR 50 NS;
			w_DIN <= "0000000010";
		WAIT FOR 100 NS;
		
			w_ADDRESS <= "000010";
		WAIT FOR 50 NS;
			w_DIN <= "0000000100";
		WAIT FOR 1000 NS;
		
			w_EN <= '0';
			w_WE <= '1';
		WAIT FOR 50 NS;
			w_ADDRESS <= "000000";
		WAIT FOR 100 NS;
			w_ADDRESS <= "000001";
		WAIT FOR 100 NS;
			w_ADDRESS <= "000010";
		wait;
	END PROCESS;
end Behavioral;            

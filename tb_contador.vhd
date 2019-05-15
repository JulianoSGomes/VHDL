library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
     
entity tb_CONTADOR is 
    Generic(
        p_DATA_WIDTH  	 : INTEGER := 10;
        p_DATA_IN_WIDTH  : INTEGER := 31
    );
end tb_CONTADOR; 
   
   
architecture Behavioral of tb_CONTADOR is 

	
	SIGNAL w_CLK           : STD_LOGIC;
	SIGNAL w_RST           : STD_LOGIC;
	SIGNAL w_DATA 			  : STD_LOGIC_VECTOR  (p_DATA_IN_WIDTH downto 0);
	SIGNAL w_DISPLAY_0     : STD_LOGIC_VECTOR  (7 downto 0); 
	SIGNAL w_DISPLAY_1     : STD_LOGIC_VECTOR  (7 downto 0); 
	SIGNAL w_DISPLAY_2     : STD_LOGIC_VECTOR  (7 downto 0); 
	
	COMPONENT CONTADOR is
    Generic(
        p_DATA_WIDTH  	 : INTEGER := 10;
        p_DATA_IN_WIDTH  : INTEGER := 31
    );
   Port ( 
        i_CLK 	    		 : in  STD_LOGIC;
        i_RST       		 : in  STD_LOGIC;

        i_DATA			 	 : IN STD_LOGIC_VECTOR(p_DATA_WIDTH-1 DOWNTO 0);

        o_DISPLAY_0		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
        o_DISPLAY_1		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
        o_DISPLAY_2		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
    );
	END COMPONENT;
	
	BEGIN
	
		U_CONTADOR : CONTADOR
		GENERIC MAP(        
		   p_DATA_WIDTH  	 => p_DATA_WIDTH,
			p_DATA_IN_WIDTH => p_DATA_IN_WIDTH 
		  )
		PORT MAP(
		  i_CLK 	    		=> w_CLK,
        i_RST       		=> w_RST,

        i_DATA			 	=> w_DATA,

        o_DISPLAY_0		=> w_DISPLAY_0,
        o_DISPLAY_1		=> w_DISPLAY_1,
        o_DISPLAY_2		=> w_DISPLAY_2
		);
		
	PROCESS 
	BEGIN 
		w_CLK <= '0';
		WAIT FOR 1 NS;
		w_CLK <= '1';
		WAIT FOR 1 NS;
	END PROCESS;	
	
	PROCESS 
	BEGIN 
		w_RST <= '0';
		WAIT FOR 100 NS;
		w_RST <= '1';
		WAIT;
	END PROCESS;
	
	PROCESS BEGIN 
	WAIT FOR 110 NS;
		w_DATA <= "00000000000000000000000000101010";
		WAIT FOR 200 NS;
	END PROCESS;
end Behavioral;            

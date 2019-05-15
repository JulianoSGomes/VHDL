library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
     
entity tb_ENQUETE is 
	Generic(
			p_ADD_WIDTH    : INTEGER := 6; 
			p_DATA_WIDTH   : INTEGER := 10 
	);
end tb_ENQUETE; 
   
   
architecture Behavioral of tb_ENQUETE is 

	SIGNAL w_BOM           : STD_LOGIC;
	SIGNAL w_CLK           : STD_LOGIC;
	SIGNAL w_RST           : STD_LOGIC;
	SIGNAL w_RUIM          : STD_LOGIC;
	SIGNAL w_REGULAR       : STD_LOGIC;
	SIGNAL w_CHECK_BOM     : STD_LOGIC;
	SIGNAL w_CHECK_REGULAR : STD_LOGIC;
	SIGNAL w_CHECK_RUIM    : STD_LOGIC;
	SIGNAL w_DISPLAY_0     : STD_LOGIC_VECTOR  (7 downto 0); 
	SIGNAL w_DISPLAY_1     : STD_LOGIC_VECTOR  (7 downto 0); 
	SIGNAL w_DISPLAY_2     : STD_LOGIC_VECTOR  (7 downto 0); 
	
	
	COMPONENT ENQUETE is
	 Generic(
				p_DATA_WIDTH : integer := 10;
				p_ADD_WIDTH : INTEGER := 6
	 );
    Port ( 
				i_CLK 				: in  STD_LOGIC;
				i_RST 				: in  STD_LOGIC;
				
				i_BOM  				: in  STD_LOGIC;
				i_RUIM  				: in  STD_LOGIC;
				i_REGULAR			: in  STD_LOGIC;
				
				i_CHECK_BOM			: IN STD_LOGIC;
				i_CHECK_RUIM		: in  STD_LOGIC;
				i_CHECK_REGULAR	: in STD_LOGIC;
				
				o_DISPLAY_0			: out STD_LOGIC_VECTOR(7 DOWNTO 0);
				o_DISPLAY_1			: out STD_LOGIC_VECTOR(7 DOWNTO 0);
				o_DISPLAY_2			: out STD_LOGIC_VECTOR(7 DOWNTO 0)
	 );
	end COMPONENT;
	BEGIN 
	
	U00 : ENQUETE 
		GENERIC MAP(
			p_ADD_WIDTH => p_ADD_WIDTH,
			p_DATA_WIDTH  => p_DATA_WIDTH
		)
		PORT MAP( 
				i_CLK  => w_CLK,
				i_RST  => w_RST,
				
				i_BOM  	  => w_BOM,
				i_RUIM  	  => w_RUIM,
				i_REGULAR  => w_REGULAR,
				
				i_CHECK_BOM		 =>	w_CHECK_BOM,
				i_CHECK_RUIM	 =>	w_CHECK_RUIM,
				i_CHECK_REGULAR =>	w_CHECK_REGULAR,
				
				o_DISPLAY_0		=>	w_DISPLAY_0,
				o_DISPLAY_1	   =>	w_DISPLAY_1,
				o_DISPLAY_2		=> w_DISPLAY_2
		);
		
	PROCESS 
	BEGIN 
		w_CLK <= '0';
		WAIT FOR 30 NS;
		w_CLK <= '1';
		WAIT FOR 30 NS;
	END PROCESS;	
	
	PROCESS 
	
	BEGIN 
		w_RST <= '0';
		WAIT FOR 100 NS;
		w_RST <= '1';
		WAIT;
	END PROCESS;
	

	
	PROCESS 
	BEGIN
		WAIT FOR 200 NS;
			
			w_CHECK_BOM <= '0';
			w_CHECK_REGULAR <= '0';
			w_CHECK_RUIM <= '0';
			w_BOM <= '0';
			w_REGULAR <= '0';
			w_RUIM <= '0';
			
			WAIT FOR 200 NS;
			w_BOM <= '1' ;    -- 1 BOM
			WAIT FOR 60 NS;
			w_BOM <= '0';
			WAIT FOR 400 NS;
			
			w_BOM <= '1';     -- 2 BOM 
			WAIT FOR 60 NS;
			w_BOM <= '0';
			WAIT FOR 400 NS;
			
			w_RUIM <= '1';     -- 1 RUIM 
			WAIT FOR 60 NS;
			w_RUIM <= '0';
			WAIT FOR 400 NS;

			
			
			w_BOM <= '1';     -- 3 BOM 
			WAIT FOR 60 NS;
			w_BOM <= '0';
			WAIT FOR 400 NS;
			
			w_BOM <= '1';     -- 4 BOM 
			WAIT FOR 60 NS;
			w_BOM <= '0';
			WAIT FOR 400 NS;

			w_REGULAR <= '1' ;   -- 1 REGULAR 
			WAIT FOR 60 NS;
			w_REGULAR <= '0';
			WAIT FOR 400 NS;

			
			w_RUIM <= '1';     -- 2 RUIM 
			WAIT FOR 60 NS;
			w_RUIM <= '0';
			WAIT FOR 400 NS;
			
			w_RUIM <= '1';     -- 3 RUIM 
			WAIT FOR 60 NS;
			w_RUIM <= '0';
			WAIT FOR 200 NS;  
			
			w_RUIM <= '1';     -- 4 RUIM 
			WAIT FOR 60 NS;
			w_RUIM <= '0';			
			WAIT FOR 400 NS;
			
			w_REGULAR <= '1';  -- 2 REGULAR
			WAIT FOR 60 NS;
			w_REGULAR <= '0';
			WAIT FOR 400 NS;
			
			w_RUIM <= '1';     -- 5 RUIM 
			WAIT FOR 60 NS;
			w_RUIM <= '0';			
			WAIT FOR 400 NS;
			
			
			w_CHECK_BOM <= '1';
			WAIT FOR 60 NS;
			w_CHECK_BOM <= '0';			
			WAIT FOR 400 NS;
		wait;
	END PROCESS;
end Behavioral;            

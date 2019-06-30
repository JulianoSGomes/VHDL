LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL;


ENTITY tb_cafeteira IS

END tb_cafeteira;

ARCHITECTURE behavioral of tb_cafeteira IS

	COMPONENT cafeteira IS
		Port ( 
			i_CLK      : IN STD_LOGIC;
			i_RST      : IN STD_LOGIC;
		
			i_CAFE     : IN STD_LOGIC;
			i_CAFEL    : IN STD_LOGIC;
			i_MOCA     : IN STD_LOGIC;
			i_TAM      : IN STD_LOGIC;
			i_ACUCAR   : IN STD_LOGIC;
			i_PREP     : IN STD_LOGIC;
			i_REPO     : IN STD_LOGIC;
			
			i_TEMPAGUA : IN STD_LOGIC;
			i_NVAGUA   : IN STD_LOGIC;
			
			o_CAFE     : BUFFER STD_LOGIC;
			o_CAFEL    : BUFFER STD_LOGIC;
			o_MOCA     : BUFFER STD_LOGIC;
			o_TAM      : BUFFER STD_LOGIC;
			o_ACUCAR   : BUFFER STD_LOGIC;
			o_REPO     : OUT STD_LOGIC;
			o_NVAGUA   : OUT STD_LOGIC;
			o_TEMPAGUA : OUT STD_LOGIC;
			o_DISPLAY0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			o_DISPLAY1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			o_DISPLAY2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			o_DISPLAY3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			o_PREPARO  : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
		 );
	END COMPONENT cafeteira;

	
	
	   SIGNAL w_CLK      :  STD_LOGIC;
		SIGNAL w_RST      :  STD_LOGIC;
	
		SIGNAL w_CAFE     :  STD_LOGIC;
		SIGNAL w_CAFEL    :  STD_LOGIC;
		SIGNAL w_MOCA     :  STD_LOGIC;
		SIGNAL w_TAM      :  STD_LOGIC;
		SIGNAL w_ACUCAR   :  STD_LOGIC;
		SIGNAL w_PREP     :  STD_LOGIC;
		SIGNAL w_REPO     :  STD_LOGIC;
		
		SIGNAL w_TEMPAGUA :  STD_LOGIC;
		SIGNAL w_NVAGUA   :  STD_LOGIC;
		
		SIGNAL wo_CAFE     : STD_LOGIC;
		SIGNAL wo_CAFEL    : STD_LOGIC;
		SIGNAL wo_MOCA     : STD_LOGIC;
		SIGNAL wo_TAM      : STD_LOGIC;
		SIGNAL wo_ACUCAR   : STD_LOGIC;
		SIGNAL wo_REPO     : STD_LOGIC;
		SIGNAL wo_NVAGUA   : STD_LOGIC;
		SIGNAL wo_TEMPAGUA : STD_LOGIC;
		SIGNAL wo_DISPLAY0 : STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL wo_DISPLAY1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL wo_DISPLAY2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL wo_DISPLAY3 : STD_LOGIC_VECTOR(7 DOWNTO 0);
		SIGNAL wo_PREPARO  : STD_LOGIC_VECTOR(4 DOWNTO 0);
	BEGIN 
	UUT : Cafeteira
	PORT MAP(
		i_CLK       => w_CLK,     
		i_RST       => w_RST,      
	
		i_CAFE      => w_CAFE,     
		i_CAFEL     => w_CAFEL,    
		i_MOCA      => w_MOCA,     
		i_TAM       => w_TAM,      
		i_ACUCAR    => w_ACUCAR,   
		i_PREP      => w_PREP,    
		i_REPO      => w_REPO,     
		
		i_TEMPAGUA  => w_TEMPAGUA, 
		i_NVAGUA    => w_NVAGUA,   
		
		o_CAFE      => wo_CAFE,     
		o_CAFEL     => wo_CAFEL,    
		o_MOCA      => wo_MOCA,    
		
		o_TAM       => wo_TAM,      
		o_ACUCAR    => wo_ACUCAR,   
		
		o_REPO      => wo_REPO,     
		o_NVAGUA    => wo_NVAGUA,   
		o_TEMPAGUA  => wo_TEMPAGUA, 
		
		o_DISPLAY0  => wo_DISPLAY0, 
		o_DISPLAY1  => wo_DISPLAY1, 
		o_DISPLAY2  => wo_DISPLAY2, 
		o_DISPLAY3  => wo_DISPLAY3, 
		
		o_PREPARO   => wo_PREPARO  
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
--		WAIT FOR 50 NS;
--		w_RST <= '0';
--		WAIT FOR  1 NS;
--		w_RST <= '1';
		WAIT;
	END PROCESS;
	
	PROCESS 
		BEGIN 
			WAIT FOR 30 NS;
			w_CAFE <= '1';
			WAIT FOR 4 NS;
			w_ACUCAR <= '1';
			WAIT FOR 4 NS;
			w_CAFEL <= '1';
			WAIT FOR 5 NS;
			w_PREP <= '1';
			WAIT;
	END PROCESS;
			
			
END behavioral;
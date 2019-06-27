library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ENQUETE is
	 Generic(
				p_DATA_WIDTH : integer := 10;
				p_ADD_WIDTH  : INTEGER := 6;
				p_BCD_OUT    : integer := 8
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
end ENQUETE;


architecture Behavioral of ENQUETE is

	COMPONENT MAQUINA_ESTADOS is
	 Generic(
				p_DATA_WIDTH : integer := 10;
				p_ADDR_WIDTH  : INTEGER := 6
	 );
    Port ( 
				i_CLK 				: in  STD_LOGIC;
				i_RST 				: in  STD_LOGIC;
				--
				-- COMANDOS DA MEMÓRIA RAM
				--
				o_EN			   	: OUT STD_LOGIC;
				o_WE		    		: OUT STD_LOGIC;
				o_ADDRESS			: OUT STD_LOGIC_VECTOR(p_ADDR_WIDTH -1 DOWNTO 0);
				i_DATA				: IN STD_LOGIC_VECTOR(p_DATA_WIDTH -1 DOWNTO 0);
				o_DATA				: OUT STD_LOGIC_VECTOR(p_DATA_WIDTH -1 DOWNTO 0);
				
				i_BOM  				: in  STD_LOGIC;
				i_RUIM  			   : in  STD_LOGIC;
				i_REGULAR			: in  STD_LOGIC;
				
				i_CHECK_BOM			: IN STD_LOGIC;
				i_CHECK_RUIM		: in  STD_LOGIC;
				i_CHECK_REGULAR	    : in STD_LOGIC;
				
				o_DISPLAY_0			: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
				o_DISPLAY_1			: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
				o_DISPLAY_2			: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0)
	 );
	end COMPONENT;
	
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
			i_ADDRESS 	: in STD_LOGIC_VECTOR ((p_ADD_WIDTH-1) downto 0); 
			i_DIN     	: in STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
			o_DOUT    	: out STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0) 
	  ); 
	end COMPONENT; 
	
	COMPONENT conversor_bcd IS
	
		GENERIC(
			t_IN : integer := 10;
			t_OUT : integer := 8
		);
	
	PORT(
		i_D    : IN STD_LOGIC_VECTOR (t_IN -1 DOWNTO 0);
		o_Q    : OUT STD_LOGIC_VECTOR (t_OUT -1 DOWNTO 0)
		);
	
	END COMPONENT;

	SIGNAL w_EN			: STD_LOGIC;
	SIGNAL w_WE  		: STD_LOGIC;
	SIGNAL w_DIN		: STD_LOGIC_VECTOR(p_DATA_WIDTH-1 DOWNTO 0);
	SIGNAL w_DOUT		: STD_LOGIC_VECTOR(p_DATA_WIDTH-1 DOWNTO 0);
	SIGNAL w_ADDR		: STD_LOGIC_VECTOR(p_ADD_WIDTH-1 DOWNTO 0);
	
	SIGNAL w_OUT_FSM_0 : STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
	SIGNAL w_OUT_FSM_1 : STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
	SIGNAL w_OUT_FSM_2 : STD_LOGIC_VECTOR((p_DATA_WIDTH-1) DOWNTO 0);
	
begin

	--
	-- INSTANCIALIZAÇÃO DA MAQUINA DE ESTADOS.
	--
	U0_FSM : MAQUINA_ESTADOS 
	 Generic Map(
			p_DATA_WIDTH  => p_DATA_WIDTH,
			p_ADDR_WIDTH  => p_ADD_WIDTH
	 )
    Port Map( 
				i_CLK 	 		=> i_CLK,
				i_RST 	 		=> i_RST,
				--
				-- COMANDOS DA MEMÓRIA RAM
				--
				o_EN		 	   => w_EN,
				o_WE		 	   => w_WE,
				o_ADDRESS		=> w_ADDR,
				i_DATA	 		=> w_DOUT,
				o_DATA	 		=> w_DIN,
				--
				-- COMANDOS EXTERNOS
				--
				i_BOM  	  		=> i_BOM,
				i_RUIM  	 	 	=> i_RUIM,
				i_REGULAR 		=> i_REGULAR,			
				
				i_CHECK_BOM		 => i_CHECK_BOM,
				i_CHECK_RUIM	 => i_CHECK_RUIM,
				i_CHECK_REGULAR => i_CHECK_REGULAR,
				
				o_DISPLAY_0		=> w_OUT_FSM_0,
				o_DISPLAY_1		=> w_OUT_FSM_1,
				o_DISPLAY_2		=> w_OUT_FSM_2
	 );	

	--
	-- INSTANCIALIZAÇÃO DA MEMÓRIA RAM
	--
	U1_RAM : RAM 
	 Generic Map(
		p_DATA_WIDTH => p_DATA_WIDTH,
		p_ADD_WIDTH  => p_ADD_WIDTH
	 )
    Port Map ( 
		i_CLK  => i_CLK,
		i_RST  => i_RST,
		i_WE   => w_WE,
		I_EN   => w_EN,
		i_DIN => w_DIN,
		i_ADDRESS => W_ADDR,
		o_DOUT => w_DOUT

	 );
	
	
	--
	-- INSTANCIALIZAÇÃO CONVEROSOR BCD
	--
	
	U2_BCD0: conversor_bcd    --bom
		GENERIC MAP(
			t_IN => p_DATA_WIDTH,
			t_OUT => p_BCD_OUT
		)
	PORT MAP(
		i_D	=> w_OUT_FSM_2,
		o_Q   => o_DISPLAY_2
		);
	
	U3_BCD1: conversor_bcd    --regular
		GENERIC MAP(
			t_IN => p_DATA_WIDTH,
			t_OUT => p_BCD_OUT
		)
	PORT MAP(
		i_D	=> w_OUT_FSM_1,
		o_Q   => o_DISPLAY_1
		);
		
	U4_BCD2: conversor_bcd    --ruim
		GENERIC MAP(
			t_IN => p_DATA_WIDTH,
			t_OUT  => p_BCD_OUT
		)
	PORT MAP(
		i_D	=> w_OUT_FSM_0,
		o_Q   => o_DISPLAY_0
		);
	
end Behavioral;
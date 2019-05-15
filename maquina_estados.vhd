LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY maquina_estados is
    Generic(
        p_DATA_WIDTH  	 : INTEGER := 10;
        p_ADDR_WIDTH  	 : INTEGER := 6
    );
   Port ( 
        i_CLK 	    		 : in  STD_LOGIC;
        i_RST       		 : in  STD_LOGIC;
        --
        -- COMANDOS DA MEMÓRIA RAM
        --
        o_EN				 : OUT STD_LOGIC;
        o_WE				 : OUT STD_LOGIC;
        o_ADDRESS			 : OUT STD_LOGIC_VECTOR(p_ADDR_WIDTH-1 DOWNTO 0);
        i_DATA			 	 : IN STD_LOGIC_VECTOR(p_DATA_WIDTH-1 DOWNTO 0);
        o_DATA				 : OUT STD_LOGIC_VECTOR(p_DATA_WIDTH-1 DOWNTO 0);
        --
        -- INPUT
        --
        i_BOM  			 : in  STD_LOGIC;
        i_RUIM  			 : in  STD_LOGIC;
        i_REGULAR			 : in  STD_LOGIC;

        i_CHECK_BOM		 : IN STD_LOGIC;
        i_CHECK_RUIM	 	 : in  STD_LOGIC;
        i_CHECK_REGULAR  : in STD_LOGIC;
        --
        -- OUTPUT
        --
        o_DISPLAY_0		: out STD_LOGIC_VECTOR(9 downto 0);
        o_DISPLAY_1		: out STD_LOGIC_VECTOR(9 downto 0);
        o_DISPLAY_2		: out STD_LOGIC_VECTOR(9 downto 0)
    );
   end maquina_estados;


architecture behavioral of maquina_estados is
   component div
		PORT
		(
			denom		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			numer		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			quotient		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			remain		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
   type w_State_Type is ( st_IDLE,  
								  st_RBOM,  st_WBOM, 
								  st_RREGULAR,  st_WREGULAR, 
								  st_RRUIM,  st_WRUIM,
								  st_RCHECK_BOM, st_WCHECK_BOM,
								  st_RCHECK_REGULAR, st_WCHECK_REGULAR,
								  st_RCHECK_RUIM, st_WCHECK_RUIM,
								  st_RATIO_BOM
								);
									
   attribute syn_enconding : string;
   attribute syn_enconding of w_State_Type : type is "safe";
	 
   SIGNAL w_STATE   : w_State_Type;
	SIGNAL w_check_bom : STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
	SIGNAL w_check_REGULAR : STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
	SIGNAL w_check_RUIM : STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
	SIGNAL w_SUM      : STD_LOGIC_VECTOR ((p_DATA_WIDTH-1) downto 0);
	SIGNAL w_CONT 		: STD_LOGIC_VECTOR (2 downto 0);
	SIGNAL w_RESULT   :STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL w_REMAIN   :STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL w_DENOM    :STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL w_NUMER    :STD_LOGIC_VECTOR(31 downto 0);
	
begin

	div_inst : div PORT MAP (
		denom	 => w_DENOM,
		numer	 => w_NUMER,
		quotient	 => w_RESULT,
		remain	 => w_REMAIN
	);


   U_MACHINE : PROCESS(i_CLK, i_RST)
	BEGIN
		IF (i_RST = '0') THEN
			o_EN <= '1';
			o_WE <= '1';
			w_SUM <= (others => '0');
			w_STATE    <= st_IDLE;
		ELSIF rising_edge (i_CLK) THEN
			CASE w_STATE IS
				WHEN st_IDLE =>
					o_WE <= '1';
					o_EN <= '1';
					--w_SUM <= (others => '0');
					w_CONT <= (others => '0');
					IF (i_CHECK_BOM = '1' ) THEN
						o_WE <= '1';
						o_EN <= '0';
						o_ADDRESS <= "000000";
						w_STATE <= st_RCHECK_BOM;
					ELSIF (i_CHECK_REGULAR = '1') THEN
					ELSIF (i_CHECK_RUIM = '1') THEN 
					ELSIF (i_BOM = '1') THEN
						o_EN <= '0';
						o_WE <= '1';
						o_ADDRESS <= "000000";
						w_STATE <= st_RBOM;
					ELSIF (i_REGULAR = '1') THEN
						o_EN <= '0';
						o_WE <= '1';
						o_ADDRESS <= "000001";
						w_STATE <= st_RREGULAR;
					ELSIF (i_RUIM = '1') THEN
						o_EN <= '0';
						o_WE <= '1';
						o_ADDRESS <= "000010";
						w_STATE <= st_RRUIM;
					ELSE 
						w_STATE <= st_IDLE;
					END IF;
				
				WHEN st_RBOM  =>
					o_ADDRESS <= "000000";
					w_SUM  <= i_DATA + 1;
					o_WE <= '0';
					w_STATE <= st_WBOM;
				WHEN st_WBOM => 
					o_ADDRESS <= "000000";
					o_DATA <= w_SUM;
					o_DISPLAY_0 <= w_sum;
					w_STATE <= st_IDLE;
					
				WHEN st_RREGULAR  =>
				   o_ADDRESS <= "000001";
				   w_SUM  <= i_DATA + 1;
				   o_WE <= '0';
				   w_STATE <= st_WREGULAR;
				WHEN st_WREGULAR => 
					o_ADDRESS <= "000001";
					o_DATA <= w_SUM;
					o_DISPLAY_1 <= w_sum;
					w_STATE <= st_IDLE;		
					
				WHEN st_RRUIM  =>
				   o_ADDRESS <= "000010";
					w_SUM  <= i_DATA + 1;
				   o_WE <= '0';
					w_STATE <= st_WRUIM;
				WHEN st_WRUIM => 
					o_ADDRESS <= "000010";
					o_DATA <= w_SUM;
					o_DISPLAY_2 <= w_sum;
					w_STATE <= st_IDLE;	
					
				WHEN st_RCHECK_BOM =>
					if w_cont = "00" THEN
						o_ADDRESS <= "000000";
						w_check_bom <= i_DATA;
						w_SUM <= i_DATA + w_SUM;
						w_cont <= w_cont + '1';
						w_STATE <= st_RCHECK_BOM;
					elsif w_cont = "01" THEN
						o_ADDRESS <= "000001";
						w_SUM <= i_DATA + w_SUM;
						w_cont <= w_cont + '1';
						w_STATE <= st_RCHECK_BOM;
					else 	
						o_ADDRESS <= "000010";
						w_SUM <= i_DATA + w_SUM;
						w_cont <= (OTHERS => '0');
						w_STATE <= st_RATIO_BOM;
					END IF;
				WHEN st_RATIO_BOM => 
					w_DENOM <= "0000000000000000000000" & w_SUM;
					w_NUMER <= w_check_bom *("0000000000000001100100");
					w_STATE <= st_IDLE;
				WHEN OTHERS =>
					w_STATE <= st_IDLE;
			END CASE;

        END IF;
		END PROCESS;
    
end behavioral ; 
   
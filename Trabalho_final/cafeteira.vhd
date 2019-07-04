library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY cafeteira is
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
	END cafeteira;
	
architecture behavioral of cafeteira is
	
	BEGIN
	U_CAFETEIRA : PROCESS (i_CAFE, i_CAFEL, i_MOCA, i_TAM, i_ACUCAR,  i_TEMPAGUA, i_NVAGUA, i_REPO,  i_PREP) BEGIN
		IF (i_RST = '1') THEN
			IF (i_CAFE = '1' OR i_CAFEL = '1' OR i_MOCA = '1') THEN
				IF (i_CAFE = '1') THEN
					o_CAFEL <= '0';
					o_MOCA  <= '0';
					o_CAFE  <= '1';
				END IF;
				
				IF (i_CAFEL = '1') THEN
					o_CAFEL <= '1';
					o_MOCA  <= '0';
					o_CAFE  <= '0';
				END IF;
				
				IF (i_MOCA= '1') THEN
					o_CAFEL <= '0';
					o_MOCA  <= '1';
					o_CAFE  <= '0';
				END IF;
			ELSE
				o_CAFEL <= '0';
				o_MOCA  <= '0';
				o_CAFE  <= '0';
			END IF;
			
			IF (i_TAM = '1') THEN
				o_TAM <= '1';
			ElSE 
				o_TAM <= '0';
			END IF;
			
			IF (i_ACUCAR = '1') THEN
				o_ACUCAR <= '1';
			ElSE 
				o_ACUCAR <= '0';
			END IF;
				
			IF (i_REPO = '1') THEN
				o_REPO <= '1';
			ElSE 
				o_REPO <= '0';
			END IF;
			
			IF (i_NVAGUA = '1') THEN
				o_NVAGUA <= '1';
			ElSE 
				o_NVAGUA <= '0';
			END IF;
			
			IF (i_TEMPAGUA = '1') THEN
				o_TEMPAGUA <= '1';
			ElSE 
				o_TEMPAGUA <= '0';
			END IF;
			
			IF (i_PREP = '1') THEN
				o_PREPARO <= o_CAFE & o_CAFEL & o_MOCA & o_TAM & o_ACUCAR;
			ElSE 
				o_PREPARO <= (OTHERS => '0');
			END IF;
		ELSE 
			o_CAFEL    <= '0';
			o_MOCA     <= '0';
			o_CAFE     <= '0';
			o_ACUCAR   <= '0';
			o_TAM      <= '0';
			o_REPO     <= '0';
			o_NVAGUA   <= '0';
			o_TEMPAGUA <= '0';
			o_PREPARO  <= (OTHERS => '0');
		END IF;
	END PROCESS;
end behavioral;
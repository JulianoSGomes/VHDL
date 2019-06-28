----------------------------------------------------------------
--       																	  --
-- Conta ate um determinado  tempo, o qual  Ã© passado em bits --
--																				  --
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY contador is
    Generic(
        p_DATA_WIDTH  	 : INTEGER := 5	
    );
   Port ( 
         i_CLK 	      : IN STD_LOGIC;
         i_RST	    		: IN STD_LOGIC;
			i_EN 				: IN STD_LOGIC;
         i_DATA			: IN STD_LOGIC_VECTOR(p_DATA_WIDTH DOWNTO 0);

        o_DATA				: OUT STD_LOGIC
    );
END contador;


architecture behavioral of contador is
	type w_State_Type is (st_IDLE,  st_RUN);
	attribute syn_enconding : string;
	attribute syn_enconding of w_State_Type : type is "safe";
	
	SIGNAL w_CONT     : STD_LOGIC_VECTOR (27 DOWNTO 0 ); --Conta clocks
	SIGNAL w_CONT_SEC : STD_LOGIC_VECTOR (5 DOWNTO 0 ); -- Conta segundos 
	SIGNAL w_STATE    : w_State_Type;
	SIGNAL w_RST      : STD_LOGIC;
	
	
	BEGIN 

	U_CONTADOR : PROCESS(i_CLK) BEGIN		
		IF (i_RST = '0') THEN
			w_CONT     <= (OTHERS => '0');
			w_CONT_SEC <= (OTHERS => '0');
			o_DATA 	  <= '0';
			w_STATE    <= st_IDLE;
			
		ELSIF rising_edge (i_CLK) THEN
			CASE w_STATE IS
				WHEN st_IDLE =>
					IF (i_EN = '1' AND w_CONT_SEC < i_DATA)  THEN
						w_STATE <= st_RUN;
					ELSE
						w_STATE <= st_IDLE;
					END IF;
				WHEN st_RUN  =>
					w_CONT <= w_CONT + 1;
				   IF  (w_CONT = "00000000000000000000000001") THEN
					--IF  (w_CONT = "10111110101111000010000000") THEN
						w_CONT_SEC <= w_CONT_SEC + 1;
						w_CONT <= (OTHERS => '0');
						IF (w_CONT_SEC = i_DATA) THEN 
							o_DATA <= '1';
							w_STATE <= st_IDLE;
						END IF;
					ELSE 
						w_STATE <= st_RUN;
					END IF;	
				WHEN OTHERS =>
					w_STATE <= st_IDLE;
			END CASE;
		END IF;

	END PROCESS;	


end behavioral;


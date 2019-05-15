LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


ENTITY contador is
    Generic(
        p_DATA_WIDTH  	 : INTEGER := 10;
        p_DATA_IN_WIDTH  : INTEGER := 31
    );
   Port ( 
        i_CLK 	    		 : in STD_LOGIC;
        i_RST	    		 : in STD_LOGIC;
		  i_EN				 : in STD_LOGIC;
									
        i_DATA			 	 : IN STD_LOGIC_VECTOR(p_DATA_IN_WIDTH DOWNTO 0);

        o_DISPLAY_0		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
        o_DISPLAY_1		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0);
        o_DISPLAY_2		: out STD_LOGIC_VECTOR((p_DATA_WIDTH-1) downto 0)
    );
	END contador;


architecture behavioral of contador is
	type w_State_Type is (st_IDLE,  st_RUN);
	attribute syn_enconding : string;
	attribute syn_enconding of w_State_Type : type is "safe";
	
	SIGNAL w_STATE      : w_State_Type;
	SIGNAL w_CONT : STD_LOGIC_VECTOR ( p_DATA_IN_WIDTH downto 0); 
	SIGNAL w_CONT1 : STD_LOGIC_VECTOR (3 downto 0); 
	SIGNAL w_CONT2 : STD_LOGIC_VECTOR (3 downto 0); 
	SIGNAL w_CONT3 : STD_LOGIC_VECTOR (3 downto 0); 
	SIGNAL w_CONT4 : STD_LOGIC_VECTOR (3 downto 0); 
	SIGNAL w_DATA : STD_LOGIC_VECTOR (p_DATA_IN_WIDTH downto 0); 
	
	
	BEGIN 
	
	U_CONTADOR : PROCESS BEGIN	
		IF (i_RST = '0') THEN
			w_CONT <= (others => '0');
			w_CONT1 <= (others => '0');
			w_CONT2 <= (others => '0');
			w_CONT3 <= (others => '0');
			w_CONT4 <= (others => '0');
		ELSIF rising_edge(i_CLK) THEN
			CASE w_STATE IS
				WHEN st_IDLE => 
					IF (i_EN = '1') THEN 
						w_DATA <= i_DATA;
						w_STATE <= st_RUN;
					ELSE 
						w_STATE <= st_IDLE;
					END IF;
				WHEN st_RUN =>		
					w_CONT <= w_CONT + '1';
					IF (w_CONT = w_DATA) THEN
						o_DISPLAY_2 <= w_CONT1;
						o_DISPLAY_1 <= w_CONT2;
						o_DISPLAY_0 <= w_CONT3;
						w_STATE <= st_IDLE;
					ELSE
						w_CONT1 <= w_CONT + '1';
						IF (w_CONT = "1001") THEN
							w_CONT  <= (others => '0');
							w_CONT2 <= w_CONT2 + 1;
							IF (w_CONT2 = "1001") THEN
								w_CONT2 <= (others => '0');
								w_CONT3 <= w_CONT3 + 1;
								IF (w_CONT3 = "1001") THEN
									w_CONT3 <= (others => '0');
									w_CONT4 <= w_CONT4 + 1;
									IF (W_CONT4 = "1001") THEN
										w_CONT4 <= (others => '0');
									ELSE 
										NULL;
									END IF;
								END IF;
							END IF;
						END IF;
					END IF;
				WHEN OTHERS =>
					w_STATE <= st_IDLE;
			END CASE;
		END IF;
	END PROCESS;	
end behavioral;
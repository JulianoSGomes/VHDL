LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY conversor_bcd IS
	
	GENERIC(
		t_IN : integer := 10;
		t_OUT : integer := 8
	);
	
	PORT(
		i_D    : IN STD_LOGIC_VECTOR (t_IN - 1 DOWNTO 0);
		o_Q    : OUT STD_LOGIC_VECTOR (t_OUT - 1 DOWNTO 0)
		);
	
	END conversor_bcd;
	
ARCHITECTURE behavioral of conversor_bcd IS
	
	Begin
	U_CONVERSOR : PROCESS (i_D)
	BEGIN 
	 
		IF (i_D = "0000000000") THEN      --0
			o_Q <= "00000011";
		ELSIF (i_D = "0000000001") THEN   --1
			o_Q <= "10011111";
		ELSIF (i_D = "0000000010") THEN  --2
			o_Q <= "00100101";
		ELSIF (i_D = "0000000011") THEN  --3 
			o_Q <= "00001101";
		ELSIF (i_D = "0000000100") THEN  --4 
			o_Q <= "10011001";
		ELSIF (i_D = "0000000101") THEN  --5 
			o_Q <= "01001001";
		ELSIF (i_D =  "0000000110") THEN --6
			o_Q <= "01000001";
		ELSIF (i_D = "0000000111") THEN  --7		
			o_Q <= "00011111";			
		ELSIF (i_D = "0000001000") THEN  --8
			o_Q <= "00000001";		
		ELSIF (i_D = "0000001001") THEN --9
			o_Q <= "00001001";
		ELSIF (i_D = "0000001010") THEN --U
			o_Q <= "10000011";
		ELSIF (i_D = "0000001011") THEN --d
			o_Q <= "10000101";
		ELSIF (i_D = "0000001100") THEN --n
			o_Q <= "11010101";
		ELSIF (i_D = "0000001101") THEN --E
			o_Q <= "01100001";
		ELSIF (i_D = "0000001110") THEN --.
			o_Q <= "11111110";
		ELSIF (i_D = "0000001111") THEN --8.
			o_Q <= "00000000";
		ELSIF (i_D = "0000010000") THEN --display apagado
			o_Q <= "11111111";
		ELSE
			o_Q <= "00000011";
				
		END IF;
	END PROCESS;
END behavioral;
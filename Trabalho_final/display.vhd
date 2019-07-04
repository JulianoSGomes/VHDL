library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY display is
		GENERIC(
			t_IN : integer := 10;
			t_OUT : integer := 8
		);

   Port ( 
		i_DATA     : IN STD_LOGIC;
		i_RST      : IN STD_LOGIC;
		

		o_DISPLAY0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_DISPLAY1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_DISPLAY2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		o_DISPLAY3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)

    );
	END display;
	
architecture behavioral of display is
	
	COMPONENT conversor_bcd IS
	
		GENERIC(
			t_IN : integer := 10;
			t_OUT : integer := 8
		);
		
		PORT(
			i_D    : IN STD_LOGIC_VECTOR (t_IN - 1 DOWNTO 0);
			o_Q    : OUT STD_LOGIC_VECTOR (t_OUT - 1 DOWNTO 0)
			);
		
	END COMPONENT conversor_bcd;
	
	SIGNAL w_DISPLAY0 : STD_LOGIC_VECTOR(t_IN - 1 DOWNTO 0);
	SIGNAL w_DISPLAY1 : STD_LOGIC_VECTOR(t_IN - 1 DOWNTO 0);
	SIGNAL w_DISPLAY2 : STD_LOGIC_VECTOR(t_IN - 1 DOWNTO 0);
	SIGNAL w_DISPLAY3 : STD_LOGIC_VECTOR(t_IN - 1 DOWNTO 0);
	
					
	BEGIN
	
	DISPLAY0 : conversor_bcd
	PORT MAP(
  		i_D  => w_DISPLAY0,      
	
		o_Q  => o_DISPLAY0
	);
	
	DISPLAY1 : conversor_bcd
	PORT MAP(
  		i_D  => w_DISPLAY1,      
	
		o_Q  => o_DISPLAY1
	);
	
	DISPLAY2 : conversor_bcd
	PORT MAP(
  		i_D  => w_DISPLAY2,      
	
		o_Q  => o_DISPLAY2
	);
	
	DISPLAY3 : conversor_bcd
	PORT MAP(
  		i_D  => w_DISPLAY3,      
	
		o_Q  => o_DISPLAY3
	);
	
	-- data 0 =  WAIT
	-- data 1 = done
	
	U_CAFETEIRA : PROCESS (i_DATA, i_RST) BEGIN
		IF (i_RST = '1') THEN
			IF (i_DATA = '0') THEN
				w_DISPLAY0 <= "0000001010";
				w_DISPLAY1 <= "0000001111";
				w_DISPLAY2 <= "0000001110";
				w_DISPLAY3 <= "0000001110";
			ELSE
				w_DISPLAY0 <= "0000001011";
				w_DISPLAY1 <= "0000000000";
				w_DISPLAY2 <= "0000001100";
				w_DISPLAY3 <= "0000001101";
			END IF;
		ELSE
			w_DISPLAY0 <= "0000010000";
			w_DISPLAY1 <= "0000010000";
			w_DISPLAY2 <= "0000010000";
			w_DISPLAY3 <= "0000010000";
		END IF;
	END PROCESS;
end behavioral;
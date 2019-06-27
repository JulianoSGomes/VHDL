library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
   
   
   
entity RAM is 
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
end RAM; 
   
   
architecture Behavioral of RAM is 
      type RAM_TYPE is array(0 TO ((2**p_ADD_WIDTH)-1)) of std_logic_vector(o_DOUT'range); 
      signal w_RAM : RAM_TYPE := ((others=> (others=>'0')));  -- Inicializa os Arrays com valores zero (0).
      signal w_ADDRESS	: STD_LOGIC_VECTOR(i_ADDRESS'range); 
		
begin 
	w_ADDRESS <= i_ADDRESS;
-- -----------------------------------------------------
-- Codigo de maquina: 
-- -----------------------------------------------------
	U_RAM : process(i_CLK) 
	begin 
		
      if falling_edge (i_CLK) then 
          if (i_RST = '0') then 
              o_DOUT <= (others=>'0'); 
          else 
              if ((i_EN = '0') and (i_WE = '1'))then 			-- É uma leitura na RAM.
						o_DOUT <= w_RAM(conv_integer(w_ADDRESS)); 
              elsif ((i_EN = '0') and (i_WE = '0'))then 		-- É uma escrita na RAM.
						w_RAM(conv_integer(w_ADDRESS)) <= i_DIN;
              end if; 
          end if; 
      end if; 
	end process U_RAM; 
   
end Behavioral;            

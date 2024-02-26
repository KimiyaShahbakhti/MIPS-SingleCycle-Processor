library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity alu is
    generic (
        nbit_width : integer := 32
    );
    Port (
        opcode : in std_logic_vector(2 downto 0);
        input1, input2 : in std_logic_vector(nbit_width-1 downto 0); 
        result : out std_logic_vector(nbit_width-1 downto 0); 
        zero : out std_logic 
    );
end alu;

architecture BEHAV of alu is
    signal temp_result : std_logic_vector(nbit_width downto 0);
begin
   --with opcode select
     --   temp_result <= ('0' & input1) + ('0' & input2) when "011",  -- Addition
        --               ('0' & input1) - ('0' & input2) when "100",  -- Subtraction
                   --    input1 and input2 when "101",  -- AND
       --              input1 or input2 when "110",   -- OR
                   --    ('0' & input1) + ('0' & input2) when "001",  -- calculate address for LW / SW
                   --    ('0' & input1) + ('0' & input2) when others;  -- addi
--
    --zero <= '1' when (temp_result = '0' & x"00000000") else '0';

   -- result <= temp_result(nbit_width-1 downto 0);  -- ignore the carry



	process(opcode, input1,input2) -- may need to change
            begin
                case opcode is
                    when "011" => -- addition 
                        temp_result <= ('0' & input1) + ('0' & input2);
			zero <= '0';

                    when "100" => -- subtraction 
                        temp_result <= ('0' & input1) - ('0' & input2);
			zero <= '0';

                    when "101" => -- and
                        temp_result <= input1 and input2;
			zero <= '0';
		   
		    when "110" => -- or
                        temp_result <= input1 or input2;
			zero <= '0';

                    when "001" => -- lw sw 
                        temp_result <=  ('0' & input1) + ('0' & input2);
			zero <= '0';

		    when "111" => 
			temp_result <= ('0' & input1) + ('0' & input2);
                        zero <= '0';

                    when others => 
			zero <= '1';
                end case;

                
        end process;
 result <= temp_result(nbit_width-1 downto 0);
end BEHAV;


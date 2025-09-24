----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2025/09/17 17:18:09
-- Design Name: 
-- Module Name: hw1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hw1 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           count1_o : out STD_LOGIC_VECTOR(7 downto 0);
           count2_o : out STD_LOGIC_VECTOR(7 downto 0));
end hw1;

architecture Behavioral of hw1 is
signal count1 :  STD_LOGIC_VECTOR(7 downto 0);
signal count2 :  STD_LOGIC_VECTOR(7 downto 0);

signal first_cycle : STD_LOGIC := '1';
signal first_cycle1 : STD_LOGIC := '1';

type FSM_STATE is (s0, s1);
signal state: FSM_STATE;

begin

count1_o <= count1;
count2_o <= count2;

FSM: process(clk, rst, count1, count2)
begin
    if rst = '0' then
        state <= s0;
    elsif clk'event and clk='1' then
        case state is
            when S0 =>
                if count1 = "0000"&"1000" then
                    state <= s1;
                end if;
            when S1 =>
                if count2 = "0101"&"0000" then
                    state <= s0;
                end if;
            when others =>
                 state <= s0;
        end case;
    end if;
end process FSM;

counter1: process(clk, rst, state)
begin
    if rst = '0' then
        count1 <= "0000"&"0000";
         first_cycle1 <= '1';
    elsif clk'event and clk='1' then
        case state is
            when S0 =>
               if first_cycle1 = '1' then
                    count1 <= count1;
                    first_cycle1 <= '0';
                else
                    count1 <= count1+1;
                end if;
            when S1 =>
                count1 <= "0000"&"0000";
                 first_cycle1 <= '1';
            when others =>
                count1 <= (others => '0');
         end case;
      end if;
end process counter1;

counter2: process(clk, rst, state)
begin
    if rst = '0' then
        count2 <= "1111"&"1101";
        first_cycle <= '1';
    elsif clk'event and clk='1' then
        case state is
            when S0 =>
                count2 <= "1111"&"1101";
                first_cycle <= '1';
            when S1 =>
                if first_cycle = '1' then
                    count2 <= count2;
                    first_cycle <= '0';
                else
                    count2 <= count2-1;
                end if;
            when others =>
                count2 <= "11111101";
         end case;
     end if;
end process counter2;

end Behavioral;
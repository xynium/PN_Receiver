create_clock -period 8.000 -name AClk [get_ports adc_clk_p_i]

#set_input_delay -max 3.400 -clock AClk [get_ports adc_dat_a_i[*]]
#set_input_delay -max 3.400 -clock AClk [get_ports adc_dat_b_i[*]]

#set_false_path -from [get_clocks FCLK_CLK0] -to [get_clocks AClk]
#set_false_path -from [get_clocks AClk] -to [get_clocks FCLK_CLK0]
#set_clock_groups -asynchronous -group {adc_clk dac_clk} 

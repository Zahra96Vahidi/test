module top ( o_single_data , sck , cs , en , svn , i_single_data , clk_24M , s , pb ) ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
output wire o_single_data , sck , cs ;
output wire [ 6 : 0 ] svn ;
output wire [ 3 : 0 ] en ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input wire i_single_data , clk_24M , pb ;
input wire [ 7 : 0 ] s ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
wire clk_16M , clk_32M , set_rst_flag ;
wire [ 15 : 0 ] data ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ADC128S102 first ( o_single_data , data , sck , cs , i_single_data , clk_32M , set_rst_flag , clk_16M , s ) ;
svn_sgmnt second ( en , svn , clk_16M , data ) ;
dcm_clk third ( clk_24M , no_use , clk_16M , clk_32M ) ;
debouncer_module fourth ( set_rst_flag , pb , clk_16M ) ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule 
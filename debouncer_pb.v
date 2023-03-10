`timescale 1ns / 1ns
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module debouncer_module ( set_rst_flag , pb , clk_16M ) ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
output set_rst_flag ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input pb , clk_16M ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
reg set_rst_flag = 1'b0 ;
reg set_flag = 1'b1 ;
reg rst_flag = 1'b1 ; 
reg [17:0] counter ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @ ( posedge clk_16M )

	begin
	
	if ( pb == 1'b0 )
	
		begin
		
		if ( ( set_rst_flag == 1'b0 ) && ( rst_flag == 1'b1 ) )
			
			begin
			
			if ( counter < { 2'b10 , 16'h7100 } )
				
				counter <= counter + 18'b1 ;
				
			else
			
				begin
			
				counter <= 18'b0 ;
				set_rst_flag <= 1'b1 ;
				set_flag <= 1'b0 ;
				
				end
				
			end
			
		else	if ( ( set_rst_flag == 1'b1 ) && ( set_flag == 1'b1 ) )
		
			begin
			
			if ( counter < { 2'b10 , 16'h7100 } )
				
				counter <= counter + 18'b1 ;
				
			else
			
				begin
			
				counter <= 18'b0 ;
				set_rst_flag <= 1'b0 ;
				rst_flag <= 1'b0 ;
				
				end
				
			end
		
		end
		
	else
		
		begin
		
		counter <= 18'b0 ;
		set_flag <= 1'b1 ;
		rst_flag <= 1'b1 ;
			
		end
			
	end
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule 
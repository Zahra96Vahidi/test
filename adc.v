`timescale 1ns / 1ns
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module ADC128S102 ( o_single_data , data_0 , data_1 , sck , cs , i_single_data , clk_32M , enable , clk_16M , s ) ; 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
output reg [ 1 : 0 ] o_single_data = 2'b00 , cs = 2'b11 , sck = 2'b11  ;
output reg [ 15 : 0 ] data_0 = 16'b0 , data_1 = 16'b0 ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input wire clk_32M , enable , clk_16M ;
input wire [ 1 : 0 ] i_single_data ;
input wire [ 7 : 0 ] s ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
reg [ 15 : 0 ] conversion_data_0 = 16'b0 , conversion_data_1 = 16'b0 ;
reg [ 3 : 0 ] counter = 4'b0000 ; 
reg [ 2 : 0 ] address = 3'b000 ;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @ ( clk_16M or enable or cs )

	begin
	
	if ( enable == 1'b1 )
		
		begin
		
		if ( cs == 2'b0 )
		
			begin
		
			sck = { 2 { clk_16M } } ;
			
			end
			
		else
		
			sck = 2'b11 ;
			
		end

	else
		
		sck = 2'b11 ;
	
	end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @ ( negedge clk_32M )

	begin
	
	if ( enable == 1'b1 )
	
		begin 
		
		if ( cs == 2'b11 )
			
			begin
			
			if ( clk_16M == 1'b1 )
			
				cs <= 2'b0 ;
				
			else 
			
				cs <= 2'b11 ;
				
			end
				
		else
		
			begin
		
			if ( sck == 2'b11 )
				
				begin
								
				{ conversion_data_0 [ 4'hf - counter ] , conversion_data_1 [ 4'hf - counter ] } <= { i_single_data [ 0 ] , i_single_data [ 1 ] } ;
					
				if ( counter < 4'hf )
					
					counter <= counter + 4'b1 ;
					
				else
						
					counter <= 4'b0 ;
					{ data_0 , data_1 } <= { conversion_data_0 , conversion_data_1 } ;
					
				end
				
			else
				
				begin
							
				if ( counter == 4'b0010 )
						
					o_single_data <= { 2 { address [ 2 ] } } ;
						
			   else if ( counter == 4'b0011 )
						
					o_single_data <= { 2 { address [ 1 ] } } ;

				else if ( counter == 4'b0100 )
						
					o_single_data <= { 2 { address [ 0 ] } } ;
					
				else
						
					o_single_data <= 2'b0 ;
						
				end
							
			end
		end
	
	else
	
		begin
		
		counter <= 4'b0 ;
		cs <= 2'b11 ;
		o_single_data <= 2'b0 ;
		{ conversion_data_0 , conversion_data_1 } <= { 2 { 16'b0 } } ;
		{ data_0 , data_1 } <= { 2 { 16'b0 } } ;
		
		end
		
	end		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @ ( s or enable )
	
	begin
	
	if ( enable == 1'b1 )
	
		begin
		
		case ( s ) 
				
			8'b00000001 : address <= 3'b000 ;
			8'b00000010 : address <= 3'b001 ;
			8'b00000100 : address <= 3'b010 ;
			8'b00001000 : address <= 3'b011 ;
			8'b00010000 : address <= 3'b100 ;
			8'b00100000 : address <= 3'b101 ;
			8'b01000000 : address <= 3'b110 ;
			8'b10000000 : address <= 3'b111 ;
			default : address <= 3'b000 ;
			
		endcase
		
		end
		
	else 
		
		address <= 3'b0 ;
		
	end
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule 
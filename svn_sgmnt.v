`timescale 1ns / 1ns
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module svn_sgmnt ( en , svn , clk_16M , data ) ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
output reg [ 3 : 0 ] en ;
output reg [ 6 : 0 ] svn ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
input wire [ 15 : 0 ] data ;
input wire clk_16M ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
reg [ 15 : 0 ] count = 16'b0 ;
reg [ 1 : 0 ] count2 = 3'b0 ;
reg [ 3 : 0 ] data_in = 4'b0 ;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////     
always @ ( posedge clk_16M )

	begin
	
	if ( count < 16'hbb80 )
		
		count <= count + 16'b1 ;
		
	else
	
		begin
		
		count <= 16'b0 ;
		
		if ( count2 < 2'b11 )
		
			count2 <= count2 + 2'b1 ;
		else
		
			count2 <= 2'b0 ;
			
		end
		
	end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
always @ ( count2 or data )

	begin
	
 	{ en , data_in } <= ( count2 == 2'b0 ) ? { 4'b1110 , data [ 3 : 0 ] } : ( count2 == 2'b01 ) ? { 4'b1101 , data [ 7 : 4 ] }
	: ( count2 == 2'b10 ) ? { 4'b1011 , data [ 11 : 8 ] } : ( count2 == 2'b11 ) ? { 4'b0111 , data [ 15 : 12 ] } : { 4'b1111 , 4'b0 } ;
	
	end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	always @ ( data_in )
	
		begin
		
		case ( data_in )
		
		4'b0000 : svn <= 7'b1000000 ;
		4'b0001 : svn <= 7'b1111001 ;
		4'b0010 : svn <= 7'b0100100 ;
		4'b0011 : svn <= 7'b0110000 ;
		4'b0100 : svn <= 7'b0011001 ;
		4'b0101 : svn <= 7'b0010010 ;
		4'b0110 : svn <= 7'b0000010 ;
		4'b0111 : svn <= 7'b1111000 ;
		4'b1000 : svn <= 7'b0000000 ;
		4'b1001 : svn <= 7'b0010000 ;
		4'b1010 : svn <= 7'b0001000 ;
		4'b1011 : svn <= 7'b0000011 ;
		4'b1100 : svn <= 7'b1000110 ;
		4'b1101 : svn <= 7'b0100001 ;
		4'b1110 : svn <= 7'b0000110 ;
		4'b1111 : svn <= 7'b0001110 ;
		default : svn <= 7'b1000000 ;
		
		endcase
		
		end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
endmodule 
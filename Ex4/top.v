//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name: Xuechen Lin 
// Date: 8/6/2021
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////

//set the time scale
`timescale 1ns / 100ps

module LED_lights (rst,clk,button,colour);

	//add ports
	input clk;
	input rst;
	input button;
	

	//add registers and wires
	output reg [2:0] colour;

	//add user logic
	always @(posedge clk)
	begin 
		// check the reset to begin with
		if(rst)
			colour <= #1 3'b000;
		
		else
			begin
				if (button==0)
					begin
					if((colour == 3'b000) ||(colour == 3'b111)) 
				
					colour <= #1 3'b001;
					else
					colour <= colour;
					end
				else
							

					begin
					if(colour == 3'b110)
						colour <= 3'b001;
					else
						colour <= #1 colour + 3'b001;
					
					end
			
			
			
			end
	end 

endmodule


		

















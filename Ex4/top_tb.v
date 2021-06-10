//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name: Xuechen Lin
// Date: 8/6/2021
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;
 	
//Todo: Regitsers and wires
	reg clk;
	reg rst;
	reg button;
	reg err;
	reg [2:0] colour_prev;
	wire [2:0] colour;

//Todo: Clock generation
	initial
		begin
		    clk = 1'b0;
		    forever
		      #(CLK_PERIOD/2) clk=~clk;//flip the clock signal every half period
		end

//Todo: User logic
	initial 
	begin
	rst = 1;
	button = 0;
	//initialise an error 
		err = 0;
	    	//colour_prev = colour;
		
		forever 
		begin
			#CLK_PERIOD
			// reset is one, check if the colour is 000
			if((rst == 1) && (colour != 3'b000))
			begin
				$display("TEST FAILED");
				err = 1;
			end
			
			#CLK_PERIOD
			rst = 0;	
			colour_prev = colour;
			#CLK_PERIOD
			
			// reset is zero, check if the colour value stays the same 
			if((button == 0) && (colour_prev != colour))
			begin
				$display("TEST FAILED");
				err = 1;
			end

			#CLK_PERIOD
			button = 1;
			colour_prev = colour;
			#CLK_PERIOD
	
			//button is one, check if the colour value rises
			if((button == 1) && (colour_prev == 3'b110) && (colour != colour_prev + 1))
			begin
				$display("TEST FAILED");
				err = 1;
			end
			
			//button is zero, check if the colour value stays the same
			if ((button == 1) && (colour_prev == 3'b110) && (colour != 3'b001 ))
			begin 	
				$display("TEST FAILED");
				err = 1;
			end
			
		end
    		
		
		
	end
//Todo: Finish test, check for success
	initial begin
	  #200
	  if (err == 0)
		$display("***TEST PASSED! :) ***");
   	  $finish;
	end 	

//Todo: Instantiate counter module
	LED_lights top(
		.clk (clk),
		.rst (rst),
 		.button (button),
		.colour (colour));
 
endmodule 


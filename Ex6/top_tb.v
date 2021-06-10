//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name: Xuechen Lin
// Date: 10/6/2021
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;
 	
//Todo: Regitsers and wires
	reg clk;
	reg err;
	reg enable;
	reg [2:0] colour;
	wire [23:0] rgb;
	
//Todo: Clock generation
	initial
		begin
		    clk = 0;
		    forever
		      #(CLK_PERIOD/2) clk=~clk;//flip the clock signal every half period
		end			


//Todo: User logic
	initial 
	begin

	//initialise the variables
	err = 0;
	enable = 0;
	colour = 3'b000;

	#CLK_PERIOD
	enable = 1;
	forever begin
		#CLK_PERIOD
		
		//the one bit in the input turns to eight bits in the output with each bit in its coresponding position
		if((colour[0] != (&rgb[7:0])) || (colour[1] != (&rgb[15:8])) || (colour[2] != (&rgb[23:16])))
			begin
			$display("TEST FAILED");
			err = 1;
			end
		
		//change the input colour
		colour = colour + 3'b001;
		end
	end

	

//Todo: Finish test, check for success
	initial begin
	  #500
	  if (err == 0)
		$display("***TEST PASSED! :) ***");
   	  $finish;
	end 	

//Todo: Instantiate counter module
	RGB top(
		.clk (clk),
		.enable (enable),
		.colour (colour),
		.rgb (rgb)
		);
 





















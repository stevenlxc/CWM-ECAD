//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name: Xuechen Lin
// Date: 11/6/2021
//
// Description: A testbench module to test Ex7 - Lights Selector
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
	reg sel;
	reg button;
	reg rst;
	wire [23:0] light;
	reg [23:0] lightPrev;	
	
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
	//initialise values for err, button, rst and sel
	err = 0;
	rst = 0;
	button = 0;
	lightPrev = 24'd10;
	
	lightPrev = light;
	
	//when sel is zero, check if the ouput is always white light
	sel = 0;
	forever
	begin
	#(CLK_PERIOD*3)
	
	if (light != 24'hffffff)
		begin
		$display("TEST FAILED");
		err = 1;
		end

	button = 1;
	#(CLK_PERIOD*3)
	if (light != 24'hffffff)
		begin
		$display("TEST FAILED");
		err = 1;
		end

	sel = 1;
	rst = 1;
	#(CLK_PERIOD*3)
	if (light!= 24'h0000FF)
		begin
		$display("TEST FAILED");
		err = 1;
		end
	
	//when rst and button are both zero, check if the light stays the same
	rst = 0;
	button = 0;
	#(CLK_PERIOD*5)
	if (lightPrev != light) 
		begin
		$display("TEST FAILED");
		err = 1;
		end
	end
	
	//when button and sel are both zero, check if the system changes colour as in the defined order
	button = 1;
	forever 
	begin
		#(CLK_PERIOD*2)
		if(lightPrev == light)
			begin
			$display("TEST FAILED");
			err = 1;
			end	
	end
	end
	

//Todo: Finish test, check for success
	initial begin
	  #150
	  if (err == 0)
		$display("***TEST PASSED! :) ***");
   	  $finish;
	end 	

//Todo: Instantiate counter module
	selector top(
		.clk (clk),
		.rst(rst),
		.sel(sel),
		.button(button),
		.light(light)
		);
endmodule


	











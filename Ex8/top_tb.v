//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #8  - Simple End-to-End Design
// Student Name: Xuechen Lin
// Date: 11/6/2021
//
// Description: A testbench module to test Ex8
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;
 	
//Todo: Regitsers and wires
	reg clk_p;
	wire clk_n;
	reg rst_n;
	reg err;
	wire heating;
	wire cooling;
	reg [4:0] temp;
	
//Todo: Clock generation
	initial
		begin
		    clk_p = 0;
		    forever
		      #(CLK_PERIOD/2) clk_p=~clk_p;//flip the clock signal every half period
		end
	assign clk_n =~ clk_p;			


//Todo: User logic
	initial 
	begin

	//initialise an error
		err = 0;
		// change the input temperature
		temp = 5'd15;
			
		forever
		begin
		
		#(CLK_PERIOD*3)
		if(temp<18 && heating ==0)
			begin
			$display("TEST FAILED");
			err = 1;
			end

		if(temp>22 && cooling ==0)
			begin
			$display("TEST FAILED");
			err = 1;
			end

		if(cooling==1 && heating ==1)
			begin
			$display("TEST FAILED");
			err = 1;
			end

		end
		temp = temp + 1;
	end

//Todo: Finish test, check for success
	initial begin
	  #500
	  if (err == 0)
		$display("***TEST PASSED! :) ***");
   	  $finish;
	end 	

//Todo: Instantiate counter module
	top top_1(
		.clk_p (clk_p),
		.clk_n (clk_n),
		.rst_n (rst_n),
		.temperature_0(temp[0]),
		.temperature_1(temp[1]),
		.temperature_2(temp[2]),
		.temperature_3(temp[3]),
		.temperature_4(temp[4]),
		.heating (heating),
		.cooling (cooling)
		);
 
endmodule 

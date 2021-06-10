//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name: Xuechen Lin
// Date: 8/6/2021
//
// Description: A testbench module to test Ex5 - Air Conditioning
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
	wire heating;
	wire cooling;
	reg [4:0] temp;
	
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

	//initialise an error
		err = 0;
		
			
		forever
		begin
		#CLK_PERIOD
		// change the input temperature
		temp = $urandom_range(30,10);
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
	
	end

//Todo: Finish test, check for success
	initial begin
	  #500
	  if (err == 0)
		$display("***TEST PASSED! :) ***");
   	  $finish;
	end 	

//Todo: Instantiate counter module
	AC top(
		.clk (clk),
		.temp (temp),
 		.heating (heating),
		.cooling (cooling));
 
endmodule 







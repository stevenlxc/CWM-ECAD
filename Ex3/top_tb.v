//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name: Xuechen Lin
// Date: 8/6/2021
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;
 	
//Todo: Regitsers and wires
	reg clk;
	reg rst;
	reg change;
	reg on_off;
	reg err;
	reg [7:0] counter_prev;
	wire [7:0] counter_out;

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
		//initialise an error 
		err = 0;
	    	counter_prev = counter_out;
		
		forever 
		begin
			#CLK_PERIOD
			//on_off is one, check if the counter counts up
			if((on_off == 1) && (counter_out < counter_prev))  
			begin
				$display("TEST FAILED");
				err = 1;
			end
			
			//on_off is zero, check if the counter counts up
			if ((on_off == 0) && (counter_out > counter_prev))
			begin 	
				$display("TEST FAILED");
				err = 1;
			end
		end
    		
		// reset is one, check if the counter is zero
		if((rst == 1) && (counter_out != 0))
		begin
			$display("TEST FAILED");
			err = 1;
		end
		
		// change is zero, check if the counter value stays the same 
		if((change == 0) && (counter_out != counter_prev))
		begin
			$display("TEST FAILED");
			err = 1;
		end
		
	end
//Todo: Finish test, check for success
	initial begin
	  #50
	  if (err == 0)
		$display("***TEST PASSED! :) ***");
   	  $finish;
	end 	

//Todo: Instantiate counter module
	monitor top(
		.clk (clk),
		.rst (rst),
 		.change (change),
		.on_off (on_off),
		.counter_out (counter_out));
 
endmodule 

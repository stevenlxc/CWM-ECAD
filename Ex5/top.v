//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name: Xuechen Lin
// Date: 9/6/2021
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module AC (
	//add ports
	input clk,
	input [4:0] temperature,
	output heating,
	output cooling
	);

	//add registers and wires
	
	reg heating;
	reg cooling;

	//add user logic
	always @(posedge clk)
	begin 
		// consider the idle state
		if((heating == 0) && (cooling == 0))
			begin
			// condition to stay in the idle state
			if ((temperature>18) && (temperature<22))
				begin
				heating <= 0;
				cooling <= 0;
				end
			// condition requires heating
			if (temperature <= 19)
				begin
				heating <= 1;
				cooling <= 0;
				end
			// condition requires cooling	
			else
				begin
				heating <= 0;
				cooling <= 1;	
				end
			end
		
		// consider the cold state
		if ((heating == 1) && (cooling == 0))
			begin
			// condition requires heating
			if(temperature < 20)
				begin
				heating <= 1;
				cooling <= 0;
				end
			else
				begin
				heating <= 0;
				cooling <= 1;
				end
			end

		// consider the hot state
		if ((heating == 0) && (cooling == 1))
			begin
			// condition requires heating
			if(temperature > 20)
				begin
				heating <= 0;
				cooling <= 1;
				end
			else
				begin
				heating <= 1;
				cooling <= 0;
				end
			end
		
	end

endmodule


	















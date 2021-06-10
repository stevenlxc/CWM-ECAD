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
	input [4:0] temp,
	output heating,
	output cooling
	);

	//add registers and wires if required
	//introduce a two-bit number state to represent the status of the system
	reg [1:0] state;
	
	//define 1 means on and 0 means off
	//heating on:10   cooling on:01   nothing on(idle):00   both on(impossible):11
	assign heating = state[1];
	assign cooling = state[0];

	//add user logic
	always @(posedge clk)
	begin 
		case(state)
		//when heating is on
		2'b10 : state = temp<20 ? 2'b10 : 2'b00;
		//when the system is in idol state
		2'b00 : state = temp<=18 ? 2'b10 : temp>=22 ? 2'b01 : 2'b00;
		//when cooling is on
		2'b01 : state = temp>20 ? 2'b01 : 2'b00;
		default: state = 2'b00;
		endcase
	end
endmodule


	















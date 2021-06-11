//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name: Xuechen Lin 
// Date: 11/6/2021
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module selector(
	//add ports
	input clk,
	input sel,
	input rst,
	input button,
	output [23:0] light);
		
	//add registers and wires if required
	reg [23:0] white = 24'hffffff;
	wire [2:0] colour;
	wire [23:0] rgb;

	

	Multiplexer Multiplexer(
		.a(white),
		.b(rgb),
		.sel(sel),
		.out(light)
		);

	LED_lights LED_lights(
		.clk(clk),
		.rst(rst),
		.button(button),
		.colour(colour)
		);

	RGB_convertor RGB_converter(
		.clk(clk),
		.enable(1),
		.colour(colour),
		.rgb(rgb)
		);

endmodule



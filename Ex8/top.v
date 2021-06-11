//////////////////////////////////////////////////////////////////////////////////
// Exercise #8  - Simple End-to-End Design
// Student Name: Xuechen Lin
// Date: 11/6/2021
//
//  Description: In this exercise, you need to design an air conditioning systems
//
//  inputs:
//           rst_n, clk_n, clk_p, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk_p,
    input clk_n,
    input rst_n,
    //temperature is a five-bit input
    input temperature_0, 
    input temperature_1,
    input temperature_2,
    input temperature_3,
    input temperature_4,
    output heating,
    output cooling
     //Todo: add all other ports besides clk_n and clk_p 
   );

    

   /* clock infrastructure, do not modify */
        wire clk_ibufds;

    IBUFDS IBUFDS_sysclk (
	.I(clk_p),
	.IB(clk_n),
	.O(clk_ibufds)
);

     //wire for all the input temperatures
     wire [4:0] temperature = {temperature_4,temperature_3,temperature_2,temperature_1,temperature_0};
        

     wire clk; //use this signal as a clock for your design
     
    
     BUFG bufg_clk (
	.I  (clk_ibufds),
	.O  (clk)
      );

//Add logic here
	AC airconditioning(
	.clk(clk),
	.temperature(temperature),
	.heating(heating),
	.cooling(cooling)
	);

endmodule

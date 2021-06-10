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
	reg [4:0] temperature;
	reg flag = 1;

//Todo: Clock generation
	initial
		begin
		    clk = 0;
		    forever
		      #(CLK_PERIOD/2) clk=~clk;//flip the clock signal every half period
		end
//change the input temperature
	initial
		begin
		//initialise a random temperature
		temperature = 5'b10001;
		forever
		begin
			#CLK_PERIOD
			temperature <= flag ? (temperature + 5'b00001) : (temperature - 5'b00001);
			if((temperature>5'b11000) || (temperature<5'b10000))
				flag=~flag;

		end
		end
			


//Todo: User logic
	initial 
	begin

	//initialise an error
		err = 0;
		cooling = 0;
		heating = 0;
	
		
		forever
		begin
		//check if the cooling and heating are both on
		#CLK_PERIOD;
		if((cooling==1) && (heating==1))
		begin
			$display("TEST FAILED");
			err = 1;
		end
		end


		
		forever 
		begin
			#CLK_PERIOD;
		
		//check if the system stays in idle when temperature is between 18 and 22
		if(((temperature<5'b10110)&&(temperature>5'b10010))&&((cooling==1)||(heating==1)))
		begin
			$display("TEST FAILED");
			err = 1;
		end

		//check if the system can turn on cooling when temperature is higher than 22
		if((temperature>=5'b10110) && ((cooling==0)||(heating==1)))
		begin
			$display("TEST FAILED");
			err = 1;
		end

		//check if the system can stop cooling when temperature is lower than 20
		if((temperature<=5'b10100) && ((cooling ==1)||(heating==1)))
		begin
			$display("TEST FAILED");
			err = 1;
		end

		//check if the system can turn on heating when temperature is lower than 18
		if((temperature<=5'b10010) && ((heating==0)||(cooling==1)))
		begin
			$display("TEST FAILED");
			err = 1;
		end

		//check if the system stop heating when temperature is highter than 20
		if((temperature>=20) && ((heating==1)&&(cooling==1)))
		begin
			$display("TEST FAILED");
			err = 1;
		end	
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
	AC top(
		.clk (clk),
		.temperature (temperature),
 		.heating (heating),
		.cooling (cooling));
 
endmodule 







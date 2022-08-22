/*************************************************************************/
/****        Author         :   Eslam Hussein                         ****/
/****        Module         :   Parity_Calculator                     ****/
/****        Project Name   :   UART Transmitter                      ****/
/****        data           :   1 August 2021                         ****/
/****        Version        :   V.01                                  ****/
/*************************************************************************/


/************************ Module Definition  *****************************/ 
module Parity_Calculator  

/************************ Module Interface   *****************************/
     (
		 input  wire [7:0]DATA_IN ,
         input  wire  CLK ,
		 input  wire  RST ,
		 input  wire  Load ,
		 output wire  Parity_Bit 
     );
	 
/************************  Module Body   *********************************/
/* Signal Declaration */ 
reg [7:0] data ; 
/* Always Block */ 
always @(posedge CLK or negedge RST)
     begin
	     if(!RST)
	         begin			 
			     data <= 8'b00000000 ; 	
			 end
	     else if (Load)
		     begin
			     
	             data <= DATA_IN ;	       			 
	         end
	     else
		     begin
				 data <= data ;
			 end 
	 end
/* Assign Statement */
assign Parity_Bit = data[7] ^ data[6] ^ data[5] ^ data[4] ^ data[3] ^ data[2] ^ data[1] ^ data[0] ;

/****************************  Module End  ****************************/
endmodule
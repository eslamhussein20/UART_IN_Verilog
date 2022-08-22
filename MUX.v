/*************************************************************************/
/****        Author         :   Eslam Hussein                         ****/
/****        Module         :   Multiplexer                           ****/
/****        Project Name   :   UART Transmitter                      ****/
/****        Date           :   1 August 2021                         ****/
/****        Version        :   V.01                                  ****/
/*************************************************************************/

/************************ Module Definition  *****************************/ 
module MUX  

/************************ Module Interface   *****************************/

     (
         input  wire I_0 ,
         input  wire I_1 ,
         input  wire I_2 ,
         input  wire I_3 ,
		 input  wire [1:0]SEL ,
		 output reg OUT
     );
	 
/************************  Module Body   *********************************/
/* Always Block */ 
always @(*)
     begin
	    case(SEL)
		     2'b00 : 
			         begin
					     OUT = I_0;				 
					 end
		     2'b01 : 
			         begin
					     OUT = I_1;				 					 
					 end		
		     2'b10 : 
			         begin
					     OUT = I_2;				 					 
					 end		
		     2'b11 : 
			         begin
					     OUT = I_3;				 					 
					 end				
		endcase
	 end

/****************************  Module End  ****************************/
endmodule
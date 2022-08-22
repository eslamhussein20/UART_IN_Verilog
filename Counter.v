/*************************************************************************/
/****        Author         :   Eslam Hussein                         ****/
/****        Module         :   Counter                               ****/
/****        Project Name   :   UART Transmitter                      ****/
/****        Date           :   1 August 2021                         ****/
/****        Version        :   V.01                                  ****/
/*************************************************************************/

/************************ Module Definition  *****************************/ 
module Counter  

/************************ Module Interface   *****************************/

     (
         input wire CLK ,
		 input wire RST ,
		 input wire EN ,
		 output reg [2:0]COUNT
     );
	 
/************************  Module Body   *********************************/
/* Always Block */ 
always @(posedge CLK or negedge RST)
     begin
	     if(!RST)
	         begin			 
			     COUNT <= 3'b000 ; 	
			 end
	     else if (EN)
		     begin
	             COUNT <= COUNT + 3'b001 ;
	         end
	     else
		     begin
			     COUNT <= 3'b000 ; 	
			 end 
	 end

/****************************  Module End  ****************************/
endmodule
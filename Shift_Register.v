/*************************************************************************/
/****        Author         :   Eslam Hussein                         ****/
/****        Module         :   Shift Register                        ****/
/****        Project Name   :   UART Transmitter                      ****/
/****        Date           :   1 August 2021                         ****/
/****        Version        :   V.01                                  ****/
/*************************************************************************/


/************************ Module Definition  *****************************/ 
module  Shift_Register  

/************************ Module Interface   *****************************/
     (
		 input  wire  [7:0]DATA_IN ,
         input  wire  CLK ,
		 input  wire  RST ,
		 input  wire  Load ,
		 input  wire  SHIFT  ,
		 output wire   DATA_OUT 
     );
	 
/************************  Module Body   *********************************/
/* Signal Declaration */ 
reg [7:0] date ; 
/* Always Block */ 
always @(posedge CLK or negedge RST)
     begin
	     if(!RST)
	         begin			 
			     date <= 8'b00000000 ; 	
			 end
	     else if (Load)
		     begin
			     
	             date <= DATA_IN ;	       			 
	         end
	     else if (SHIFT)
		     begin
				 date <= date >> 1'b1 ;
			 end 
	     else 
		     begin
				 date <= date  ;
			 end 			 
	 end
/* Assign Statement */
assign DATA_OUT = date[0] ;

/****************************  Module End  ****************************/
endmodule
/*************************************************************************/
/****        Author         :   Eslam Hussein                         ****/
/****        Module         :   Control Unit                          ****/
/****        Project Name   :   UART Transmitter                      ****/
/****        Date           :   1 August 2021                         ****/
/****        Version        :   V.01                                  ****/
/*************************************************************************/


/************************ Module Definition  *****************************/ 
module  Control_Unit  

/************************ Module Interface   *****************************/
     (
		 input  wire  [2:0]COUNT ,
         input  wire  CLK ,
		 input  wire  RST ,
		 input  wire  Data_Valid ,
		 output reg   SHIFT,
		 output reg   [1:0]SEL ,
		 output reg   COUNT_EN , 
		 output reg   busy , 		 
		 output reg   Load
     );
	 
/************************  Module Body   *********************************/
/*  States Encoding  */ 
localparam  [2:0] IDLE       = 3'b000 ,
                  START      = 3'b001 ,
                  D_SH       = 3'b011 ,
                  INS_PAR    = 3'b111 ,
                  STOP       = 3'b110 ;
reg         [2:0] Current_State , Next_State ;

/* Next State Transition */ 
always @(posedge CLK or negedge RST)
     begin
	     if(!RST)
	         begin			 
			     Current_State <= IDLE ; 	
			 end	    
	     else 
		     begin
			     Current_State <= Next_State ; 	
			 end 			 
	 end
/* Next State Logic */ 	 
always @(*)
     begin
	     case(Current_State)
		     IDLE : 
			         begin
					     if (Data_Valid==1'b1)
					         begin
					 	  	     Next_State = START ;			 							 
					         end
					     else 
						     begin
							     Next_State = IDLE ;							 							 
							 end					 
					 end
		     START : 
			         begin
						 Next_State = D_SH ;							 							 	
					 end
		     D_SH : 			         
			         begin
					     if (COUNT ==3'b111)
					         begin
					 	  	     Next_State = INS_PAR ;			 							 
					         end
					     else 
						     begin
							     Next_State = D_SH ;							 							 
							 end						 

					 end
		     INS_PAR : 
			         begin
					     Next_State = STOP ;							 					
					 end					 
		     STOP : 
			         begin
						 Next_State = IDLE ;							 							 					 
					 end	
             default :
			 	     begin
						 Next_State = IDLE ;							 							 					 
					 end	
		 endcase
	 end	 
/* Output Logic */
always @(*)
     begin
         SHIFT = 1'b0 ;
         SEL = 2'b00 ;
         COUNT_EN = 1'b0 ;
         busy = 1'b0 ;	 
         Load =  1'b0 ;
	     case(Current_State)
		     IDLE : 
			         begin
					     busy = 1'b0 ;
					     SEL = 2'b00 ;
					 end
		     START : 
			         begin
					     busy = 1'b1 ;	 
                         Load = 1'b1 ;
					 	 SEL  = 2'b01 ;
					 end
		     D_SH : 
			         begin
					     busy = 1'b1 ;	 
                         COUNT_EN = 1'b1 ;
					 	 SEL  = 2'b10 ;					 
                         SHIFT = 1'b1 ;
					 end
		     INS_PAR : 
			         begin
					     busy = 1'b1 ;	 
					 	 SEL  = 2'b11 ; 
					 end					 
		     STOP : 
			         begin
					     busy = 1'b1 ;	 
					 	 SEL  = 2'b00 ; 					 
					 end
             default :
			 	     begin
				         SHIFT = 1'b0 ;
                         SEL = 2'b00 ;
                         COUNT_EN = 1'b0 ;
                         busy = 1'b0 ;	 
                         Load =  1'b0 ;
					 end						 
		 endcase
	 end



/****************************  Module End  ****************************/
endmodule
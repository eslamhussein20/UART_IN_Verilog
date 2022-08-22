/*************************************************************************/
/****        Author         :   Eslam Hussein                         ****/
/****        Module         :   UART_TX                               ****/
/****        Project Name   :   UART Transmitter                      ****/
/****        Description    :   Top Module                            ****/
/****        Date           :   1 August 2021                         ****/
/****        Version        :   V.01                                  ****/
/*************************************************************************/


/************************ Module Definition  *****************************/ 
module  UART_TX  

/************************ Module Interface   *****************************/
     (
		 input  wire  [7:0]P_DATA,
         input  wire  CLK ,
		 input  wire  RST ,
		 input  wire  Data_Valid ,
		 output wire   busy , 		 
		 output wire   S_DATA
     );
	 
/************************  Module Body   *********************************/
wire shift_w ;
wire counter_en_w ;
wire load_w ;
wire out_data_w ;
wire out_parity_bit_w ;
wire [1:0] sel_w ;
wire [2:0] count_w ;

Shift_Register  Shift_Register_A
     (
		.DATA_IN     (P_DATA)   ,
        .CLK         (CLK)   ,
		.RST         (RST)   ,
		.Load        (load_w)   ,
		.SHIFT       (shift_w)   ,
		.DATA_OUT    (out_data_w)
     );
Counter  Counter_A
     (
         .CLK     (CLK)  ,
		 .RST     (RST)  ,
		 .EN      (counter_en_w)  ,
		 .COUNT   (count_w) 
     );  
Parity_Calculator  Parity_Calculator_A
     (
	     .DATA_IN    (P_DATA) ,
         .CLK        (CLK) ,
	     .RST        (RST) ,
	     .Load       (load_w) ,
	     .Parity_Bit (out_parity_bit_w)
     );             
MUX  MUX_A
     (
        .I_0 (1'b1) ,
        .I_1 (1'b0) ,
        .I_2 (out_data_w) ,
        .I_3 (out_parity_bit_w) ,
		.SEL (sel_w) ,
		.OUT (S_DATA)
     );      
Control_Unit    Control_Unit_A
     (
		 .COUNT       (count_w) ,
         .CLK         (CLK) ,
		 .RST         (RST) ,
		 .Data_Valid  (Data_Valid) ,
		 .SHIFT       (shift_w) ,
		 .SEL         (sel_w) ,
		 .COUNT_EN    (counter_en_w) , 
		 .busy        (busy) , 		 
		 .Load        (load_w) 
     );
	 			 
/****************************  Module End  ****************************/
endmodule
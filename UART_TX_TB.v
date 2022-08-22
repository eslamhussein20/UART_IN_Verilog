/*************************************************************************/
/****        Author         :   Eslam Hussein                         ****/
/****        Module         :   UART_TX_TB                            ****/
/****        Project Name   :   UART Transmitter                      ****/
/****        Description    :   Test Bench                            ****/
/****        Date           :   5 August 2021                         ****/
/****        Version        :   V.01                                  ****/
/*************************************************************************/

`timescale 1ns/1ps
/************************ Module Definition  *****************************/ 
module  UART_TX_TB  

/************************ Module Interface   *****************************/
     (
     );
	 
/**********************        Parameters          ***********************/
localparam CLK_PERIOD = 5 ;
localparam Test_Cases = 5 ;
/**********************      Loop Variable    ****************************/
integer                       Test_Case ;
/**********************       Memories        ****************************/
reg [10:0] Test_Patterns [Test_Cases-1:0] ;
reg [10:0] Expec_Outputs [Test_Cases-1:0] ;
/**********************  Signals  Declaration ****************************/
reg [7:0] P_DATA_TB;
reg CLK_TB ;
reg RST_TB ;
reg Data_Valid_TB ;
wire Busy_TB ; 		
wire S_DATA_TB ;

/*************************** Initial Block *******************************/
initial
     begin
	     $dumpfile("UART_TX_TB.vcd");
	     $dumpvars;
		 $readmemb("Patterns_b.txt", Test_Patterns);
         $readmemb("Expected_Outputs.txt", Expec_Outputs);
	     Initialize();
		 Restart();	
         for ( Test_Case = 0; Test_Case < Test_Cases ; Test_Case = Test_Case + 1 )
             begin
                 Creat_Test_Pattern(Test_Patterns[Test_Case]) ;                       
                 Check_Out_Response(Expec_Outputs[Test_Case],Test_Case) ;           
             end
		 #(10*CLK_PERIOD)
	     $finish; 
	 end
/************************ Initialization *********************************/
task Initialize;
     begin
	     CLK_TB = 1'b0 ; 
		 RST_TB = 2'b1 ;
		 Data_Valid_TB = 1'b0 ;
	 end
endtask
/************************ Restart Task ***********************************/
task Restart ;
     begin
          RST_TB = 1'b1 ; 
          #0.01
          RST_TB = 1'b0 ;
          #0.01
          RST_TB = 1'b1 ; 
     end
endtask
/************************ create Test Pattern Task ***********************/
task Creat_Test_Pattern ;
input  [7:0]data_in ;
     begin
	     P_DATA_TB = data_in ;
		 Data_Valid_TB = 1'b1 ;		 
		 Restart();
	 end
endtask
/************************ check Response Task ****************************/
task Check_Out_Response ;
input reg [10:0]Expected_Output ;
input integer  Operation_Number ; 
integer i;
reg [10:0]Generatrd_Output ;
     begin
         @( posedge Busy_TB )
		 Data_Valid_TB = 1'b0 ;
		 for(i=0; i<11; i=i+1)
		  begin
		  	 #CLK_PERIOD 
		 	 Generatrd_Output[i] = S_DATA_TB ;

          end				 
         if(Generatrd_Output == Expected_Output) 
              begin
                  $display("  Test Case %d Is  Succeeded",Operation_Number);
              end
          else
              begin
                  $display("  Test Case %d Is  Failed"  , Operation_Number);
	          end
	 end
endtask

/************************* Clock Generator *******************************/
always 
     begin
	     #(2.5) 
	     CLK_TB = ~CLK_TB ;
	 end
/****************** Unit Under Test Instantion ***************************/	 
UART_TX  UUT 
     (
		 .P_DATA(P_DATA_TB),
         .CLK (CLK_TB),
		 .RST (RST_TB),
		 .Data_Valid (Data_Valid_TB),
		 .busy (Busy_TB), 		 
		 .S_DATA(S_DATA_TB)
     );	  	 
/****************************  Module End  *******************************/
endmodule

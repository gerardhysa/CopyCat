`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2017 04:30:17 PM
// Design Name: 
// Module Name: Top_Module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_module(input logic clk, play, 
           [3:0] satir_data,
           output logic [3:0] sutun_en,
           output logic SH_CP, ST_CP, reset, DS, OE,
           output logic dp, [7:0] KATOT, [3:0] led, [3:0] an, [6:0] seg);
           
            typedef enum logic [1:0] {S0 = 2'b00, S1=2'b01} statetype;
            statetype state = S0, nState;
           
           logic next_start;

                   
           starting_animation st1(clk, next_start,satir_data, SH_CP,ST_CP, reset, DS, OE,sutun_en, KATOT, led);
          
           
           
           
           always_ff@(posedge clk) 
              if(play)         
                   state <= S1;
                   
           
           always_comb
           begin
                             
           case(state)
           S0: begin
             next_start <= 1;       
             an <= 4'b0000;
             seg <= 7'b00000000;      
                end       
             S1: begin
             
             next_start <= 0;          
             nState <= S1;
             end
           endcase
           end
                      
endmodule

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2017 11:51:41 PM
// Design Name: 
// Module Name: main
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


module keypad_lights_matrix(input logic clk, 
           [3:0] satir_data, 
           output logic [3:0] sutun_en,
           output logic SH_CP, ST_CP, reset, DS, OE,
           output logic [7:0] KATOT);
      
            logic [23:0] msg;
            logic [7:0] red, green, blue;
            
            assign msg[23:16] = red;
             assign msg[15:8]  = green;
             assign msg[7:0]   = blue;
             
            logic slowclk;
            logic f;
            logic e;
            
            logic [26:0] counter;
            logic [8:0] index = 1; //i
            logic [6:0] frame = 0; //d
            logic [2:0] rowNum= 0; //a
            
         always@ (posedge clk) 
          counter = counter + 1;
            
           
                   
            assign f = counter[7];
            assign e = ~f;
            
            
            always @(posedge e)
                index = index + 1;
          
            
           always_comb
            begin
                if (index < 4) 
                
                    reset = 0;
               else
                    reset = 1;
            
            
                if (index > 3 && index < 28) 
                     DS = msg[index - 4];
                else 
                    DS = 0;
            
                if (index < 28)
                begin
                    SH_CP = f;                
                    ST_CP = e;
                end
               else
                 begin
                SH_CP =0;
                ST_CP =1;
                 end
            end    //of always_comb 
             
            always@ (posedge f)
            begin
                if (index > 28 && index < 409) 
                    
                    OE <= 0;
                    
            else 
                    OE <= 1;
                             
                  if (index == 410) begin
                    rowNum <= rowNum + 1;
                    if (rowNum == 7) 
                        frame <= frame + 1;
                   end     
                    
           end 
           
      
      
      
      
      
      
      
      
      
      
      
      
      
      
         logic [3:0] okunan_karakter, satir_data_buf, 
         satir_data_buf2,satir_data_buf3, satir_data_buf4, satir_data_temiz;
         
         logic hata;
               
      
           
           
           
           
           
      
          
           
                always_comb
                begin
         
               satir_data_buf     <= satir_data;
               satir_data_buf2    <= satir_data_buf;    
               satir_data_buf3    <= satir_data_buf2;    
               satir_data_buf4    <= satir_data_buf3;
               
               
               if (satir_data_buf4 == satir_data_buf3 && satir_data_buf4==satir_data_buf2 && satir_data_buf4==satir_data_buf  && satir_data_buf4==satir_data )               
               satir_data_temiz = satir_data_buf4;
               
              
           
               
               case (counter[1])                      
                3'b000: begin
                sutun_en <= 3'b0001; //sutun1
               case(satir_data_temiz) 
               4'b0001: begin hata <= 0; okunan_karakter <= 4'b0001; end //1
               4'b0010: begin hata <= 0; okunan_karakter <= 4'b0010; end //4
               4'b0100: begin hata <= 0; okunan_karakter <= 4'b0100; end //7
               4'b1000: begin hata <= 0; okunan_karakter <= 4'b1000; end //*
               default: hata <= 1;
               endcase
               end
               
           default:  sutun_en <= 4'b0000;
           endcase
           
           case(okunan_karakter)
                4'b0001:
                       KATOT<=8'b11110000;
                  4'b0010:
                        KATOT<=8'b00001111;
                     4'b0100:   
                        KATOT<=8'b00001111;
                       4'b1000: 
                        KATOT<=8'b11110000;
                  default: KATOT<=8'b0000000;
           endcase
           
          
           
           
           if (hata == 0) begin
           case (okunan_karakter) 
          // 4'b0000:  led<=7'b1000000; 
           4'b0001: begin 
             
             // KATOT <= 8'b11110000;
              red <= 8'b11110000;
              blue <= 8'b00000000;
              green <= 8'b00000000;
              end
           //led<=7'b1111001; //1
          // 4'b0010:  led<=7'b0100100;
          // 4'b0011:  led<=7'b0110000;
           4'b0010: begin  
                        red <= 8'b00000000;
                        blue <= 8'b11110000;
                        green <= 8'b00000000; 
                        end //4
           4'b0100: begin  
                          red <= 8'b00000000;
                           blue <= 8'b00000000;
                            green <= 8'b00001111; 
                             end //7
            4'b1000: begin  
                     red <= 8'b00001111;
                      blue <= 8'b00001111;
                      green <= 8'b00000000; 
                      end //*
         
           default: begin 
           red <= 8'b00000000;
                         blue <= 8'b00000000;
                         green <= 8'b00000000;
                        end
           endcase
           end
            
           end
           
           
endmodule

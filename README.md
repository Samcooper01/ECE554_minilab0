# MAC and FIFO with 7-segment display

See [ECE_554_Minilab0.pdf](ECE_554_Minilab0.pdf) for full project detials

## Project Overview
This project involves getting started with the DE1-SoC board using Quartus. The objective is to design simple digital logic in Verilog, simulate it in QuestaSim, program the DE1-SoC board using Quartus, and utilize IPs from the Quartus IP Catalog.

## Objectives
- Design simple digital logic in Verilog and simulate it in QuestaSim.
- Use Quartus to program the DE1-SoC board.
- Utilize IPs from the Quartus IP Catalog.
- Understand resource utilization reports from the Quartus synthesis tool.

## Parts
### Part 1: Custom Logic Design
- Design custom logic in Verilog/SystemVerilog.
- Write code for FIFO and Multiply-Accumulate (MAC) units.
- Perform dot product of two arrays and display the result in hex format on a 7-segment display.
- Indicate the DONE state with LED1.

### Part 2: Using IP Blocks
- Replace custom FIFO and MAC units with IP blocks from the Quartus IP Catalog.
- Utilize FIFO, LPM_MULT, and LPM_ADD_SUB IPs.

## FPGA Board Peripherals Used
- 7-Segment Display
- LEDs
- Buttons (Key 0 used as active low reset)


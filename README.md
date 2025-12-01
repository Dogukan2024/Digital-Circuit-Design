
My Youtube Video Demonstrating the Ultrasonic Relative Position Calculator
[![Video](https://img.youtube.com/vi/AQCqc1EKAgc/0.jpg)](https://youtu.be/AQCqc1EKAgc)

# Ultrasonic Relative Position Calculator (aka “Ultrasonic Pairwise Distance Measurer”)
This project creates a system of **three small “agents”** that measure how far they are from one another and form a triangle on a 2D display. Each agent uses basic distance-sensing hardware, and the Basys 3 FPGA processes the measurements and shows the result on a VGA monitor.

The idea is inspired by tiny robots that could one day locate objects or areas inside biological tissue. In this project, the concept is simplified into a game-like system where the agents measure their distances and share their positions.

The design works by:
- Triggering each pair of sensors to measure how far apart the agents are  
- Calculating the triangle formed by the three measured distances  
- Displaying the three agents and their relative positions on a VGA screen  
- Allowing a “payload mode,” where the triangle turns red when a button is pressed  

The project uses several VHDL modules:
- A top module coordinating the whole system  
- Three distance-measurement modules  
- A display module that draws the triangle on the screen  
- A VGA controller providing the timing signals for the monitor  

All parts were simulated to verify correct behavior and then programmed onto the Basys 3 board. The final output shows the three agents moving into a triangle based on their measured distances, along with a visual mode change when the payload button is activated.


=======
This project involves designing and implementing an **Arithmetic Logic Unit (ALU)** using **VHDL** as part of a digital circuit design lab. An ALU is a combinational circuit capable of performing basic arithmetic and logical operations.

The ALU in this project supports **eight functions**, including:
- Addition  
- Subtraction  
- Bitwise operations  
- Shift operations  

The design was built modularly in VHDL, simulated to verify correct functionality, and synthesized using Vivado. The final implementation was deployed on an FPGA, where the ALU outputs were displayed through onboard LEDs.

This repository contains the VHDL source files, simulation results, and related project materials.
=======
# Seven-Segment Display 

This project implements a multi-digit **seven-segment display controller** on the Basys 3 FPGA.  
Because the Basys 3 can only drive **one digit at a time**, the design uses the principle of  
**persistence of vision**, rapidly switching between displays to make all digits appear lit simultaneously.

The design includes:
- A **clock divider** to slow down the Basys 3 internal clock  
- A **counter** with a high enough refresh rate for persistence of vision  
- A **digit decoder** to activate each seven-segment display  
- A **multiplexer** to select the correct digit value  
- A VHDL implementation of the full display controller  

Simulation was run to verify the display behavior, and the final design was programmed onto the FPGA.  
Photos of the working seven-segment display are included in the project materials.



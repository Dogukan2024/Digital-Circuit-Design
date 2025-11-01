# VGA color channels (1-bit each)
set_property PACKAGE_PIN G19 [get_ports red]
set_property IOSTANDARD LVCMOS33 [get_ports red]

set_property PACKAGE_PIN J17 [get_ports green]
set_property IOSTANDARD LVCMOS33 [get_ports green]

set_property PACKAGE_PIN N18 [get_ports blue]
set_property IOSTANDARD LVCMOS33 [get_ports blue]

# Clock input (100 MHz)
set_property PACKAGE_PIN W5 [get_ports clk100]
set_property IOSTANDARD LVCMOS33 [get_ports clk100]

# Reset button (center button)
set_property PACKAGE_PIN U18 [get_ports rst_btn]
set_property IOSTANDARD LVCMOS33 [get_ports rst_btn]

# Pushbuttons for distance measurements
set_property PACKAGE_PIN T17 [get_ports btn_12]
set_property IOSTANDARD LVCMOS33 [get_ports btn_12]

set_property PACKAGE_PIN T18 [get_ports btn_13]
set_property IOSTANDARD LVCMOS33 [get_ports btn_13]

set_property PACKAGE_PIN W19 [get_ports btn_23]
set_property IOSTANDARD LVCMOS33 [get_ports btn_23]

# VGA Horizontal Sync
set_property PACKAGE_PIN P19 [get_ports hsync]
set_property IOSTANDARD LVCMOS33 [get_ports hsync]

# VGA Vertical Sync
set_property PACKAGE_PIN R19 [get_ports vsync]
set_property IOSTANDARD LVCMOS33 [get_ports vsync]

# Sensor 1 (on JB)
set_property PACKAGE_PIN A14 [get_ports echo_1]
set_property IOSTANDARD LVCMOS33 [get_ports echo_1]

set_property PACKAGE_PIN A16 [get_ports trigger_1]
set_property IOSTANDARD LVCMOS33 [get_ports trigger_1]

# Sensor 2 (on JB)
set_property PACKAGE_PIN B15 [get_ports echo_2]
set_property IOSTANDARD LVCMOS33 [get_ports echo_2]

set_property PACKAGE_PIN B16 [get_ports trigger_2]
set_property IOSTANDARD LVCMOS33 [get_ports trigger_2]

# Sensor 3 (additional sensor on JC)
set_property PACKAGE_PIN K17 [get_ports echo_3]
set_property IOSTANDARD LVCMOS33 [get_ports echo_3]

set_property PACKAGE_PIN M18 [get_ports trigger_3]
set_property IOSTANDARD LVCMOS33 [get_ports trigger_3]

# Activity indicator LEDs
set_property PACKAGE_PIN N17 [get_ports led_12]
set_property IOSTANDARD LVCMOS33 [get_ports led_12]

set_property PACKAGE_PIN P18 [get_ports led_13]
set_property IOSTANDARD LVCMOS33 [get_ports led_13]

set_property PACKAGE_PIN M19 [get_ports led_23]
set_property IOSTANDARD LVCMOS33 [get_ports led_23]

# STOP indicator LED
set_property PACKAGE_PIN U16 [get_ports led_ext]
set_property IOSTANDARD LVCMOS33 [get_ports led_ext]

set_property PACKAGE_PIN V17 [get_ports {btn_payload}]
set_property IOSTANDARD LVCMOS33 [get_ports {btn_payload}]


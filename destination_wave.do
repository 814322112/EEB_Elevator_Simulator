onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /destination_testbench/clk
add wave -noupdate /destination_testbench/SW
add wave -noupdate /destination_testbench/reset
add wave -noupdate /destination_testbench/current
add wave -noupdate /destination_testbench/direction
add wave -noupdate /destination_testbench/sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {469 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 92
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {3 ps} {1526 ps}

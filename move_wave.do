onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /move_testbench/clk
add wave -noupdate /move_testbench/sel
add wave -noupdate /move_testbench/reset
add wave -noupdate /move_testbench/KEY
add wave -noupdate /move_testbench/direction
add wave -noupdate /move_testbench/current
add wave -noupdate {/move_testbench/LEDR[3]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {560 ps} 0}
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
WaveRestoreZoom {0 ps} {4480 ps}

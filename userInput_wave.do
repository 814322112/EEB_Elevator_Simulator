onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /userInput_testbench/Clock
add wave -noupdate /userInput_testbench/reset
add wave -noupdate /userInput_testbench/in
add wave -noupdate /userInput_testbench/out
add wave -noupdate /userInput_testbench/dut/ps
add wave -noupdate /userInput_testbench/dut/ns
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {534 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {2 ns}

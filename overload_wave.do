onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /overload_testbench/reset
add wave -noupdate /overload_testbench/SW
add wave -noupdate /overload_testbench/ovld
add wave -noupdate /overload_testbench/j
add wave -noupdate /overload_testbench/dut/sum
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3883 ps} 0}
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
WaveRestoreZoom {3319 ps} {4319 ps}

puts "****Writing Verilog Block Interface****";

set modname "Up_Dn_Counter";

set in_ports       [list IN    Load Up   Down CLK];
set in_ports_width [list 4      1    1    1    1  ];

set out_ports       [list High Counter Low];
set out_ports_width [list 1    4       1  ];

puts "module $modname (";

set inputs_size  [llength $in_ports];
set output_size  [llength $out_ports];
set total_ports  [expr {$inputs_size + $output_size}];
set port_index   0;

# Print inputs
for {set index 0} {$index < $inputs_size} {incr index} {
    set name  [lindex $in_ports $index];
    set width [lindex $in_ports_width $index];
    
    incr port_index;
    set comma [expr {$port_index < $total_ports ? "," : ""}];
    
    if {$width == 1} {
        puts "    input        $name$comma";
    } else {
        puts "    input  \[[expr {$width-1}]:0\] $name$comma";
    }
}

# Print outputs
for {set index 0} {$index < $output_size} {incr index} {
    set name  [lindex $out_ports $index];
    set width [lindex $out_ports_width $index];
    
    incr port_index;
    set comma [expr {$port_index < $total_ports ? "," : ""}];
    
    if {$width == 1} {
        puts "    output       $name$comma";
    } else {
        puts "    output \[[expr {$width-1}]:0\] $name$comma";
    }
}

puts "  );"
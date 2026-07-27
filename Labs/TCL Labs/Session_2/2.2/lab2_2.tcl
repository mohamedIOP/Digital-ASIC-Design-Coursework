puts "**** File I/O & Regsub Lab****"

set fh [open Interface.txt r]
set file_data [read $fh]
close $fh

set inputPorts  {IN Load Up Down CLK}
set outputPorts {High Counter Low}

# Add i_ / o_ prefixes to the port names.
# \y matches a word boundary, so "IN" won't accidentally match inside another word.
foreach inputPort $inputPorts {
    regsub -all "\\y$inputPort\\y" $file_data "i_$inputPort" file_data
}
foreach outputPort $outputPorts {
    regsub -all "\\y$outputPort\\y" $file_data "o_$outputPort" file_data
}

# Swap the keywords
regsub -all "input" $file_data "reg" file_data
regsub -all "output" $file_data "wire" file_data

# Add a semicolon at the end of every non-empty declaration line
regsub -all {([^\n]+)\n} $file_data "\\1;\n" file_data

set fh2 [open tb.txt w]
puts $fh2 $file_data
close $fh2

puts "Done. Output written to tb.txt"
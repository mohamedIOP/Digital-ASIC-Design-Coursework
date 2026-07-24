set fh [open rtl.txt r];
set designs [read $fh];
close $fh;
puts "{[join $designs " "]}";
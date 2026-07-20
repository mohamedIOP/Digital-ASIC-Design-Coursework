puts "****Logical Operations****";
set a 5;
set b -1;
set c 0;
set var0 [expr $a && $c];
set var1 [expr $a || $b];
puts "The Content Of Var0 is $var0";
puts "The Content Of Var1 is $var1";
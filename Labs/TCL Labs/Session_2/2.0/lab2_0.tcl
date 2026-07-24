puts "**** List Operations Lab****";
set lst0 [list Jan Mar April May];
set lst1 {June July August};
puts "The Contents of lst0: $lst0";
puts "The Contents of lst1: $lst1";
puts "Length of lst0 : [llength $lst0]";
puts "Third item of lst1 : [lindex $lst1 2]";
if {[lsearch $lst1 Oct] == "-1"} {
    puts "Oct not existed in the list";
} else {
    puts "Oct is existed in the list";
}
puts "[linsert $lst0 1 Feb]";
puts "Content of lst0 : $lst0";
lappend lst1 Sep Oct Nov Dec;
puts "Content of lst1 : $lst1";
set lst2 [concat $lst0 $lst1];
puts "[lrange $lst2 0 [expr [llength $lst2] - 1]]";
puts "[join $lst2 " ,"]";
for {set index 0} { $index < [llength $lst0] } { incr index } {
    puts "[string toupper [lindex $lst0 $index]]";
}
foreach list_element $lst1 {
    puts "[string tolower $list_element]";
}
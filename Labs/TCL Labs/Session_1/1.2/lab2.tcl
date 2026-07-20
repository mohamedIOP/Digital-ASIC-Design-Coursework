puts "**** String Manipulation Lab ****";
set str1 "MahmoudAhmed@gmail.com";
set str2 "MostafaAli@hotmail.com";
set str1Length [string length $str1];
puts "The length of str1 is $str1Length";
set str1EmailNameIndex  [string first @ $str1];
puts "str1 Email Name is [string toupper [string range $str1 0 [expr $str1EmailNameIndex - 1] ] ]";
set str2EmailNameIndex  [string first @ $str2];
set str2Ending [string first .com $str2];
puts "Domain Name of str2 is [string range $str2 [expr $str2EmailNameIndex + 1] [expr $str2Ending - 1]] ";
set str1 "[string range $str1 0 $str1EmailNameIndex][string range $str2 [expr $str2EmailNameIndex + 1] end]";
puts $str1;
if {[string match *@gmail* $str1]} {
    puts "it is a gmail account";
} else {
    puts "it is not a gmail account";
}
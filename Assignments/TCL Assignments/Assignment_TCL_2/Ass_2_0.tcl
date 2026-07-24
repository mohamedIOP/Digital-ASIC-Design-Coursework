puts "****Assignment 2.0****";
set cities [list cairo alexandria damietta dakahlia faiyum sohag aswan];
set Cities_New {};
foreach City $cities {
    lappend Cities_New [string totitle $City];
}
puts "$Cities_New";
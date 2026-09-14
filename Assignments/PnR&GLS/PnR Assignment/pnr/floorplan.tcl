
################################ Variables ####################################

set load_fp 0
set top_module ALU_TOP

########### Define Aspect Ratio (Length/Width) of Digital Macro  ############

if {$load_fp == 0} {

floorPlan -d 120.13 120.13 3.0 3.0 3.0 3.0

} else {

loadFPlan ./$top_module.fp

}



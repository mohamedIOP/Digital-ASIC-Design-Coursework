
################################ Variables ####################################
set route_0_optimze_1 0

########### Global/Detialed Routing ############
set max_m_layer 6

if {$route_0_optimze_1 == 0} {
setNanoRouteMode -quiet -routeTopRoutingLayer $max_m_layer

routeDesign -globalDetail -viaOpt -wireOpt

} else {

refinePlace -preserveRouting
setNanoRouteMode -routeWithEco true
globalDetailRoute

}

import 'package:flutter/services.dart';

import 'filter_engine.dart';



class RideListener {


static const channel =
MethodChannel(
'ridebot_channel'
);



static void start(){


channel.setMethodCallHandler(
(call) async {


if(call.method=="ride_detected"){


double fare =
call.arguments[0];


double distance =
call.arguments[1];


String pickup =
call.arguments[2];



RideData ride =
RideData(

platform:"Unknown",

fare:fare,

distance:distance,

pickup:pickup,

drop:"",

);



FilterSettings settings =
FilterSettings(

minFare:100,

minPerKm:12,

maxDistance:40

);



bool accept =
RideFilterEngine()
.checkRide(
ride,
settings
);
  await RideHistoryService.saveRide(

platform:"Rapido",

fare:ride.fare,

distance:ride.distance,

pickup:ride.pickup,

drop:"",

status:

accept
?
"ACCEPTED"
:
"REJECTED"


);



return accept;


}


return null;


});


}


}

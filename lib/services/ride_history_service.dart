import '../data/database/ride_database.dart';



class RideHistoryService {



static Future<void> saveRide({

required String platform,

required double fare,

required double distance,

required String pickup,

required String drop,

required String status,


}) async{



await RideDatabase.insertRide({

"platform":platform,

"fare":fare,

"distance":distance,

"earning":

distance==0
?0
:fare/distance,


"pickup":pickup,

"drop_location":drop,

"status":status,


"time":
DateTime.now()
.toString()


});



}



}

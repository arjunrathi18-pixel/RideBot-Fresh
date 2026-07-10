class RideData {
  final String platform;
  final double fare;
  final double distance;
  final String pickup;
  final String drop;

  RideData({
    required this.platform,
    required this.fare,
    required this.distance,
    required this.pickup,
    required this.drop,
  });


  double get earningPerKm {

    if(distance == 0){
      return 0;
    }

    return fare / distance;

  }

}



class FilterSettings {


  double minFare;
  double maxFare;

  double minDistance;
  double maxDistance;

  double minPerKm;


  List<String> allowedAreas;

  List<String> blockedAreas;


  FilterSettings({

    this.minFare = 50,

    this.maxFare = 1000,

    this.minDistance = 1,

    this.maxDistance = 50,

    this.minPerKm = 10,

    this.allowedAreas = const [],

    this.blockedAreas = const [],

  });

}





class RideFilterEngine {



bool checkRide(
    RideData ride,
    FilterSettings settings
){




  // Fare Check

  if(ride.fare < settings.minFare)
  {
    return false;
  }



  if(ride.fare > settings.maxFare)
  {
    return false;
  }





  // Distance Check

  if(ride.distance < settings.minDistance)
  {
    return false;
  }



  if(ride.distance > settings.maxDistance)
  {
    return false;
  }






  // ₹ per KM Check

  if(ride.earningPerKm < settings.minPerKm)
  {
    return false;
  }







  // Block Area Check

  for(String area in settings.blockedAreas)
  {

    if(
      ride.pickup
      .toLowerCase()
      .contains(
        area.toLowerCase()
      )
    )
    {

      return false;

    }

  }






  // Allowed Area Check

  if(settings.allowedAreas.isNotEmpty)
  {


    bool found=false;


    for(String area in settings.allowedAreas)
    {

      if(
        ride.pickup
        .toLowerCase()
        .contains(
          area.toLowerCase()
        )
      )
      {

        found=true;

      }

    }


    if(!found)
    {
      return false;
    }


  }





  return true;


}




}

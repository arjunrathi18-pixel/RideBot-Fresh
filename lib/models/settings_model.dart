class RideSettings {


bool autoAccept;

double minFare;

double maxDistance;

double minPerKm;

int acceptDelay;



List<String> allowedAreas;

List<String> blockedAreas;



RideSettings({

this.autoAccept=true,

this.minFare=100,

this.maxDistance=40,

this.minPerKm=12,

this.acceptDelay=2,

this.allowedAreas=const[],

this.blockedAreas=const[],


});

}

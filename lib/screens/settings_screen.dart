import 'package:flutter/material.dart';



class SettingsScreen extends StatefulWidget{


const SettingsScreen({
super.key
});


@override
State<SettingsScreen> createState()
=>_SettingsScreenState();


}





class _SettingsScreenState
extends State<SettingsScreen>{



bool autoAccept=true;


double minFare=100;

double maxDistance=40;

double minPerKm=12;


double delay=2;




@override
Widget build(BuildContext context){



return Scaffold(


appBar:
AppBar(

title:
const Text(
"RideBot Settings"
)

),



body:
SingleChildScrollView(


padding:
const EdgeInsets.all(16),



child:
Column(

children:[



SwitchListTile(

title:
const Text(
"Auto Accept Ride"
),


value:
autoAccept,


onChanged:(v){


setState((){

autoAccept=v;


});


},

),





const SizedBox(
height:20
),





settingSlider(

"Minimum Fare",

minFare,

50,

1000,

(v){

setState((){

minFare=v;

});

}


),





settingSlider(

"Maximum Distance",

maxDistance,

5,

100,

(v){

setState((){

maxDistance=v;

});

}

),





settingSlider(

"Minimum ₹ / KM",

minPerKm,

5,

50,

(v){

setState((){

minPerKm=v;

});

}

),






settingSlider(

"Accept Delay Seconds",

delay,

0,

10,

(v){

setState((){

delay=v;

});

}

),




const SizedBox(
height:20
),




ElevatedButton(

onPressed:(){


Navigator.pop(context);


},


child:
const Text(
"Save Settings"
)

)




],


),



),


);

}




Widget settingSlider(

String title,

double value,

double min,

double max,

Function(double) change

){


return Column(

crossAxisAlignment:
CrossAxisAlignment.start,


children:[


Text(
"$title : ${value.toStringAsFixed(0)}"
),



Slider(

value:value,

min:min,

max:max,

divisions:
(max-min).toInt(),


onChanged:
change as void Function(double)?,


),


const SizedBox(
height:15
)


]


);



}



}

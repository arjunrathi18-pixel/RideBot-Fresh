import 'package:flutter/material.dart';
import '../data/database/ride_database.dart';



class DashboardScreen extends StatefulWidget {


const DashboardScreen({
super.key
});



@override
State<DashboardScreen> createState()
=> _DashboardScreenState();


}




class _DashboardScreenState
extends State<DashboardScreen>{



int accepted = 0;

List<Map<String,dynamic>> rides=[];



double totalEarning = 0;

double avgPerKm = 0;



@override
void initState(){

super.initState();

loadData();

}





void loadData() async{


rides =
await RideDatabase.getRides();



accepted =
await RideDatabase.getTotalAccepted();



double earning = 0;

double km = 0;



for(var r in rides){


if(r["status"]=="ACCEPTED"){

earning +=
r["fare"];


km +=
r["distance"];


}


}



setState((){


totalEarning = earning;


if(km>0){

avgPerKm =
earning/km;

}


});


}







@override
Widget build(BuildContext context){


return Scaffold(


appBar:
AppBar(

title:
const Text(
"RideBot Dashboard"
),

),




body:
Padding(

padding:
const EdgeInsets.all(16),


child:
Column(

children:[




Row(

children:[


Expanded(

child:
statCard(
"Accepted",
accepted.toString(),
Icons.check_circle
)

),




Expanded(

child:
statCard(
"Earning",
"₹${totalEarning.toStringAsFixed(0)}",
Icons.currency_rupee
)

),


],



),





const SizedBox(
height:20
),





statCard(

"Average ₹/KM",

avgPerKm
.toStringAsFixed(2),

Icons.speed

),






const SizedBox(
height:20
),






Expanded(

child:
ListView.builder(

itemCount:
rides.length,


itemBuilder:
(context,index){


var ride =
rides[index];



return Card(

child:
ListTile(


leading:
Icon(

ride["status"]=="ACCEPTED"

?
Icons.check

:
Icons.close

),



title:
Text(

"₹${ride["fare"]} | ${ride["distance"]} KM"

),



subtitle:
Text(

ride["pickup"]

),



trailing:
Text(

ride["status"]

),


),


);



}



),


)




],


),


),


);



}





Widget statCard(
String title,
String value,
IconData icon
){


return Card(

child:
Padding(

padding:
const EdgeInsets.all(16),


child:
Column(

children:[


Icon(icon),


const SizedBox(
height:8
),


Text(

title,

style:
const TextStyle(
fontSize:14
)

),


Text(

value,

style:
const TextStyle(

fontSize:22,

fontWeight:
FontWeight.bold

)

)



]


)


)


);



}



}

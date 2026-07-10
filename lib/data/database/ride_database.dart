import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class RideDatabase {


static Database? _db;



static Future<Database> get database async{


if(_db != null)
{
return _db!;
}


_db =
await openDatabase(

join(
await getDatabasesPath(),
'ridebot.db'
),


version:1,


onCreate:(db,version) async{


await db.execute(

'''
CREATE TABLE rides(

id INTEGER PRIMARY KEY AUTOINCREMENT,

platform TEXT,

fare REAL,

distance REAL,

earning REAL,

pickup TEXT,

drop_location TEXT,

status TEXT,

time TEXT

)

'''

);


}

);



return _db!;


}





static Future<void> insertRide(
Map<String,dynamic> ride
) async{


final db =
await database;


await db.insert(

'rides',

ride

);


}






static Future<List<Map<String,dynamic>>>
getRides() async{


final db =
await database;


return await db.query(
'rides',
orderBy:'id DESC'
);


}




static Future<int>
getTotalAccepted() async{


final db =
await database;


var result =
await db.rawQuery(

'''
SELECT COUNT(*) 
FROM rides
WHERE status='ACCEPTED'

'''

);



return Sqflite.firstIntValue(
result
) ?? 0;


}





}

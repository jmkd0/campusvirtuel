import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'home.dart';
import 'institution.dart';

void main() async{
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){

     List pathIds = settings.arguments != null ? settings.arguments as List: [];
    late DatabaseHandler databaseHandler = DatabaseHandler();
    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => CampusVirtuelRoot(databaseHandler: databaseHandler));
      case '/institution':
        
        return MaterialPageRoute(builder: (_)=>InstitutionView(databaseHandler: databaseHandler, pathIds: pathIds),);
      default:
        return MaterialPageRoute(builder: (_) => CampusVirtuelRoot(databaseHandler: databaseHandler));
    }
  }
  
}
class Helpers{
  static buildWaiting(){
    return const Scaffold(
      backgroundColor: Color(0xff00CED1),
      body: Center(
        child: SpinKitFadingCircle(color: Colors.white, size: 70.0,)
      )
    );
  }
  static saveRoute(databaseHandler, route, navValue) async {
    String pathString = navValue.join(':');
    Database database = await databaseHandler.init();
    await database.rawUpdate('''UPDATE student SET navigation_route = ?, navigation_value = ? WHERE ids = '0000' ''', [route, pathString]);
  }
}
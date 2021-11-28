import 'package:flutter/material.dart';
import 'database.dart';
import 'home.dart';
import './institution.dart';

void main() async{
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    String args = settings.arguments.toString();
    late DatabaseHandler databaseHandler = DatabaseHandler();
    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => CampusVirtuelRoot(databaseHandler: databaseHandler));
      case '/institution':
        
        return MaterialPageRoute(builder: (_)=>InstitutionView(databaseHandler: databaseHandler),);
      default:
        return MaterialPageRoute(builder: (_) => CampusVirtuelRoot(databaseHandler: databaseHandler));
    }
  }
  
}
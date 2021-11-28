import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';
//import './institution.dart';

class CampusVirtuelRoot extends StatefulWidget {
  late DatabaseHandler databaseHandler;
  CampusVirtuelRoot({required this.databaseHandler}) ;
  @override
  State<StatefulWidget> createState() {

    return CampusVirtuelRootState();
  }
}
class CampusVirtuelRootState extends State<CampusVirtuelRoot> {
  String path = "ghjklm";
  @override
  void initState() {
    super.initState();
    navigateToLastPage();
  }

   navigateToLastPage() async {
    Database database = await widget.databaseHandler.init();
    var response = await database.rawQuery('SELECT navigation_route, navigation_value FROM student');
    String lastRoute = response[0]['navigation_route'].toString();
    String navValue = response[0]['navigation_value'].toString();
    Fluttertoast.showToast(
                    msg: '${lastRoute}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white);
    if (lastRoute.isNotEmpty && lastRoute != '/') {
      Navigator.of(context).pushNamed(lastRoute);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Virtuel'),
        backgroundColor: const Color(0xff00B19e),
      ),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color(0xff00B19e))),
          child: const Text('Open Institutions'),
          onPressed: () {
              Navigator.of(context).pushNamed('/institution');
              
          },
        ),
      ),
    );
  }
}
class Institution extends StatelessWidget {
  final String path;
  Institution({required this.path,});
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Fluttertoast.showToast(
                      msg: 'goodbye',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Screen Alpha"),
          backgroundColor: const Color(0xff00B19e),
        ),
        body: Center(
          child: Text(path),
        ),
      )
    );
  }
}
/* 
Fluttertoast.showToast(
                      msg: 'goodbye',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white);*/


import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import './main.dart';
class InstitutionView extends StatefulWidget {
  final DatabaseHandler databaseHandler;
  final List pathIds;
  InstitutionView({required this.databaseHandler, required this.pathIds}) ;

  @override
  State<StatefulWidget> createState() => InstitutionViewState();
}
class InstitutionViewState extends State<InstitutionView> {
  final logger = Logger();
  List<dynamic> dataToDisplay = [];
  InstitutionDataController intituData = InstitutionDataController();

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: intituData.getInstitution(widget.databaseHandler),
    builder: (context, snapshot){
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
              title: const Text("Institutions"),
              backgroundColor: const Color(0xff00B19e),

            ),
            body: snapshot.hasData? buildPage(snapshot.data) : Helpers.buildWaiting()
          )
        );
    }
  );
  
  buildPage(response){
    List data = response["institutions"];

    int count = data.length;
    return AnimationLimiter(
          child: GridView.builder(
            itemCount: count,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              Future<String> localImage = downloadImage(response, data[index]);

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  horizontalOffset: 100.0,
                  child: FadeInAnimation(
                      child: Padding(
                          padding: const EdgeInsets.only(top:5),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 16, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: InkWell(
                              onTap: (){},
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(flex: 50, child: Stack(
                                    alignment: Alignment.bottomLeft,//downloadImage(response, data[index])
                                    children: <Widget>[
                                      FutureBuilder(
                                        future: downloadImage(response, data[index]),
                                        builder: (context, snapshot) {
                                          //print(snapshot.hasData);
                                            if (snapshot.hasData) {
                                              print(snapshot.data);
                                              /* if (data[index].name == "UL"){
                                                var file = File(snapshot.data.toString());
        Fluttertoast.showToast(
                                                      msg: '${file.lengthSync()}',
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      backgroundColor: Colors.black87,
                                                      textColor: Colors.white);
                                              } */
                                                return  Ink.image( image: AssetImage(snapshot.data.toString()),fit: BoxFit.fitWidth,);
                                              } else if (snapshot.hasError) {
                                                return Ink.image( image: const AssetImage("assets/logos/default_logo.png"),fit: BoxFit.fitWidth,);
                                              }
                                          
                                          return Ink.image( image: const AssetImage("assets/logos/default_logo.png"),fit: BoxFit.fitWidth,);
                                        },
                                      ),
                                      const Center(child: Text("", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),),),
                                    ],//widget.institutionList[index].name
                                  ),),
                                  Expanded(flex: 20, child: Padding(
                                    padding: const EdgeInsets.only(left: 30, top:5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                      Text(data[index].name, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 25),)
                                      ],),)),
                                  Expanded(flex: 30, child: Padding(
                                    padding: const EdgeInsets.only(left: 5, right:5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(data[index].fullName, style: const TextStyle(color: Colors.black54),)
                                      ],),))],
                              ),
                            ),
                          ))
                  ),
                ),
              );
            },
          ),
        );
  }
  //Download tutorial: https://youtu.be/Gru7swUQqsg
  Future<String> downloadImage(data, element) async {
    final directory = await getApplicationDocumentsDirectory();
    Dio dio = Dio();
    dio.options.connectTimeout = 6000;
    if (element.fileName != 'null'){
      if(data["insert"].contains(element.id) || data["update"].contains(element.id)){
        
        String urlPath = "http://enovsky.com/campusvirtuel/public/logos/"+element.fileName;
        String savePath = directory.path+"/"+element.fileName;
        
        print(2);
          print("1");
          await dio.download(urlPath, savePath, onReceiveProgress: (receive, total){});
          
          print("HAA");
          print(directory.listSync());
          Fluttertoast.showToast(
                    msg: '${directory.listSync()}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white);
          return directory.path+"/"+element.fileName; 
      }else{
        
        return directory.path+"/"+element.fileName; }
    }else {
      print("jh");
      return "assets/logos/default_logo.png"; }
  }
  
}


class Institution {
  final String id;
  final String name;
  final String fullName;
  final String type;
  final String fileName;
  final String updatedDate;

  Institution({required this.id, required this.name, required this.fullName, required this.type, required this.fileName, required this.updatedDate });
  // Convert object into a Map object
  
  Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();
		map['id'] = id;
		map['updated_date'] = updatedDate;
		return map;
	}
  factory Institution.fromJson(Map<String, dynamic> element) {
    return Institution(
        id: element['id'],
        name: element['name'],
        fullName: element['full_name'],
        type: element['type'],
        fileName: element['file_name'],
        updatedDate: element['updated_date']
    );
  }
}
/*  */
class InstitutionDataController {

  void insertInstitution(databaseHandler, params) async{
    Database database = await databaseHandler.init();
    await database.rawInsert('''INSERT INTO institution (id, name, full_name, type, file_name, created_date, updated_date) VALUES (?,?,?,?,?,?,?)''', params);
  }
  void updateInstitution(databaseHandler, params) async{
    Database database = await databaseHandler.init();
    await database.rawUpdate('''UPDATE institution SET name = ?, full_name = ?, type = ?, file_name = ?, updated_date = ? WHERE id = ?''', params);
    }
  void deleteInstitution(databaseHandler, param) async{
    Database database = await databaseHandler.init();
    await database.rawDelete('''DELETE FROM institution WHERE id = ?''', [param]);
    }
  Future<List<Institution>> selectInstitution(databaseHandler) async{
    Database database = await databaseHandler.init();
    List<Institution> institutions = [];
    var response = await database.rawQuery('SELECT * FROM institution');
    for (int i = 0; i < response.length; i++) {
      institutions.add(Institution.fromJson(response[i]));
		}
    return institutions;
  }
  Future<Map> getRemoteInstitution(databaseHandler, localInfos) async{
    String url = 'http://enovsky.com/campusvirtuel/request_native';
    var data = {
      'parents':  [],
      'table': "institution",
      'local_infos': localInfos
    };
    try{
      Dio dio = Dio();
      Response response = await dio.post(url, data: data, options: Options(contentType: Headers.formUrlEncodedContentType));
      if (response.statusCode == 200 || response.statusCode == 201) {
        //Insert new data 
        List insertData = response.data['insert'];
        List newInsert = [];
        for (int i = 0; i < insertData.length; i++) {
          newInsert.add(insertData[i]['id']);
          List params = [insertData[i]['id'], insertData[i]['name'],insertData[i]['full_name'],insertData[i]['type'],insertData[i]['file_name'],'null',insertData[i]['updated_date']];
          insertInstitution(databaseHandler, params);
        }
        //Update old local data
        List updateData = response.data['update'];
        List newUpdate = [];
        for (int i = 0; i < updateData.length; i++) {
          newUpdate.add(updateData[i]['id']);
          List params = [updateData[i]['name'],updateData[i]['full_name'],updateData[i]['type'],updateData[i]['file_name'],updateData[i]['updated_date'],updateData[i]['id']];
          updateInstitution(databaseHandler, params);
        }
        //Delete data that are not present in remote
        List deleteData = response.data['delete'];
        for (int i = 0; i < deleteData.length; i++) {
          deleteInstitution(databaseHandler, deleteData[i]);
        }
        return {"insert": newInsert, "update": newUpdate};
      } else {
        throw Exception('Failed to creat');
      }
    } catch (error){
      return {};
    }
  }
  Future<Map> getInstitution(databaseHandler) async{
    
    List<Map<String, dynamic>> localInfos = [];
    List<Institution> institutionLocal = await selectInstitution(databaseHandler);
    
    for(Institution institution in institutionLocal){
      localInfos.add(institution.toMap());
    }
    Map response = await getRemoteInstitution(databaseHandler, localInfos);
    //saveFiles(modifyElements);
    List<Institution>  institutions = await selectInstitution(databaseHandler);
    response["institutions"] = institutions;
     /* Fluttertoast.showToast(
                    msg: '${institutionLocal[0].fileName}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white); */
    return response;
  }
}





/**Fluttertoast.showToast(
                    msg: '${institutionLocal[0].fileName}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white);
                     */
/* String updateImage(element, modifyElements){
    import 'package:flutter_downloader/flutter_downloader.dart';
    if(element.fileName != 'null'){
      if(modifyElements[0].contains(element.id) || modifyElements[1].contains(element.id)){
        Fluttertoast.showToast(
                    msg: 'new ele',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black87,
                    textColor: Colors.white); 
        final taskId =  FlutterDownloader.enqueue(
        url: "http://enovsky.com/campusvirtuel/public/logos/"+element.fileName,
        savedDir: 'assets/',
        showNotification: false, // show download progress in status bar (for Android)
        openFileFromNotification: false, // click on notification to open downloaded file (for Android)
      );
      return "assets/"+element.fileName;
      }else{return "assets/"+element.fileName;}
    }else{return "assets/default_logo.png";}
  } */
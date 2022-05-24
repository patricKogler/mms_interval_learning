import 'package:flutter/material.dart';
import 'package:mms_interval_learning/controller/SqliteServiceController.dart';
import '../service/SqliteService.dart';
import '../controller/SqliteServiceController.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}


class _EditPageState extends State<EditPage> {

  SqliteServiceController serviceController = SqliteServiceController();

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('hallo'),
                ElevatedButton(
                  onPressed: (){
                    print('HI');
                  },
                  child: Text('Add new Lecture'),
                ),
              ],
            ),
          ),
      ),
  );

  void addNewLecture(name){
    serviceController.insertLecture(name);
  }

  void addNewExam(date){
    serviceController.insertExam(date);
  }

  void addNewTopic(title){
    serviceController.insertTopic(title);
  }

}
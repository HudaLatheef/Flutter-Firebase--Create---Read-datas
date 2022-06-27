import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  final controllerName=TextEditingController();
  final controllerType=TextEditingController();
  final controllerColor=TextEditingController();
  final controllerCategory=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Add Item',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                            textCapitalization: TextCapitalization.sentences,

              controller: controllerName,
              decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ))),
            ),
          ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: controllerType
              ,
              decoration: InputDecoration(
                  hintText: 'Type',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ))),
          ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
                            textCapitalization: TextCapitalization.sentences,

              controller: controllerColor,
              decoration: InputDecoration(
                  hintText: 'Color',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ))),
          ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: TextField(
                            textCapitalization: TextCapitalization.sentences,

              controller: controllerCategory,
              decoration: InputDecoration(
                  hintText: 'Category',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        7,
                      ),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ))),
          ),
           ),
           Padding(
             padding: const EdgeInsets.all(12.0),
             child: TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange)),
              onPressed: () {
                final user=User(
                  name: controllerName.text,
                  type: controllerType.text,
                  color: controllerColor.text,
                  category: controllerCategory.text,
                  
                );
                createUser(user);

                Navigator.pop(context);
              }, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('ADD',style: TextStyle(color: Colors.white),),
              )),
           )
        ],
      ),
    );
    
  }
  Future createUser(User user) async{
    final docUser= FirebaseFirestore.instance.collection('users').doc();
    user.id= docUser.id;
    final json=user.toJson();
    await docUser.set(json);
    }
}

class User{
   String id;
  final String name;
  final String type;
  final String color;
  final String category;

  User({
    this.id='',
    required this.name,
    required this.type,
    required this.color,
    required this.category,
  });

  Map<String, dynamic>toJson()=>{
    'id':id,
    'name': name,
    'type': type,
    'color':color,
    'category': category,

  };
  static User fromJson(Map<String, dynamic>json) =>User(id: json['id'],name: json['name'], type: json['type'], color: json['color'], category: json['category']);



}


import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:obodo/add_item.dart';


class ShowItem extends StatefulWidget {
  const ShowItem({Key? key}) : super(key: key);

  @override
  State<ShowItem> createState() => _ShowItemState();
}

class _ShowItemState extends State<ShowItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Items',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text('Something went wrong! ${snapshot.error}');

          } if(snapshot.hasData){
            final users= snapshot.data!;

            return ListView(
              children: users.map(buildUser).toList(),
              
            );
          }else{
             return Center(child: 
            CircularProgressIndicator(),);
          }

        }
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddItem()),
              );
            },
            backgroundColor: Colors.orange,
            child: Icon(Icons.add,color: Colors.white,),
            ),
    );
    
  }

  Widget buildUser(User user) =>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.yellow),

      ),
      child: ListTile(
        title: Text(user.name),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Type: '),
                  Text(user.type),
                ],
              ),
              Row(
                children: [
                  Text('Color: '),
                  Text(user.color),
                ],
              ),
              Row(
                children: [
                  Text('Category: '),
                  Text(user.category),
                ],
              ),
            ],
          ),
        ),

      ),
    ),
  );


  Stream<List<User>> readUsers() =>  FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) => snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
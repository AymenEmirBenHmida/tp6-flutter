//@dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:following_news/productDialog.dart';
import 'package:http/http.dart' show Client;
import 'Models/product.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.black,
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = Client();
  List<product> listP;
  productDialog dialog = new productDialog();

  CollectionReference _productss =
      FirebaseFirestore.instance.collection('products');

  void initState(){
    // TODO: implement initState
    super.initState();
  }

  add(int price, String name) async {
    _productss.add({price: price, name: name});
  }

  delete(String id) async {
    _productss.doc(id).delete();
  }

  getAll() async {}

/*Dismissible(
  
key: Key(index.toString()),
onDismissed: (direction) {

delete(streamSnapshot.data.docs[index]);
setState(() {
});

},
child:*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(
context: context,
         builder: (BuildContext context) =>
            dialog.buildDialog(context, product(id: "0",name: "hello",price: "0"), true),
        );
      },
      child:Icon(Icons.add)
      ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Center(
                  child: Container(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: StreamBuilder(
                          stream: _productss.snapshots(),
                          builder: (context,
                              AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                            return ListView.builder(
                              itemCount: streamSnapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapshot =
                                    streamSnapshot.data.docs[index];
                                return Card(
                                    margin: EdgeInsets.all(10),
                                    child: Dismissible(
                                      key: Key(index.toString()),
                                      onDismissed: (direction) {
                                        delete(documentSnapshot.id);
                                        setState(() {});
                                      },
                                      child: ListTile(
                                          onTap: () {
                                            /*Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => ),
                    );*/
                                          },
                                          title: Text(documentSnapshot['name']),
                                          leading: CircleAvatar(
                                            child: Text(documentSnapshot['price']
                                                .toString()),
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              print(index.toString());
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      dialog.buildDialog(
                                                          context,
                                                          product(
                                                              name:
                                                                  documentSnapshot[
                                                                          'name']
                                                                      .toString(),
                                                              price:
                                                                  documentSnapshot[
                                                                          'price']
                                                                      .toString(),
                                                              id: documentSnapshot
                                                                  .id),
                                                          false));
                                            },
                                          )),
                                    ));
                              },
                            );
                          }),
                    ),
                  ),
                ))));
  }
}

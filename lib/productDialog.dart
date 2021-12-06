import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/product.dart';

class productDialog {
  CollectionReference _productss =
      FirebaseFirestore.instance.collection('products');

final txtNonClass = TextEditingController();
final txtNbreEtud = TextEditingController();
Widget buildDialog(BuildContext context, product list, bool isNew) {
if (!isNew) {
txtNonClass.text = list.name;
txtNbreEtud.text = list.price.toString();
}
return AlertDialog(
title: Text((isNew) ? 'Product list' : 'Edit '),
shape:
RoundedRectangleBorder(borderRadius: 
BorderRadius.circular(30.0)),
content: SingleChildScrollView(
child: Column(children: <Widget>[
TextField(
controller: txtNonClass,
decoration: InputDecoration(hintText: 'Product Name')),
TextField(
controller: txtNbreEtud,
keyboardType: TextInputType.number,
decoration:
InputDecoration(hintText: 'Product Price'),
),
RaisedButton(
child: isNew?Text("Add Product"):Text('Edit Product'),
onPressed: () {
list.name = txtNonClass.text;
list.price = txtNbreEtud.text;
var text = (isNew) ? 'Add Product' : 'Edit Product';
if(text =="Add Product"){
add(int.parse(list.price),list.name);
Navigator.pop(context);
}else{
  Edit(list.id,list.price,list.name);
  Navigator.pop(context);
  }
print("hello");
//context.read<dbuse>().updateClass(ScolList(list.codClass, txtNonClass.text, int.parse(txtNbreEtud.text)));
/*else
context.read<dbuse>().insertClass(list);
Navigator.pop(context);*/
},
),
]),
));
}

add(int price, String name) async {
    _productss.add({'price': price, 'name': name});
  }

Edit(String id,String price,String name)async{
  _productss.doc(id).set(
    {
    'name':name,
    'price':price
    }
  );
}
}
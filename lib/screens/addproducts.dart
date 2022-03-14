import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebasedemo/pages/showproduct.dart';
import 'package:flutter/material.dart';
class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {



  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _amount = TextEditingController();

  CollectionReference products =
      FirebaseFirestore.instance.collection('Products');
  Future<void> addProduct() {
    return products
        .add({
          'product_name': _name.text,
          'price': _price.text,
          'amount': _amount.text,
        })
        .then((value) => print("Product data has been successfully"))
        .catchError((error) => print("Failed to add data: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding:  EdgeInsets.only(left: 35, top: 30),
              child:  Text('เพิ่ม'),
            ),
            formfield(context),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView formfield(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:  EdgeInsets.only(top: 170),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin:  EdgeInsets.only(left: 35, right: 35),
              child: Column(
                children: [

                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      label: Text(
                        'ชื่อสินค้า',
                      ),
                    ),
                  ),
    
                  TextFormField(
                    controller: _price,
                    decoration: InputDecoration(
                      label: Text(
                        'ราคา', ),
                    ),
                  ),
                  TextFormField(
                    controller: _amount,
                    decoration: InputDecoration(
                      label: Text(
                        'จำนวน',),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('บันทึก',),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _type = TextEditingController();

  CollectionReference products =
      FirebaseFirestore.instance.collection('Products');

  Future<void> updateProduct() {
    return products.doc(widget.id).update({
      'product_name': _name.text,
      'price': _price.text,
      'product_type': _type.text,
    }).then((value) {
      print("Data updated successfully");
      Navigator.pop(context);
    }).catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding:  EdgeInsets.only(left: 35, top: 30),
              child: Text(
                'แก้ไขข้อมูลของสินค้า'),
            ),
            editformfield(context),
          ],
        ),
      ),
    );
  }

  Widget editformfield(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: products.doc(widget.id).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          _name.text = data['product_name'];
          _price.text = data['price'].toString();
          _type.text = data['product_type'];

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
                              'Product name',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  BorderSide(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                         SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _price,
                          decoration: InputDecoration(
                            label: Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  BorderSide(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                         SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _type,
                          decoration: InputDecoration(
                            label: Text(
                              'Product type',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black12),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  BorderSide(
                                color: Colors.black12,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:  BorderSide(
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                         SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'บันทึกข้อมูล'
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Color.fromARGB(255, 238, 204, 231),
                            )
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
        return  Text('Loading');
      },
    );
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:spirahtask/models/products.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Products> products = [];
  List<Products> dummy = [];
  List<List<Products>> menu = [];
  List<String> categeory = [];
  Set<String> items = {};
  readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await jsonDecode(response) as List<dynamic>;

    for (int i = 0; i < data.length; i++) {
      products.insert(i, Products.fromJson(data[i]));
    }
    for (int i = 0; i < products.length; i++) {
      categeory.insert(i, products[i].category.toString());
    }

    for (int i = 0; i < products.length; i++) {
      print(products[i]);
    }

    print(categeory);
    categeory.sort();
    items = categeory.toSet();
    print(items);

    for (int i = 0; i < items.length; i++) {
      int k = 0;

      for (int j = 0; j < products.length; j++) {
        if (products[j].category == items.elementAt(i)) {
          dummy.insert(k, products[j]);
          k++;
        }
      }
      menu.insert(i, dummy);
      dummy = [];
    }

    for (int i = 0; i < items.length; i++) {
      print(items.elementAt(i));
      for (int j = 0; j < menu[i].length; j++) {
        print(menu[i][j]);
      }
    }
  }

  @override
  void initState() {
    readJson();
    Timer(Duration(seconds: 1), () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product list')),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                  title: Text(
                    items.elementAt(index).toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                  children: [
                    Container(
                        height: 200,
                        child: ListView.builder(
                          itemCount: menu[index].length,
                          itemBuilder: (context, index1) {
                            return ListTile(
                              title: Text(
                                menu[index][index1].productName,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          },
                        ))
                  ]);
            },
          )),
    );
  }
}

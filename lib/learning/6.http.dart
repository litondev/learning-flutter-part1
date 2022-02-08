import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget{
  @override
  MyListProduct createState() => MyListProduct();
}

class MyListProduct extends State<MyApp>{
  List data = [];

  @override
  void initState() {
    super.initState();
    this.getData(); //PANGGIL FUNGSI YANG TELAH DIBUAT SEBELUMNYA
  }


  @override
  Future<String> getData() async {    
    try{
      var url = Uri.parse("http://192.168.8.215:3001/product");
      var res = await http.get(url,
        headers : {
          'accept' : 'application/json'
        }
      );

      setState((){
        var content = json.decode(res.body);

        data = content;
      });    

      return 'success!';
    } on Exception catch(e){
      print('Terjadi Kesalahan');
      print(e.toString());  
      return 'failed!';
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'Product',
      home : Scaffold(
        appBar: AppBar(
          title: Text('List Product'),
        ),
        body : Container(
          margin : EdgeInsets.all(10.0),
          child : ListView.builder(
            itemCount : data == null ? 0 : data.length,
            itemBuilder: (BuildContext context,int index){
              return Container(
                child: Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: Text(data[index]['id'].toString(),style : TextStyle(fontSize: 30.0)),
                        title : Text(data[index]['title'],style: TextStyle(fontSize: 25.0,fontWeight : FontWeight.bold)),
                        trailing: Image.asset("default.png",width : 32.0,height : 32.0),
                        subtitle: Text(data[index]['description'] ?? '-'),
                      ),
                      ButtonTheme(
                        child: ButtonBar(
                          children: <Widget>[
                            // BUTTON PERTAMA 
                            TextButton(
                              //DENGAN TEXT LIHAT DETAIL
                              child: const Text('LIHAT DETAIL'),
                              onPressed: () { 
                                print("Detail");
                               },
                            ),                                                      
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductList extends StatelessWidget {
  String? id;
  String? title;
  String? description;
  int? stock;
  int? price;
  bool? type;

  ProductList(this.id,this.title,this.description,this.stock,this.price,this.type);

  @override 
  Widget build(BuildContext context){
    return Dismissible(
      key : ValueKey(id),
      background: Container(
        color : Theme.of(context).errorColor,
        child: Icon(
          Icons.call_missed_outgoing,
          size : 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4
        ),
      ),

      direction:  DismissDirection.endToStart,

      confirmDismiss: (dismiss){
        return showDialog(
          context: context, 
          builder: (ctx) => AlertDialog(
            title : Text("Kamu Yakin"),
            content: Text("Kamu Akan Mengurangi Stock"),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.of(ctx).pop(false);
                }, 
                child: Text("No",style : TextStyle(color : Colors.grey,fontWeight : FontWeight.bold))
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(ctx).pop(true);
                }, 
                child: Text("Yes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
              )
            ],
          )
        ).then((result) {
          if(result){        
              if((stock as int) > 0){
                Provider.of<Products>(context,listen: false).changeStock(id as String);
              }else{
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Stok Kosong"),
                    duration: Duration(seconds: 2),
                ));
              }
            }          
        });
      },
      child: Card(
        elevation: 4,

        child:  ListTile(
          leading: CircleAvatar(
            child : Text(stock.toString()),
          ),
          title : Text(title.toString()),
          subtitle: Text(
            'Description : $description',
            style: TextStyle(color:Colors.grey,fontSize: 12),
          ),
          trailing: !(type as bool) ? Text(
              (stock as int) > 0 ? 'In Stock' : 'Sold Out',
              style : TextStyle(color : (stock as int) > 0 ? Colors.green : Colors.red)
            ) : Container( 
              width: 100,
              child : Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed("/add-product",arguments: id);
                    }, 
                    icon: Icon(Icons.edit)
                  ),
                  IconButton(
                    onPressed: (){
                      showDialog(
                        context: context, 
                        builder: (ctx) => AlertDialog(
                          title : Text("Kamu Yakin?"),
                          content: Text("Proses ini akan menghapus data"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop(false);
                              }, 
                              child: Text(
                                "Batal",
                                style : TextStyle(
                                  color : Colors.grey,
                                  fontWeight: FontWeight.bold
                                )
                              )
                            ),
                            TextButton(
                              onPressed: (){
                                Provider.of<Products>(context,listen: false)
                                .removeProduct(id as String)
                                .then((_) {
                                  Navigator.of(context).pop(false);
                                });
                              }, 
                              child: Text(
                                "Lanjutkan",
                                style:  TextStyle( 
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            )
                          ],
                        )                        
                      );
                    }, 
                    icon: Icon(Icons.delete)
                  )
                ],
              )
            ), 
        ),
      ),
    );
  }
}
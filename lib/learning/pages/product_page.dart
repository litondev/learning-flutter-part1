import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import "../providers/products.dart";
import "../components/product_list.dart";
import "../components/side_bar.dart";

class ProductPage extends StatelessWidget {
  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<Products>(context,listen:  false).fetchProduct();
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : Text("Data Barang")
      ),

      drawer: Sidebar(),

      body : RefreshIndicator(
        onRefresh: () => _refreshData(context),
        child : FutureBuilder(
          future : Provider.of<Products>(context,listen: false).fetchProduct(),
          builder: (ctx,snapshop){
            if(snapshop.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              if(snapshop.error != null){
                return Center(
                  child: Text("Error Loading Data"),
                );
              }else{
                return Consumer<Products>(
                  builder: (ctx,product,child) => Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: product.items.length,
                      itemBuilder: (ctx,i) => ProductList(
                        product.items[i].id,
                        product.items[i].title,
                        product.items[i].description,                        
                        product.items[i].stock,
                        product.items[i].price,
                        false
                      )
                    )

                  ),
                );
              }
            }
          },
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
//Model
import 'package:formvalidation/src/models/producto_model.dart';

//Provider
import 'package:formvalidation/src/providers/products_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final productsProvider = ProductsProvider();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: _createList(context),
      floatingActionButton: _crearButton(context),
    );
  }


  Widget _createList(BuildContext context) {
    return FutureBuilder(
      future: productsProvider.loadProduct(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products!.length,
            itemBuilder: (context, i) {
              return _crearItem(context, products[i]);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        productsProvider.deleteProduct('${product.id}');
      },
      child: ListTile(
        title: Text('${product.titulo} - ${product.valor}'),
        subtitle: Text('${product.id}'),
        onTap: () {
          // print(' $product ');
          Navigator.pushNamed(context, 'product', arguments: product)
              .then((value) => setState(() {}));
        },
      ),
    );
  }

  _crearButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, 'product')
          .then((value) => setState(() {})),
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
    );
  }

}
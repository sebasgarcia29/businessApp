import 'package:flutter/material.dart';
import 'package:formvalidation/src/models/producto_model.dart';
import 'package:formvalidation/src/utils/utils.dart' as utils;

//Provider
import 'package:formvalidation/src/providers/products_provider.dart';

class ProducPage extends StatefulWidget {
  @override
  _ProducPageState createState() => _ProducPageState();
}

class _ProducPageState extends State<ProducPage> {
  final formKey = GlobalKey<FormState>();
  final productoProvider = new ProductsProvider();

  ProductModel product = new ProductModel(
    valor: 0,
    disponible: true,
    titulo: '',
  );

  bool _guardando = false;

  @override
  Widget build(BuildContext context) {
    final ProductModel prodData =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    // // ignore: unnecessary_null_comparison
    if (prodData != null) {
      product = prodData;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Product'),
          actions: [
            IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: () => _selectPhoto(),
            ),
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () => _takePhoto(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    _createName(),
                    _createPrice(),
                    _createEnable(),
                    _createButton(),
                  ],
                )),
          ),
        ));
  }

  Widget _createName() {
    return TextFormField(
      initialValue: '${product.titulo}',
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Producto',
      ),
      onSaved: (value) => product.titulo = '$value',
      validator: (value) {
        if (value!.length < 3) {
          return 'Ingrese el nombre del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _createPrice() {
    return TextFormField(
      initialValue: '${product.valor}',
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => product.valor = double.parse('$value'),
      validator: (value) {
        if (utils.isNumeric('$value')) {
          return null;
        } else {
          return 'Solo se aceptan Numeros';
        }
      },
    );
  }

  Widget _createEnable() {
    return SwitchListTile(
      value: product.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value) {
        setState(() {
          product.disponible = value;
        });
      },
    );
  }

  Widget _createButton() {
    return ElevatedButton.icon(
      // onPressed: _guardando ? null : () => _submit(),
      onPressed: () => _submit(),
      icon: Icon(Icons.save),
      label: Text('Guardar'),
      style: ButtonStyle(
          backgroundColor: _guardando
              ? null
              : MaterialStateProperty.all<Color>(Colors.deepPurple),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.white)),
          )),
    );
  }

  void _submit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();
    print(product.titulo);
    print(product.valor);
    print(product.disponible);

    productoProvider.createProduct(product);
  }

  // void _submit() {
  //   if (!formKey.currentState!.validate()) {
  //     return;
  //   }
  //   formKey.currentState!.save();
  //   setState(() {
  //     _guardando = true;
  //   });
  //   if (product.id == null) {
  //     productProvider.createProduct(product);
  //   } else {
  //     productProvider.updateProduct(product);
  //   }
  //   mostrarSnackbar('Registro guardado');
  //   Navigator.pop(context);
  // }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  _selectPhoto() {}

  _takePhoto() {}
}

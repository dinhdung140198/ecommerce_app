import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/products.dart';
import 'package:ecommerce_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({Key? key, this.isFavor, this.value}) : super(key: key);
  final bool? isFavor;
  final String? value ;

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context,listen: false);
    List<Product>items=productsData.items;
    List<Product>dummySearchList;
    dummySearchList=productsData.items;
    if (widget.value!.isNotEmpty) {
      List<Product> searchList = [];
      items.forEach(
        (item) {
          if (item.name!.contains(widget.value!)) {
            searchList.add(item);
          }
        },
      );
      items.clear();
      items.addAll(searchList);
    } else{
      items.clear();
      items.addAll(dummySearchList);
    }
    final products = widget.isFavor! ? productsData.favoriteItems : items;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: MasonryGridView.count(
          primary: false,
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
          itemCount: products.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: products[index],
                child: ProductItem(),
              )),
    );
  }
}

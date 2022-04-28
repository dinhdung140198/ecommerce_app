import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/products.dart';
import 'package:ecommerce_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key,this.isFavor,this.value}) : super(key: key);
  final bool? isFavor ;
  final String? value;
  @override
  // void didChangeDependencies() {
  //   final productsData = Provider.of<Products>(context);
  //   super.didChangeDependencies();
    
  // }
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final listsearch=productsData.items;
    List<Product> filterSearchResult(String query) {
    List<Product>dummySearchList;
    dummySearchList=productsData.items;
    if (query.isNotEmpty) {
      List<Product> searchList = [];
      listsearch.forEach(
        (item) {
          if (item.name!.contains(query)) {
            searchList.add(item);
          }
        },
      );
      listsearch.clear();
      listsearch.addAll(searchList);
      return listsearch;
    } else{
      listsearch.clear();
      listsearch.addAll(dummySearchList);
    }
    return listsearch;
  }
  final products = isFavor!?productsData.favoriteItems:filterSearchResult(value!);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
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
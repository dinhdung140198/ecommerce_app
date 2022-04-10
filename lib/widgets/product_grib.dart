import 'package:ecommerce_app/providers/products.dart';
import 'package:ecommerce_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
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


// return GridView.builder(
//       padding: EdgeInsets.all(10.0),
//       itemCount: products.length,
//       itemBuilder: (context, index) => ChangeNotifierProvider.value(
//         value: products[index],
//         child: ProductItem(),
//       ),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 3 / 2,
//           crossAxisSpacing: 12.0,
//           mainAxisSpacing: 12.0),
//     );
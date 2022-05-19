import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/categories.dart';
import 'package:ecommerce_app/widgets/product_item.dart';
import 'package:ecommerce_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategoryProductGrid extends StatefulWidget {
  const CategoryProductGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryProductGrid> createState() => _CategoryProductGridState();
}

class _CategoryProductGridState extends State<CategoryProductGrid> {
  String? value = '';
  void onChange(val) {
    if (val != null) {
      setState(() {
        value = val;
      });
    } else {
      setState(() {
        value = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Categories>(context);
    List<Product> items = productsData.productList;
    List<Product> dummySearchList;
    dummySearchList = productsData.productList;
    if (value!.isNotEmpty) {
      List<Product> searchList = [];
      items.forEach(
        (item) {
          if (item.name!.contains(value!)) {
            searchList.add(item);
          }
        },
      );
      items.clear();
      items.addAll(searchList);
    } else {
      items.clear();
      items.addAll(dummySearchList);
    }
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SearchBarWidget(callback: (value) => onChange(value)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: MasonryGridView.count(
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
              itemCount: items.length,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                    value: items[index],
                    child: ProductItem(),
                  )),
        ),
      ],
    );
  }
}

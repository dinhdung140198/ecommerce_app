import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoryGribWidget extends StatelessWidget {
  const CategoryGribWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MasonryGridView.count(
          primary: false,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 15),
          crossAxisCount: MediaQuery.of(context).orientation==Orientation.portrait?2:4,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
          itemCount: products.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: products[index],
                child: ProductItem(),
              )),
  }
}
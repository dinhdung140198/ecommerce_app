import 'package:ecommerce_app/providers/categories.dart';
import 'package:ecommerce_app/screens/category_products.dart';
import 'package:ecommerce_app/widgets/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../models/route_argument.dart';

class CategoryGribWidget extends StatelessWidget {
  const CategoryGribWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final categories = Provider.of<Categories>(context).categoryList;
    return MasonryGridView.count(
      primary: false,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 15),
      crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      itemCount: categories.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: categories[index],
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              CategoryProductsScreen.routeName,
              arguments: RouteArgument(
                name: categories[index].nameCategory,
                imageUrl: categories[index].image,
              ),
            );
          },
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                alignment: AlignmentDirectional.topCenter,
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                      offset: Offset(0, 5),
                      blurRadius: 10,
                    ),
                  ],
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(categories[index].image!)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 85, bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: 140,
                height: 90,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                        offset: Offset(0, 3),
                        blurRadius: 10,
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: Theme.of(context).textTheme.bodyText2!.merge(
                          TextStyle(color: Theme.of(context).accentColor)),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            categories[index].nameCategory!,
                            style: Theme.of(context).textTheme.bodyText1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                        IconButton(
                          onPressed: (() {
                            showDialog(
                                context: context,
                                builder: (contex) {
                                  return RatingBarWidget(
                                      product: categories[index],
                                      flag: 'category');
                                });
                          }),
                          icon: Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                        ),
                        Text(
                          categories[index].rate!.toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

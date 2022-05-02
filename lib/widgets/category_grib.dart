import 'package:ecommerce_app/providers/categories.dart';
import 'package:ecommerce_app/screens/categories.dart';
import 'package:ecommerce_app/screens/category_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

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
            Navigator.of(context).pushNamed(CategoryProductsScreen.routeName,arguments: categories[index].nameCategory);
          },
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                alignment: AlignmentDirectional.topCenter,
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                        offset: Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                    image: DecorationImage(
                        image: NetworkImage(categories[index].image!))
                    // gradient: LinearGradient(begin: Alignment.bottomLeft,end: Alignment.topRight,colors: )
                    ),
              ),
              Positioned(
                right: -50,
                bottom: -100,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Positioned(
                left: -30,
                top: -60,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(150),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 80, bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: 140,
                height: 80,
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
                      categories[index].nameCategory!,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'no products',
                            style: Theme.of(context).textTheme.bodyText2,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                          ),
                        ),
                        Icon(Icons.star,color: Colors.amber,size: 18,),
                        Text('4',style: Theme.of(context).textTheme.bodyText1,)
                      ],
                      
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
    );
  }
}

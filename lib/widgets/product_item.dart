import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/widgets/product_detail.dart';
import 'package:ecommerce_app/widgets/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/ui_icons.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailWidget.routeName, arguments: product.id);
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                  offset: Offset(0, 4),
                  blurRadius: 10)
            ]),
        child: Column(
          children: [
            Hero(tag: product.id!, child: Image.network(product.urlImage!)),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                product.name!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "\$${product.price.toString()}",
                style: Theme.of(context).textTheme.headline6,
                // textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => Provider.of<Cart>(context, listen: false)
                        .addItem(productId:product.id!, price:product.price!, name:product.name!,
                            urlImage:product.urlImage!),
                    icon: Icon(
                      UiIcons.shopping_cart,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  // Text(
                  //   '100 Sale',
                  //   style: Theme.of(context).textTheme.bodyText2,
                  //   overflow: TextOverflow.fade,
                  //   softWrap: false,
                  // ),
                  // ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return RatingBarWidget(
                              product: product,
                              flag: 'product',
                            );
                          });
                    },
                    icon: Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                  ),
                  Text(
                    product.rate.toString(),
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
            SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}

import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/widgets/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final String? id;
  final String? productId;
  final String? name;
  final int? quantity;
  final double? price;
  final String? urlImage;
  const CartItemWidget(
      {Key? key,
      @required this.id,
      @required this.productId,
      @required this.name,
      @required this.quantity,
      @required this.price,
      @required this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailWidget.routeName,
            arguments: this.productId);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 2))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
                tag: id!,
                child: Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(urlImage!), fit: BoxFit.cover)),
                )),
            SizedBox(
              width: 15,
            ),
            Flexible(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        '\$$price',
                        style: Theme.of(context).textTheme.headline4,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      iconSize: 30,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icon(Icons.add_circle_outline),
                      color: Theme.of(context).hintColor,
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      onPressed: () {},
                      iconSize: 30,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icon(Icons.remove_circle_outline),
                      color: Theme.of(context).hintColor,
                    ),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
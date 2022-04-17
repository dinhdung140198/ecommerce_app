import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/screens/cart.dart';
import 'package:flutter/material.dart';

class ShoppingCartButton extends StatelessWidget {
  final Color? iconColor;
  final Color? labelColor;
  final int? labelCount;
  const ShoppingCartButton({
    Key? key,
    @required this.iconColor,
    @required this.labelColor,
    @required this.labelCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CartScreen.routeName);
        },
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(
                UiIcons.shopping_cart,
                color: this.iconColor,
                size: 28,
              ),
            ),
            Container(
              child: Text(
                this.labelCount.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 9),
              ),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: this.labelColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
                  constraints: BoxConstraints(minWidth: 15,maxWidth: 15,minHeight: 15,maxHeight: 15),
            ),
          ],
        ),
        color: Colors.transparent,
        );
  }
}

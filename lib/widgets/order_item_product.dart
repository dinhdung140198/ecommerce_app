import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/models/cart.dart';
import 'package:ecommerce_app/widgets/product_detail.dart';
import 'package:flutter/material.dart';

class OrderItemProduct extends StatelessWidget {
  final CartItem? orderProduct;
  const OrderItemProduct({@required this.orderProduct});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailWidget.routeName,arguments: orderProduct!.productId);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      image: NetworkImage(orderProduct!.urlImage!),
                      fit: BoxFit.cover),
                ),
              ),
            SizedBox(width: 10),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderProduct!.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Color:',style: Theme.of(context).textTheme.caption,),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(shape: BoxShape.circle,color: orderProduct!.color),
                            ),
                            SizedBox(width:5,),
                            Text('Size: ${orderProduct!.size}',style: Theme.of(context).textTheme.caption,)
                          ],
                        ),
                        // Wrap(
                        //   spacing: 10,
                        //   children: [
                        //     Icon(
                        //       UiIcons.calendar,
                        //       color: Theme.of(context).focusColor,
                        //       size: 20,
                        //     ),
                        //     Icon(
                        //       UiIcons.line_chart,
                        //       color: Theme.of(context).focusColor,
                        //       size: 20,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  // ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text("\$${orderProduct!.price!}",
                          style: Theme.of(context).textTheme.headline4),
                      SizedBox(height: 6),
                      Chip(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        backgroundColor: Colors.transparent,
                        shape: StadiumBorder(
                            side: BorderSide(
                                color: Theme.of(context).focusColor)),
                        label: Text(
                          'x ${orderProduct!.quantity}',
                          style: TextStyle(color: Theme.of(context).focusColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

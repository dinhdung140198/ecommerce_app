import 'package:flutter/material.dart';

import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/widgets/empty_order_product.dart';
import 'package:ecommerce_app/widgets/order_item.dart';


class OrdersProductsWidget extends StatelessWidget {
  List<OrderItem> orders;

  OrdersProductsWidget({Key? key, required this.orders}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Offstage(
            offstage: orders.isEmpty,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  UiIcons.inbox,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Orders List',
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: Theme.of(context).textTheme.headline4,
                ),
                trailing: Icon(Icons.format_list_bulleted,
                    color: Theme.of(context).accentColor),
              ),
            ),
          ),
          Offstage(
            offstage: orders.isEmpty,
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: orders.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return OrderItemWiget(orders[index]);
              },
            ),
          ),
          Offstage(
            offstage: orders.isNotEmpty,
            child: EmptyOrdersProductsWidget(),
          )
        ],
      ),
    );
  }
}

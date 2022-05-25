import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/widgets/empty_order_product.dart';
import 'package:ecommerce_app/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersProductsWidget extends StatefulWidget {
  String? orderStatus;
  @override
  _OrdersProductsWidgetState createState() => _OrdersProductsWidgetState();

  OrdersProductsWidget({Key? key,@required this.orderStatus}) : super(key: key);
}

class _OrdersProductsWidgetState extends State<OrdersProductsWidget> {
  String layout = 'list';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(widget.orderStatus!),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Offstage(
                        offstage: orderData.orders.isEmpty,
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      this.layout = 'list';
                                    });
                                  },
                                  icon: Icon(
                                    Icons.format_list_bulleted,
                                    color: this.layout == 'list'
                                        ? Theme.of(context).accentColor
                                        : Theme.of(context).focusColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      this.layout = 'grid';
                                    });
                                  },
                                  icon: Icon(
                                    Icons.apps,
                                    color: this.layout == 'grid'
                                        ? Theme.of(context).accentColor
                                        : Theme.of(context).focusColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: orderData.orders.isEmpty,
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          primary: false,
                          itemCount: orderData.orders.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemBuilder: (context, index) {
                            return OrderItemWiget(orderData.orders[index]);
                          },
                        ),
                      ),
                      Offstage(
                        offstage: orderData.orders.isNotEmpty,
                        child: EmptyOrdersProductsWidget(),
                      )
                    ],
                  ),
                ),
              );
            }
          }
        );
  }
}

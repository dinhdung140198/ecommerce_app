import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/account.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/order_product.dart';
import 'package:ecommerce_app/widgets/shopping_cart_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/order';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final statusOrder = ModalRoute.of(context)!.settings.arguments as int;
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return DefaultTabController(
      initialIndex: statusOrder,
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerWidget(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'MY ORDER',
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: IconButton(
            icon: Icon(Icons.sort),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            color: Theme.of(context).hintColor,
          ),
          actions: [
            ShoppingCartButton(
                iconColor: Theme.of(context).hintColor,
                labelColor: Theme.of(context).accentColor,
                labelCount: cart.itemCount),
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 12.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(300),
              ),
              child: InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(AccountScreen.routeName),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user!.avartar!),
                ),
              ),
            )
          ],
          bottom: TabBar(
            indicatorPadding: EdgeInsets.all(10),
            labelPadding: EdgeInsets.symmetric(horizontal: 5),
            unselectedLabelColor: Theme.of(context).accentColor,
            labelColor: Theme.of(context).primaryColor,
            isScrollable: true,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Theme.of(context).accentColor),
            tabs: [
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: Theme.of(context).accentColor, width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('All'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Theme.of(context).accentColor),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Not ship yet'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: Theme.of(context).accentColor, width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Shipping'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: Theme.of(context).accentColor, width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Shipped'),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: Provider.of<Orders>(context,listen: false)
                .fetchAndSetOrders(),
            builder: (ctx, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Consumer<Orders>(
                    builder: (context, orderData, child) => TabBarView(
                          children: [
                            OrdersProductsWidget(orders:orderData.orders),
                            OrdersProductsWidget(orders:orderData.orderShipYet),
                            OrdersProductsWidget(orders:orderData.orderShipping),
                            OrdersProductsWidget(orders:orderData.orderShipped)
                          ],
                        ));
              }
            }),
      ),
    );
  }
}

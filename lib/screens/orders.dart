import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
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
    final cart = Provider.of<Cart>(context);
    return DefaultTabController(
      initialIndex: 0,
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
                onTap: () {},
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://1.bp.blogspot.com/-wIaKEkcCTTk/XqjcK5-2a8I/AAAAAAAAk4k/opJSFhhMK2MXq51T3fXX8TaMUSW78alSgCEwYBhgL/s1600/hinh-nen-girl-xinh-4k-nu-cuoi-xinh-xan.jpg'),
                  // child: Image.network(
                  //   'https://toppng.com/uploads/preview/vu-thi-ha-user-pro-icon-115534024853ae3gswzwd.png',
                  //   fit: BoxFit.cover,
                  // ),
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
                    child: Text('Unpaid'),
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
                    child: Text('Paid'),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrdersProductsWidget(),
            OrdersProductsWidget(),
            OrdersProductsWidget(),
            OrdersProductsWidget()
          ],
        ),
      ),
    );
  }
}

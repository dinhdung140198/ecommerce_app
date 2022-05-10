import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/account.dart';
import 'package:ecommerce_app/screens/checkout.dart';
import 'package:ecommerce_app/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user =Provider.of<UserProvider>(context,listen: false).user;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            UiIcons.return_icon,
            color: Theme.of(context).hintColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(300),
              onTap: () {Navigator.of(context).pushNamed(AccountScreen.routeName);},
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    user.avartar!),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 150),
            padding: EdgeInsets.only(bottom: 15),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.shopping_cart,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Shopping Cart',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      subtitle: Text(
                        'Verify your quantity and click checkout',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (ctx, i) => CartItemWidget(
                          id: cart.items.values.toList()[i].id,
                          productId: cart.items.keys.toList()[i],
                          name: cart.items.values.toList()[i].name,
                          quantity: cart.items.values.toList()[i].quantity,
                          price: cart.items.values.toList()[i].price,
                          urlImage: cart.items.values.toList()[i].urlImage),
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 15);
                      },
                      itemCount: cart.items.length)
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 1,
              child: Container(
                height: 170,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.15),
                          offset: Offset(0, -2),
                          blurRadius: 5.0)
                    ]),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'subtotal',
                            style: Theme.of(context).textTheme.bodyText1,
                          )),
                          Text(
                            '\$${cart.totalAmount}',
                            style: Theme.of(context).textTheme.subtitle1,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                            'TAX(10%)',
                            style: Theme.of(context).textTheme.subtitle1,
                          )),
                          Text(
                            '\$10',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        fit: StackFit.loose,
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(CheckoutScreen.routeName);
                              },
                              padding: EdgeInsets.symmetric(vertical: 14),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                              child: Text(
                                'Checkout',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              '\$${cart.totalAmount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .merge(TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/account.dart';
import 'package:ecommerce_app/screens/checkout_done.dart';
import 'package:ecommerce_app/widgets/credit_card.dart';
import 'package:ecommerce_app/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/Checkout';
  const CheckoutScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            UiIcons.return_icon,
            color: Theme.of(context).hintColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          ShoppingCartButton(
            iconColor: Theme.of(context).hintColor,
            labelColor: Theme.of(context).accentColor,
            labelCount: cart.itemCount,
          ),
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(300),
              onTap: () =>
                  Navigator.of(context).pushNamed(AccountScreen.routeName),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.avartar!),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  UiIcons.credit_card,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Payment Mode',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  'Select your prefered payment mode',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            SizedBox(height: 20),
            CreditCardsWidget(),
            SizedBox(height: 40),
            Text(
              'Or Checkout With',
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 320,
              child: FlatButton(
                onPressed: () {},
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Theme.of(context).focusColor.withOpacity(0.2),
                shape: StadiumBorder(),
                child: Image.network(
                  'https://www.goldtek.vn/wp-content/uploads/2020/12/logo-momo.png',
                  height: 28,
                  // width: 50,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 320,
              child: FlatButton(
                onPressed: () {},
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Theme.of(context).focusColor.withOpacity(0.2),
                shape: StadiumBorder(),
                child: Image.network(
                  'https://cdn.jobhopin.com/avatars/3aec1f1b-9d57-4e26-8109-7435e79c23d7.png',
                  height: 28,
                ),
              ),
            ),
            SizedBox(height: 20),
            Stack(
              fit: StackFit.loose,
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                SizedBox(
                  width: 320,
                  child: FlatButton(
                    onPressed: (cart.totalAmount <= 0 || _isLoading)
                        ? (){}
                        // ignore: unnecessary_statements
                        : () async {
                            print(cart.items.values.toList());
                            setState(() {
                              _isLoading = true;
                            });
                            await Provider.of<Orders>(context, listen: false)
                                .addOrder(
                              cart.items.values.toList(),
                              cart.totalAmount,
                            );
                            cart.clear();
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.of(context)
                                .pushNamed(CheckoutDoneScreen.routeName);
                          },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _isLoading
                          ? CircularProgressIndicator(strokeWidth: 100,)
                          : Text(
                              'Confirm Payment',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '\$${cart.totalAmount}',
                    style: Theme.of(context).textTheme.headline4!.merge(
                        TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
    final user = Provider.of<UserProvider>(context).user;
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
                backgroundImage: NetworkImage(user!.avartar!),
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
                  UiIcons.information,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  'Information Shipping',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Text(
                  'Check your order information ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Row(
                      children: <Widget>[
                        Icon(
                          UiIcons.placeholder,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Shipping Addresses :',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      user.address!,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Theme.of(context).focusColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/');
                    },
                    dense: true,
                    title: Row(
                      children: <Widget>[
                        Icon(
                          UiIcons.phone_call,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Phone',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    trailing: Text(
                      user.phone!,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Help');
                    },
                    dense: true,
                    title: Row(
                      children: [
                        Icon(
                          UiIcons.mail,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Email',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    trailing: Text(
                      user.email!,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 45,
                  height: 45,
                  child: InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      child: Image.network(
                        'https://www.goldtek.vn/wp-content/uploads/2020/12/logo-momo.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: InkWell(
                    onTap: () {},
                    child: Image.network(
                      'https://cdn.jobhopin.com/avatars/3aec1f1b-9d57-4e26-8109-7435e79c23d7.png',
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 45,
                  height: 45,
                  child: InkWell(
                    onTap: () {},
                    child: Image.network(
                        'https://apkjett.com/wp-content/uploads/2021/10/cash-pay.png'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Stack(
              fit: StackFit.loose,
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                SizedBox(
                  width: 320,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          // strokeWidth: 10,
                          )
                      : FlatButton(
                          onPressed: (cart.totalAmount <= 0 || _isLoading)
                              ? () {}
                              : () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await Provider.of<Orders>(context,
                                          listen: false)
                                      .addOrder(
                                    cart.items.values.toList(),
                                    cart.totalAmount,
                                    user.address!,
                                    user.email!,
                                    user.phone!,
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
                            child: Text(
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

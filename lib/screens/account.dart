import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/orders.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/favorite_list.dart';
import 'package:ecommerce_app/screens/orders.dart';
import 'package:ecommerce_app/widgets/change_password.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/profile_accounts.dart';
import 'package:ecommerce_app/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/account';
  AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final cartCount = Provider.of<Cart>(context, listen: false).itemCount;
    final orders =Provider.of<Orders>(context,listen: false);
    return Scaffold(
      key: _scaffoldState,
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _scaffoldState.currentState!.openDrawer();
          },
          icon: Icon(Icons.sort, color: Theme.of(context).hintColor),
        ),
        title: Text(
          'Account',
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: [
          ShoppingCartButton(
            iconColor: Theme.of(context).hintColor,
            labelColor: Theme.of(context).accentColor,
            labelCount: cartCount,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(300)),
            width: 30,
            height: 30,
            margin: EdgeInsets.only(top: 12.5, right: 12.5, bottom: 12.5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user!.avartar!),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name!,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          user.email!,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 55,
                    height: 55,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(300)),
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(user.avartar!)),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(FavoriteScreen.routeName),
                      child: Column(
                        children: [
                          Icon(UiIcons.heart),
                          Text(
                            'Favorite',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(FavoriteScreen.routeName),
                      child: Column(
                        children: [
                          Icon(UiIcons.favorites),
                          Text(
                            'Following',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(FavoriteScreen.routeName),
                      child: Column(
                        children: [
                          Icon(UiIcons.chat_1),
                          Text(
                            'Message',
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).primaryColor,
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
                children: [
                  ListTile(
                    leading: Icon(UiIcons.inbox),
                    title: Text(
                      'My Orders',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: ButtonTheme(
                      padding: EdgeInsets.all(0),
                      minWidth: 50.0,
                      height: 25.0,
                      child: FlatButton(
                        child: Text(
                          'View all',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        onPressed: () => Navigator.of(context)
                            .pushNamed(OrdersScreen.routeName,arguments: 0),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () =>
                        Navigator.of(context).pushNamed(OrdersScreen.routeName,arguments: 1),
                    dense: true,
                    title: Text(
                      'Ship yet',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Theme.of(context).focusColor)),
                      label: Text(
                        orders.orderShipYet.length.toString(),
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(OrdersScreen.routeName,arguments: 2);
                    },
                    dense: true,
                    title: Text(
                      'Shipping',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Theme.of(context).focusColor)),
                      label: Text(
                        orders.orderShipping.length.toString(),
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(OrdersScreen.routeName,arguments: 3);
                    },
                    dense: true,
                    title: Text(
                      'Shipped',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Chip(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: Colors.transparent,
                      shape: StadiumBorder(
                          side:
                              BorderSide(color: Theme.of(context).focusColor)),
                      label: Text(
                        orders.orderShipped.length.toString(),
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(OrdersScreen.routeName);
                    },
                    dense: true,
                    title: Text(
                      'In dispute',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10),
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  ListTile(
                    leading: Icon(UiIcons.user_1),
                    title: Text(
                      'Profile Settings',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    trailing: ButtonTheme(
                      padding: EdgeInsets.all(0),
                      minWidth: 50.0,
                      height: 25.0,
                      child: ProfileAccount(
                        onChanged: () {
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Full name',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      user.name!,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Email',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      user.email!,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Phone',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      user.phone!,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Gender',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      user.gender!,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Birth Date',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      DateFormat('yyyy-MM-dd').format(user.dateOfBirth!),
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  Consumer<Auth>(builder: (_,auth,__)=>ListTile(
                    onTap: () {
                      showDialog(context: context, builder: (context){
                        return ChangePasswordWidget(email: user.email,);
                      });
                    },
                    dense: true,
                    title: Text(
                      'Change password',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    trailing: Text(
                      '**********',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  )),
                  
                ],
              ),
            ),
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
                    leading: Icon(UiIcons.settings_1),
                    title: Text(
                      'Account Settings',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
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
                          'Shipping Addresses:',
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
                          UiIcons.planet_earth,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Languages',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    trailing: Text(
                      'English',
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      // Navigator.of(context).pushNamed('/Help');
                    },
                    dense: true,
                    title: Row(
                      children: <Widget>[
                        Icon(
                          UiIcons.information,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Help & Support',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

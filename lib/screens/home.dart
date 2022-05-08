import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/products.dart';
import 'package:ecommerce_app/providers/sliders.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/account.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/product_grib.dart';
import 'package:ecommerce_app/widgets/search_bar.dart';
import 'package:ecommerce_app/widgets/shopping_cart_button.dart';
import 'package:ecommerce_app/widgets/silders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String valSearch = '';
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  var _isInit = true;
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false).fetchAndSendProducts();
      Provider.of<SliderList>(context, listen: false).fetchSlider();
      Provider.of<UserProvider>(context, listen: false).fetchSetUser();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _selectedTab(int tabItem){
   
  }

  @override
  Widget build(BuildContext context) {
    void onChangedSearch(value) {
      if (value != null) {
        setState(() {
          valSearch = value;
        });
      }
    }

    final cart = Provider.of<Cart>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      key: _scafoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.headline4,
        ),
        leading: IconButton(
          icon: Icon(Icons.sort),
          onPressed: () => _scafoldKey.currentState!.openDrawer(),
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
              onTap: () {
                Navigator.of(context).pushNamed(AccountScreen.routeName);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.avartar!),
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: SearchBarWidget(
                    callback: (val) => onChangedSearch(val),
                  ),
                ),
                SliderWidget(),
                ProductGrid(
                  isFavor: false,
                  value: valSearch,
                )
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).accentColor,
        backgroundColor: Colors.transparent,
        iconSize: 22,
        elevation: 0,
        unselectedItemColor: Theme.of(context).hintColor.withOpacity(1),
        onTap: (int i){
        },
        items: [
          BottomNavigationBarItem(icon: Icon(UiIcons.bell), label: 'Notif'),
          BottomNavigationBarItem(icon: Icon(UiIcons.user_1), label: 'Account'),
          BottomNavigationBarItem(
              icon: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                          blurRadius: 40,
                          offset: Offset(0, 15)),
                      BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                          blurRadius: 13,
                          offset: Offset(0, 3))
                    ]),
                child: Icon(
                  UiIcons.home,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(icon: Icon(UiIcons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(UiIcons.heart), label: 'Favorite')
        ],
      ),
    );
  }
}

import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/providers/auth.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/products.dart';
import 'package:ecommerce_app/providers/select_color.dart';
import 'package:ecommerce_app/providers/select_size.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/account.dart';
import 'package:ecommerce_app/widgets/details_tab_widget.dart';
import 'package:ecommerce_app/widgets/information_tab_wiget.dart';
import 'package:ecommerce_app/widgets/shopping_cart_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailWidget extends StatefulWidget {
  static const routeName = '/product-detail';
  const ProductDetailWidget({Key? key}) : super(key: key);

  @override
  State<ProductDetailWidget> createState() => _ProductDetailWidgetState();
}

class _ProductDetailWidgetState extends State<ProductDetailWidget>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int _tabIndex = 0;
  int count = 0;
  // final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _tabController = TabController(
      length: 3,
      initialIndex: _tabIndex,
      vsync: this,
    );
    _tabController!.addListener(_handleTabSelection);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController!.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(
      context,
    )!
        .settings
        .arguments as String;
    final loadProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    final cart = Provider.of<Cart>(context);
    final user = Provider.of<UserProvider>(context).user;
    final auth = Provider.of<Auth>(context);
    final color = Provider.of<SelectColor>(context);
    final size = Provider.of<SelectSize>(context);
    return Scaffold(
      // key: _scaffoldkey,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.15),
                  blurRadius: 5,
                  offset: Offset(0, -2)),
            ]),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Consumer<Products>(
            builder: ((context, product, _) => FlatButton(
                  height: 50,
                  minWidth: 55,
                  onPressed: () {
                    product
                        .findById(productId)
                        .toggleFavorStatus(auth.token, auth.userId);
                  },
                  child: Icon(UiIcons.heart,
                      color: product.findById(productId).isFavorite!
                          ? Color.fromARGB(255, 239, 228, 8)
                          : Theme.of(context).primaryColor),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  color: Theme.of(context).accentColor,
                  shape: StadiumBorder(),
                )),
          ),
          SizedBox(
            width: 10,
          ),
          FlatButton(
              shape: StadiumBorder(),
              color: Theme.of(context).accentColor,
              onPressed: () => cart.addItem(
                  productId: productId,
                  price: loadProduct.price!,
                  name: loadProduct.name!,
                  urlImage: loadProduct.urlImage!,
                  color: color.getColor,
                  size: size.getSize),
              child: Container(
                child: Row(
                  children: [
                    Text(
                      'Add to Cart',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    IconButton(
                      onPressed: () => cart.removeSingleItem(productId),
                      icon: Icon(Icons.remove_circle_outline),
                      color: Theme.of(context).primaryColor,
                      iconSize: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    ),
                    Text(
                      '${cart.productCount(productId)}',
                      style: Theme.of(context).textTheme.subtitle1!.merge(
                          TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                    IconButton(
                      onPressed: () => cart.addItem(
                          productId: productId,
                          price: loadProduct.price!,
                          name: loadProduct.name!,
                          urlImage: loadProduct.urlImage!,
                          color:
                              // Colors.red,
                              color.getColor,
                          size: size.getSize),
                      icon: Icon(Icons.add_circle_outline),
                      color: Theme.of(context).primaryColor,
                      iconSize: 30,
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    ),
                  ],
                ),
              ))
        ]),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(
                UiIcons.return_icon,
                color: Theme.of(context).hintColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              ShoppingCartButton(
                  iconColor: Theme.of(context).hintColor,
                  labelColor: Theme.of(context).accentColor,
                  labelCount: cart.itemCount),
              Container(
                width: 30,
                height: 30,
                child: InkWell(
                  borderRadius: BorderRadius.circular(300),
                  onTap: () {
                    Navigator.of(context).pushNamed(AccountScreen.routeName);
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user!.avartar!),
                  ),
                ),
                margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
              )
            ],
            backgroundColor: Theme.of(context).primaryColor,
            expandedHeight: 350.0,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Hero(
                  tag: 'productId',
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(loadProduct.urlImage!)),
                          )),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Theme.of(context).primaryColor,
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0),
                              Theme.of(context).scaffoldBackgroundColor
                            ],
                                stops: [
                              0,
                              0.4,
                              0.6,
                              1
                            ])),
                      ),
                    ],
                  )),
            ),
            bottom: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).accentColor,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).accentColor),
              tabs: [
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.2),
                            width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Product'),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.2),
                            width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Detail'),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.2),
                            width: 1)),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Review'),
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Offstage(
              offstage: 0 != _tabIndex,
              child: Column(
                children: [
                  InformationTabWiget(
                    product: loadProduct,
                  )
                ],
              ),
            ),
            Offstage(
              offstage: 1 != _tabIndex,
              child: Column(
                children: [
                  DetailsTabWidget(productDetails: loadProduct.description)
                ],
              ),
            ),
            Offstage(
              offstage: 2 != _tabIndex,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        UiIcons.chat_1,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Product Reviews',
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}

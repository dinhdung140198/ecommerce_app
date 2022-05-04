import 'package:ecommerce_app/config/ui_icons.dart';
import 'package:ecommerce_app/models/route_argument.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/providers/categories.dart';
import 'package:ecommerce_app/widgets/shopping_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/category_product_grib.dart';

class CategoryProductsScreen extends StatefulWidget {
  static const routeName = '/categoryProducts';
  const CategoryProductsScreen({Key? key}) : super(key: key);

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  // int _tabIndex=0;
  late RouteArgument category;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    category = ModalRoute.of(context)!.settings.arguments as RouteArgument;
    Provider.of<Categories>(context).getProductByCategories(category.name!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = Provider.of<Cart>(context).itemCount;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            floating: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
                icon: Icon(
                  UiIcons.return_icon,
                  color: Theme.of(context).hintColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            actions: [
              ShoppingCartButton(
                  iconColor: Theme.of(context).hintColor,
                  labelColor: Theme.of(context).accentColor,
                  labelCount: cartCount),
              Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 12.5),
                child: InkWell(
                  borderRadius: BorderRadius.circular(300),
                  onTap: () {},
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://chico.ca.us/sites/main/files/imagecache/lightbox/main-images/dog_license.jpg'),
                  ),
                ),
              )
            ],
            expandedHeight: 350,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Hero(
                tag: '1',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            category.imageUrl!,
                          ),
                        ),
                      ),
                    ),
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
                ),
              ),
            ),
            // bottom: TabBar(tabs: [
            //   Tab(
            //     text: 'Home',
            //   ),
            //   Tab(
            //     text: 'Products',
            //   ),
            //   Tab(
            //     text: 'Reviews',
            //   )
            // ]),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Column(
              children: [
                CategoryProductGrid(),
              ],
            )
          ]))
        ],
      ),
    );
  }
}

import 'package:ecommerce_app/providers/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../models/product.dart';
import '../providers/products.dart';

class RatingBarWidget extends StatefulWidget {
  final dynamic product;
  final String? flag;
  const RatingBarWidget({Key? key, @required this.product, @required this.flag})
      : super(key: key);

  @override
  State<RatingBarWidget> createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  Product? productRate;
  Category? categoryRate;
  double? _rating;
  @override
  void initState() {
    _rating = widget.product!.rate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flag == 'product') {
      productRate = Product(
          id: widget.product!.id,
          name: widget.product!.name,
          price: widget.product!.price,
          description: widget.product!.description,
          urlImage: widget.product!.urlImage,
          rate: _rating,
          category: widget.product!.category,
          colors: widget.product!.colors,
          sizes: widget.product!.sizes,
          );
      Provider.of<Products>(context)
          .updateProduct(widget.product!.id!, productRate!);
    }
    if (widget.flag == 'category') {
      categoryRate = Category(
        id: widget.product!.id,
        nameCategory: widget.product!.nameCategory,
        image: widget.product!.image,
        rate: _rating,
      );
      Provider.of<Categories>(context).updateProduct(widget.product!.id, categoryRate!);
    }
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rating Bar',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 24.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RatingBar.builder(
              initialRating: widget.product!.rate!,
              minRating: 0,
              allowHalfRating: true,
              unratedColor: Colors.amber.withAlpha(50),
              itemCount: 5,
              itemSize: 50.0,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
              updateOnDrag: true,
            ),
            SizedBox(height: 20.0),
            Text(
              'Rating: $_rating',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

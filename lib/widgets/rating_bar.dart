import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';

class RatingBarWidget extends StatefulWidget {
  final Product? product;
  const RatingBarWidget({Key? key, this.product}) : super(key: key);

  @override
  State<RatingBarWidget> createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  Product? productRate;
  double? _rating ;
  @override
  void initState() {
    _rating = widget.product!.rate;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    productRate = Product(
        id: widget.product!.id,
        name: widget.product!.name,
        price: widget.product!.price,
        description: widget.product!.description,
        urlImage: widget.product!.urlImage,
        rate: _rating,
        category: widget.product!.category);
    Provider.of<Products>(context)
        .updateProduct(widget.product!.id!, productRate!);
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
